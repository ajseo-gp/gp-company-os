# SOP-008 Human Preview 승인과 자동 Release

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 담당: Hermes Primary, 담당 Worker, Release Automation
- 변경일: 2026-07-22

## 목적

사람이 실제 결과를 확인한 뒤 승인하면, 승인된 revision만 자동 merge·배포·검증한다.

## 적용 범위

- 웹·앱 UI, 랜딩페이지, 대시보드와 Workbench 변경
- 사람이 사용하는 업무 흐름과 자동화 인터페이스 변경
- 시각 UI는 없지만 운영 동작을 바꾸는 backend·infrastructure 변경

`DEC-0007`과 `SOP-009`의 GP Workbench Closed Beta Fast Lane에는 위험등급별 규칙을
우선 적용한다. `WB-LOW`는 사후 시각 보고, `WB-MEDIUM`·`WB-HIGH`는 배포 전 Human
Preview를 적용한다.

문서만 변경하는 작업은 직접 열 수 있는 rendered 문서 또는 변경 결과를 Preview로
간주할 수 있다. 단순 코드 diff만으로는 Human Preview Gate를 통과하지 않는다.

## 입력 정보

- `Task-ID`, `OS-Ref`, 승인등급
- 대상 저장소, 작업 branch와 target branch
- 정확한 40자리 revision SHA
- Preview URL 또는 검증 가능한 실행 artifact
- 자동 배포 target environment
- CI·smoke test와 rollback 정의
- 승인권자

## 실행 단계

### 1. 구현 revision 고정

1. Worker가 승인된 범위의 구현과 자체 검증을 완료한다.
2. 모든 파일을 commit하고 40자리 revision SHA를 고정한다.
3. 이후 생성되는 Preview·이미지·테스트 결과는 이 SHA와 연결한다.
4. revision이 바뀌면 기존 Preview 증거를 재사용하지 않는다.

### 2. Preview 생성

1. target branch에 merge하지 않은 상태로 branch 또는 commit 기반 Preview를 실행한다.
2. 대표가 PC나 휴대폰에서 직접 열 수 있는 URL을 준비한다.
3. 내부 시스템은 Tailscale 등 승인된 비공개 접근 경로를 우선한다.
4. 외부 공개 URL은 인증·만료·데이터 노출 조건을 확인한다.
5. Preview에 운영 비밀정보나 실제 고객정보를 사용하지 않는다.

Preview 환경이 없는 작업은 격리된 실행 결과나 검증 artifact를 제공한다.

### 3. 시각 검수 패키지 작성

최신 revision으로 다음을 만든다.

- Preview URL
- 대표 화면의 데스크톱·모바일 이미지
- 핵심 상호작용의 짧은 영상 또는 GIF가 필요한 경우 해당 파일
- 변경 전·후 요약
- 대표가 따라 할 검수 시나리오
- CI·테스트 결과
- 알려진 제한사항과 제외 범위
- 승인 후 target branch와 deploy environment

Hermes는 같은 Slack 스레드에 파일을 직접 업로드하거나 접근 가능한 링크를 제공한다.

### 4. Preview 준비 보고

```text
[PREVIEW:READY] <Task-ID>

Revision: <40자리-SHA>
Preview: <접근 가능한 URL 또는 artifact>
Visuals: <이미지·영상 링크 또는 Slack 파일>
검수 시나리오: <대표가 확인할 동작>
CI: <통과 여부와 증거>
승인 후: <target branch> 자동 merge → <environment> 자동 배포
제한사항: <없음 또는 목록>

승인: [HUMAN:APPROVED] <Task-ID> revision <40자리-SHA>
수정: [HUMAN:CHANGES_REQUESTED] <Task-ID> <요청 내용>
```

### 5. Human 검수

1. 승인권자는 링크를 직접 열고 검수 시나리오를 확인한다.
2. 수정이 필요하면 `[HUMAN:CHANGES_REQUESTED]`를 남긴다.
3. Worker는 수정 후 새 commit·Preview·시각 증거를 생성한다.
4. 만족하면 정확한 revision을 `[HUMAN:APPROVED]`로 승인한다.

이모지 반응, 모호한 “좋아요”, 다른 채널의 메시지는 Release 승인으로 해석하지 않는다.

### 6. 자동 Release Gate 검증

Release Automation은 승인 이벤트를 받으면 다음을 다시 확인한다.

1. `AUT-006` 상태가 `ACTIVE`인지 확인
2. 승인자 권한과 Slack 스레드
3. `Task-ID`, 저장소, branch, revision, environment 일치
4. 승인 후 commit 추가 여부
5. 필수 CI와 repository protection
6. merge conflict와 target branch 최신 조건
7. 배포·health check·rollback 설정

실패하면 merge하지 않고 `[RELEASE:BLOCKED]`와 정확한 조건을 보고한다.
자동화가 아직 `PLANNED`이면 수동 merge로 우회하지 않는다.

### 7. 자동 merge와 배포

1. 저장소에 정의된 merge 정책으로 승인 revision을 target branch에 merge한다.
2. merge commit SHA와 실행 ID를 기록한다.
3. 지정된 deployment pipeline을 자동 실행한다.
4. 배포 상태와 health check를 추적한다.
5. 성공하면 운영 URL에서 smoke test를 수행한다.

승인 후 merge와 배포 사이에 추가 사람 확인을 요구하지 않는다.

### 8. 결과 보고와 종료

```text
[RELEASED] <Task-ID>

Approved revision: <SHA>
Merge commit: <SHA>
Environment: <환경>
Deployment: <ID와 운영 URL>
Smoke test: PASS
Released at: <시각>
Rollback: not required
```

대표가 운영 결과를 확인한 뒤 `[REVIEW:CLOSED] <Task-ID>`로 작업을 종료한다.

## 실패·예외 처리

| 조건 | 처리 |
|---|---|
| Preview URL·artifact 없음 | `[BLOCKED:PREVIEW]`, merge 금지 |
| 이미지·동작 증거가 revision과 불일치 | 새 증거 생성, 승인 요청 금지 |
| 승인 후 새 commit | 승인 무효화, 새 Preview와 재승인 |
| AUT-006 미활성 | 표준 경로는 `[RELEASE:BLOCKED]`; `SOP-009` Fast Lane은 별도 계약 적용 |
| CI·보호 규칙 실패 | `[RELEASE:BLOCKED]`, merge 금지 |
| merge conflict | 자동 해결 금지, 수정 후 새 revision·Preview·승인 |
| merge 성공·배포 실패 | `[DEPLOY:FAILED]`, incident 기록과 정의된 rollback 수행 |
| smoke test 실패 | `[DEPLOY:FAILED]`, 정의된 rollback 수행 |
| rollback 성공 | `[ROLLED_BACK]`, 원인과 후속 작업 보고 |
| rollback 미정의·실패 | 추가 변경 금지, 대표에게 즉시 escalation |

## 승인 필요 지점

- Preview revision에 대한 `[HUMAN:APPROVED]`
- 기존 승인 범위 밖의 저장소·branch·환경 변경
- rollback 정의에 없는 수동 복구

승인된 revision의 merge·배포 자체에는 별도의 두 번째 승인이 필요하지 않다.

## 출력물

- Preview URL과 시각 검수 패키지
- Slack 승인 원문과 승인자 ID
- CI·merge·deployment·smoke test 실행 증거
- 운영 URL과 최종 상태
- 실패 시 rollback과 incident 기록

## 관련 문서

- `../DECISIONS/DEC-0006_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-004_PREVIEW-TO-RELEASE.md`
- `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-006_PREVIEW-APPROVAL-RELEASE.md`
- `../../TEMPLATES/HERMES-WORK-REQUEST.md`
- `SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
