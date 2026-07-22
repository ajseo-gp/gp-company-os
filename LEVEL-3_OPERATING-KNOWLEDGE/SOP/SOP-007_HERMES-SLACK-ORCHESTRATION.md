# SOP-007 Hermes–Slack 작업 오케스트레이션

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 담당: Hermes Primary
- 변경일: 2026-07-22

## 목적

Slack에서 접수한 작업을 고정된 Company OS 기준으로 검증·실행·보고하고, 중복 실행과
기준 드리프트를 방지한다.

## 적용 범위

- GPcompany Slack에서 Hermes Primary에 요청하는 운영·진단·개발·문서 작업
- Hermes가 Operator, Agent, Codex, Claude Code 또는 GitHub 작업으로 라우팅하는 요청
- `Task-ID`와 `OS-Ref`를 사용하는 Workbench·GitHub 연계 작업

GPmarketing의 `slack_bridge.py` relay 업무에는 적용하지 않는다.

## 입력 정보

필수 입력은 다음과 같다.

- `Task-ID`: `GP-YYYYMMDD-NNN` 형식의 고유 ID
- 목적과 완료 조건
- 업무 영역
- 승인등급
- `OS-Ref`: `ajseo-gp/gp-company-os@<40자리 commit SHA>`
- 실행 범위와 금지 범위
- 필수 점검 또는 산출물
- 결과 보고 형식

누락된 필수 입력은 추정하지 않는다.

## 표준 작업 요청

```text
@Hermes [WORK_REQUEST] <Task-ID> · <업무영역> · 승인등급 <등급>

목적
<목적과 완료 조건>

OS-Ref
ajseo-gp/gp-company-os@<40자리-SHA>

실행 범위
• <허용된 작업>

안전 제약
• <금지된 작업>

필수 결과
• 종합 판정 또는 완료 상태
• 항목별 증거
• 발견된 위험과 예외
• 승인 필요한 다음 조치
• 개발 작업이면 Preview URL과 시각 검수 자료

먼저 같은 스레드에 [ACK]를 남기고, 완료 후 [RESULT]로 보고하세요.
```

전체 복사용 양식은 `TEMPLATES/HERMES-WORK-REQUEST.md`를 사용한다.

## 실행 단계

### 1. 요청 식별과 중복 방지

1. Slack 원문에서 `Task-ID`, 스레드, 요청자, 승인등급을 식별한다.
2. 같은 `Task-ID`의 열린 작업이 있는지 작업 큐와 현재 스레드에서 확인한다.
3. 이미 실행 중이면 새 작업을 시작하지 않고 기존 작업 위치와 상태를 보고한다.
4. 요청을 수락할 수 있으면 같은 스레드에 `[ACK] <Task-ID>`를 남긴다.

### 2. OS-Ref 검증

1. 저장소가 정확히 `ajseo-gp/gp-company-os`인지 확인한다.
2. ref가 축약 SHA, 브랜치명 또는 `latest`가 아닌 40자리 commit SHA인지 확인한다.
3. 다음 읽기 전용 명령으로 commit 존재와 정확한 SHA를 확인한다.

```bash
gh api repos/ajseo-gp/gp-company-os/commits/<OS_SHA> --jq .sha
```

4. 응답 SHA가 요청 SHA와 다르거나 접근이 실패하면 실행하지 않고 `[BLOCKED]`로
   원인만 보고한다.
5. 진단 목적이면 현재 `main` SHA를 별도로 조회해 drift를 알릴 수 있지만 작업 기준을
   자동 변경하지 않는다.

```bash
gh api repos/ajseo-gp/gp-company-os/commits/main --jq .sha
```

### 3. 고정 SHA 문서 읽기

항상 `?ref=<OS_SHA>`를 지정한다. 먼저 `OS-INDEX.yaml`과 관련 Decision을 읽고,
Decision → Context → SOP → Knowledge → Prompt Library 순서로 필요한 문서만 조회한다.

```bash
gh api -H 'Accept: application/vnd.github.raw+json' \
  'repos/ajseo-gp/gp-company-os/contents/OS-INDEX.yaml?ref=<OS_SHA>'

gh api -H 'Accept: application/vnd.github.raw+json' \
  'repos/ajseo-gp/gp-company-os/contents/<PATH>?ref=<OS_SHA>'
```

경로 탐색이 필요하면 같은 SHA의 tree를 읽는다.

```bash
gh api 'repos/ajseo-gp/gp-company-os/git/trees/<OS_SHA>?recursive=1' \
  --jq '.tree[].path'
```

금지되는 fallback:

- `?ref=`를 생략해 기본 브랜치를 읽는 것
- 로컬 clone의 현재 checkout을 OS 기준으로 간주하는 것
- 이전 작업의 문서 본문이나 모델 기억을 재검증 없이 사용하는 것
- 접근 실패를 일반 지식이나 추정으로 보완하는 것

### 4. 범위·승인 게이트 확인

1. 목적, 허용 작업, 금지 작업과 결과 계약을 실행 체크리스트로 변환한다.
2. 관련 Decision과 충돌하면 실행을 멈추고 충돌 문서 경로를 보고한다.
3. 승인등급의 권한 범위가 확인되지 않으면 등급을 권한 확대 근거로 사용하지 않는다.
   명시된 범위의 읽기 전용 확인은 수행할 수 있지만, 변경 권한이 불명확하면
   `[BLOCKED]`로 보고한다.
4. 외부 발송·공개, 계약·법률·규정 판단, 정책 예외, 비가역 변경은 명시적 승인 전
   실행하지 않는다.

### 5. 실행과 상태 보고

1. 승인된 범위 안에서 최소 권한으로 작업한다.
2. 장기 작업은 같은 스레드에 `Task-ID`, 현재 단계, 경과시간, 차단 여부만 간결하게
   보고한다.
3. Worker에 라우팅해도 `Task-ID`, `OS-Ref`, 승인등급, 금지 범위와 출력 계약을 그대로
   전달한다.
4. 재시도는 동일 작업을 중복 실행하지 않도록 기존 실행 ID와 부작용을 먼저 확인한다.

### 6. 결과와 Preview 인계

결과는 같은 스레드에 다음 순서로 남긴다.

```text
[RESULT] <Task-ID>

종합 상태: PASS | WARN | BLOCKED | COMPLETED
OS-Ref: ajseo-gp/gp-company-os@<OS_SHA>
실행 범위: <실제로 수행한 범위>
증거: <명령 결과, 로그 요약, Issue/PR/Workbench 참조>
위험·예외: <없음 또는 목록>
변경 사항: <없음 또는 변경 요약>
승인 필요: <없음 또는 구체적 항목>
```

요청자는 `[REVIEW]`로 추가 검증·수정을 요청하거나 `[REVIEW:CLOSED] <Task-ID>`로
종료한다. Hermes는 종료 후 같은 요청을 다시 실행하지 않는다.

사람이 사용하는 기능을 개발한 작업은 `[RESULT]`만으로 종료하지 않는다. 구현 revision을
고정한 뒤 `SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`에 따라 Preview URL과 이미지·
동작 증거를 제공하고, `[HUMAN:APPROVED]` 이후 자동 merge·배포로 인계한다.

## 승인 필요 지점

- 요청에 정의된 권한 범위를 넘는 변경
- 외부 공개·발송, 계약, 결제, 법률·규정 판단
- 서비스 중단, 재시작, 프로세스 종료, 데이터 삭제·덮어쓰기
- Company OS Decision·SOP·권한표 변경
- Primary 전환 또는 여러 Hermes 인스턴스의 동시 활성화

## 출력물

- Slack 원문 스레드의 ACK·상태·RESULT·REVIEW 기록
- Workbench 또는 GitHub의 동일 `Task-ID` 작업 기록
- 사용한 정확한 `OS-Ref`와 문서 경로 목록
- 변경이 있으면 Issue·Branch·Draft PR 또는 승인된 실행 증거
- 개발 작업이면 Preview URL, 시각 검수 패키지와 자동 Release 결과

## 실패·예외 처리

| 조건 | 처리 |
|---|---|
| `Task-ID` 없음 | `[BLOCKED]`와 누락 항목 보고 |
| `OS-Ref` 없음·형식 오류 | 실행 금지, 정확한 SHA 요청 |
| GitHub 인증·접근 실패 | 재시도 남발 금지, 접근 실패 증거와 복구 조건 보고 |
| OS 문서 충돌 | Decision 우선, 충돌 경로와 승인 필요사항 보고 |
| 동일 `Task-ID` 중복 요청 | 기존 작업에 연결하고 중복 실행 금지 |
| Primary 상태 불명 | 실행 금지, Primary 소유권 확인 요청 |
| Slack 연결 단절 | Workbench·GitHub에 상태를 보존하고 연결 복구 후 같은 스레드에 보고 |
| 부분 실행 후 실패 | 완료·미완료·부작용을 분리해 WARN 또는 BLOCKED로 보고 |
| 개발 결과의 Preview 없음 | `[BLOCKED:PREVIEW]`, merge·배포 금지 |

## 보안과 로그

- 토큰, 비밀번호, `.env`, 인증서, 고객정보, 원가정보를 출력하지 않는다.
- 앱·토큰 비교가 필요하면 값이나 fingerprint 대신 `동일`/`상이` 판정만 기록한다.
- 전체 환경변수, 전체 프로세스 인자, 전체 네트워크 목록을 그대로 게시하지 않는다.
- 로그는 필요한 시간 범위와 오류 유형만 요약하고 비밀정보를 마스킹한다.
- 모든 증거에는 `Task-ID`, `OS-Ref`, 실행 주체, 시각을 연결한다.

## 관련 Decision·Agent·Workflow

- `../DECISIONS/DEC-0005_HERMES-SLACK-ORCHESTRATION.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`
- `../../TEMPLATES/HERMES-WORK-REQUEST.md`
- `SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `ajseo-gp/gp-company-hub/agents/roles.md` — 현재 승인등급 실행 매트릭스
