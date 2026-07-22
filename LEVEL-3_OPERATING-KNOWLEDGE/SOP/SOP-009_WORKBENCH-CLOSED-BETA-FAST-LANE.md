# SOP-009 GP Workbench Closed Beta Fast Lane

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 담당: `gpwb_bot`, 로컬 Claude Code
- 변경일: 2026-07-22

## 목적

대표와 연구원이 자연어와 이미지로 Workbench 개선을 요청하면 Claude Code가 위험을
분류하고 구현·검증·Release·시각 보고까지 처리한다.

## 적용 범위

- 저장소: `ajseo-gp/gpcompany-lab`
- 환경: GP Workbench Closed Beta
- 입력: 지정 Workbench Slack 채널 또는 대표가 직접 연 로컬 Claude Code 세션

다른 회사 운영, B2C·B2B·OEM 실행, Company OS와 Hub 변경에는 적용하지 않는다.

## 사람 입력

사람은 다음만 제공하면 된다.

- 원하는 결과 또는 불편한 점을 자연어로 설명
- 필요한 경우 이미지·화면 위치·재현 방법
- 우선순위나 완료 희망 시점이 중요한 경우 해당 정보

사람에게 Task-ID, OS-Ref, 상태 태그, branch명, commit SHA 또는 명령어 입력을 요구하지
않는다.

## 시스템 생성 정보

`gpwb_bot` 또는 Claude Code가 자동으로 생성·기록한다.

- Task-ID와 요청자 Slack ID
- 요청 원문·스레드와 첨부파일 참조
- 저장소, branch, base revision과 적용 OS-Ref
- 위험등급 `WB-LOW`, `WB-MEDIUM`, `WB-HIGH`
- 구현 revision, 테스트, release와 rollback 기록

## 실행 단계

### 1. 접수와 범위 확인

1. 기존 열린 요청과 중복인지 확인한다.
2. 같은 피드백이면 기존 작업에 연결하고 중복 branch를 만들지 않는다.
3. 완료 조건과 변경 화면을 한두 문장으로 요약해 스레드에 접수 사실을 알린다.
4. 질문 없이 합리적으로 진행 가능한 저위험 요청은 바로 구현한다.

### 2. 위험 분류

`DEC-0007`의 위험 표를 적용한다. 인증·권한·비밀정보·결제·실제 데이터 쓰기·migration·
삭제·인프라 변경이 포함되면 `WB-LOW`로 처리하지 않는다.

### 3. 구현

1. Claude 소유 branch를 생성하고 다른 Agent branch에 commit하지 않는다.
2. 요청 범위에 필요한 최소 변경만 수행한다.
3. 실제 고객·처방·원가 데이터 대신 합성 또는 안전한 테스트 데이터를 사용한다.
4. 관련 lint, typecheck, build와 기능 테스트를 수행한다.

### 4. Release 결정

- `WB-LOW`: 필수 검증 통과 후 Claude가 자체 승인하고 merge·deploy한다.
- `WB-MEDIUM`: 변경 영역 PC·모바일 Preview와 영향 요약을 제공하고 지정 사용자 승인을
  받은 뒤 merge·deploy한다.
- `WB-HIGH`: 구현 또는 운영 변경 전에 CEO 명시 승인과 필요한 보안 검토를 받는다.

승인 의도는 자연어에서 `gpwb_bot`이 구조화한다. 모호하면 배포하지 않고 짧게 확인한다.

### 5. 배포 검증과 보고

1. 운영 URL에서 변경 경로와 핵심 동작을 smoke test한다.
2. 변경된 부분만 보이도록 PC·모바일 이미지를 각각 준비한다.
3. 같은 요청 스레드에 다음을 자연어로 보고한다.

```text
완료: <변경 요약>
확인: <운영 URL>
화면: <PC·모바일 변경 영역 이미지>
검증: <build·test·smoke 결과>
버전: <revision>
문제 발생 시: <rollback 상태 또는 복구 방법>
```

내부 상태 태그와 Task-ID는 로그에 유지하되 사람이 복사해 입력하도록 요구하지 않는다.

### 6. 후속 피드백

사람이 자연어로 추가 수정을 남기면 기존 Task-ID에 재작업으로 연결한다. 이미 배포된
저위험 변경의 수정은 새 revision으로 같은 절차를 반복한다. 범위가 다른 기능이면 새
Task-ID를 생성한다.

## 실패·예외 처리

| 조건 | 처리 |
|---|---|
| 로컬 Claude Code 인증 실패 | 실행 중단, 인증 복구 조건만 보고; 별도 과금 API로 자동 전환 금지 |
| build·test 실패 | merge·deploy 금지, 실패 원인과 다음 조치 보고 |
| 위험 분류 불명확 | 한 단계 높은 등급 적용 |
| 배포·smoke 실패 | 정의된 rollback 또는 안전 차단 후 결과 보고 |
| 동일 branch를 다른 Agent가 수정 | 실행 중단, 소유권 분리 후 재개 |
| Company OS 정책 변경 필요 | Workbench 코드에서 결정하지 않고 Codex·OS 작업으로 분리 |

## 출력물

- 자연어 접수·완료 메시지
- Task-ID, 요청자, branch, revision, 위험등급을 포함한 내부 작업 기록
- 테스트·배포·smoke·rollback 증거
- PC·모바일 변경 영역 이미지와 운영 URL

## 관련 문서

- `../DECISIONS/DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-005_WORKBENCH-DIRECT-DEVELOPMENT.md`
- `SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
