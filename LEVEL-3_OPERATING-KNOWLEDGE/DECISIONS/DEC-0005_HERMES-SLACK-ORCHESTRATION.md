# DEC-0005 Hermes–Slack 오케스트레이션과 OS-Ref 고정

- 상태: ACTIVE
- 결정일: 2026-07-21
- 결정자: GP Company CEO
- 근거 작업: `GP-20260721-002`

## 배경

Mac mini 2018의 Hermes Gateway가 GPcompany Slack에서 운영 Primary로 가동 중임을
확인했다. 같은 장비의 `gp-marketing-auto/scripts/slack_bridge.py`는 GPmarketing의
별도 워크스페이스·봇·채널을 polling하는 독립 bridge이며 Hermes와 같은 Slack
이벤트를 중복 소비하지 않는다.

Mac mini에는 `gp-company-os` 로컬 clone이 없지만 GitHub 인증과 읽기 전용
`gh api`를 통해 Company OS 원본에 접근할 수 있다.

## 결정

1. GPcompany Slack은 사람과 Hermes 사이의 운영 요청·보고·검토 인터페이스로 사용한다.
2. Hermes Primary만 GPcompany Slack 작업을 수신하고 오케스트레이션한다. Standby나
   별도 bridge는 명시적 전환 없이 같은 작업에 응답하지 않는다.
3. 사람은 자연어로 요청한다. Hermes가 고유 `Task-ID`를 발급하고 운영 설정의 40자리
   commit SHA 형식 `OS-Ref`를 고정해 작업 envelope에 추가한다. 사람에게 이 값을
   입력하거나 복사하도록 요구하지 않는다.
4. Hermes는 생성한 `OS-Ref`에 고정된 `ajseo-gp/gp-company-os` 문서만 `gh api`로
   읽는다. 로컬 clone, 현재 `main`, 캐시된 문서를 기준 원본으로 대체하지 않는다.
5. 실행 중 `main`이 변경되어도 작업 기준은 바꾸지 않는다. 새 기준이 필요하면 현재
   작업을 종료하고 새 `Task-ID`와 `OS-Ref`로 후속 요청을 발행한다.
6. `[WORK_REQUEST]`, `[ACK]`, 상태 보고, `[RESULT]`, `[REVIEW]`,
   `[REVIEW:CLOSED]`는 하나의 Slack 스레드와 동일한 `Task-ID`로 연결한다.
7. GPmarketing bridge와 GPcompany Hermes는 서로 다른 운영 경계로 유지한다.
8. `DEC-0007`이 적용되는 GP Workbench Closed Beta 개발은 `gpwb_bot`과 로컬 Claude
   Code의 직접 실행 경로로 운영하며 Hermes가 필수 중계자나 Release gate가 되지 않는다.

## 책임 경계

| 시스템 | 책임 | 하지 않는 일 |
|---|---|---|
| GPcompany Slack | 작업 요청, 승인, 상태·결과·검토 대화 | Company OS 원본 보관 |
| Hermes Primary | 요청 검증, OS 문서 조회, 작업 분해·라우팅, 증거 보고 | 승인 범위를 넘는 결정, OS 원본 임의 변경 |
| `gp-company-os` | Decision·Context·SOP·Knowledge의 최상위 원본 | 실행 큐와 런타임 상태 관리 |
| `gp-company-hub` | 장비 배치, Hermes 운영 토폴로지와 실행 스펙 관리 | Company OS의 정책 원본 대체 |
| GP Workbench·GitHub | 작업 상태, 실행 로그, Issue·Branch·PR 증거 관리 | Company OS 정책 원본 변경 |
| `gpwb_bot`·Claude Code | Workbench Closed Beta 자연어 피드백의 구현·위험별 Release | Company OS·Hub 정책 변경, Hermes 업무 중복 실행 |
| GPmarketing bridge | GPmarketing의 `bot-relay`, `macmini` 채널 polling과 별도 relay | GPcompany Hermes 작업 수신·응답 |

## 통제 원칙

- Hermes 운영 설정의 활성 `OS-Ref`가 없거나 유효하지 않으면 실행하지 않고
  `[BLOCKED]`로 보고한다. 사람에게 SHA를 찾아 입력하도록 돌려보내지 않는다.
- 문서 우선순위는 Decision → Context → SOP → Knowledge → Prompt Library 순서다.
- 요청의 승인등급과 안전 제약은 원문 그대로 유지한다. 등급 의미가 현재 권한표에서
  확인되지 않으면 등급을 권한 확대 근거로 사용하지 않으며, 변경 권한이 불명확하면
  `[BLOCKED]`로 보고한다.
- 비밀값, 토큰, `.env`, 고객정보, 전체 네트워크 정보는 Slack·로그·결과에 출력하지 않는다.
- 외부 변경, 비가역 작업, 정책 예외와 승인 범위 초과는 대표 승인 전 실행하지 않는다.

## 재검토 조건

- Hermes Primary 또는 Slack workspace가 변경될 때
- Company OS 접근 방식이 `gh api` 외 방식으로 변경될 때
- GPmarketing bridge가 GPcompany workspace나 같은 이벤트 경로를 사용하게 될 때
- 중앙 작업 큐가 `Task-ID` 또는 `OS-Ref` 규약을 변경할 때

## 관련 문서

- `DEC-0001_OS-ARCHITECTURE.md`
- `DEC-0002_DOCUMENT-PRIORITY.md`
- `../SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`
- `DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
