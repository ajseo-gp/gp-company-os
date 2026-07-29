# DEC-0015 무인 실행과 Decision Digest

- 상태: ACTIVE
- 결정일: 2026-07-29
- 적용일: 2026-07-29
- 결정자/소유자: GP Company CEO
- 적용 범위: Hermes가 조정하는 장기 작업과 Claude Code의 개발·데이터·상거래 자동화
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

이미 승인된 저위험 구현과 규칙 범위 안의 상거래 실행도 사람이 즉시 응답하지 않으면
멈추는 구조가 대표의 시간과 Revenue 실행 속도를 다시 병목으로 만든다. 반대로 질문을
없앤다는 이유로 가격·예산·외부 쓰기와 고위험 변경의 기존 Gate를 해제하면 안 된다.

Claude Code의 사용량 또는 대화 Context가 리셋되더라도 모델 대화 자체가 아니라
`Task-ID`, 고정 `OS-Ref`, repository revision과 검증 Evidence를 기준으로 다음 Worker가
안전하게 이어받아야 한다.

## 결정

1. 기본 무인 실행 창은 `22:00-08:00 KST`로 한다. 대표가 응답할 수 없는 다른 시간에도
   같은 규칙을 적용할 수 있으며, 허용된 작업은 특정 세션이 아니라 작업 큐가 계속 소유한다.
2. 무인 실행 창에는 다음 작업을 추가 질문 없이 계속할 수 있다.
   - `WB-LOW`
   - 읽기·분석·dry-run인 `L0`
   - 채널별 첫 승인과 필수 Gate를 이미 통과한 `L1`
   - 활성 `Commerce Control Rules` 안의 `L2`·`L3`
   - 이미 승인된 완료 조건 안의 테스트·CI·rollback 검증
3. 다음 항목은 즉시 질문하지 않고 `DECISION_QUEUE`에 넣은 뒤, 영향받지 않는 다른
   `READY` 작업을 계속한다.
   - 규칙 밖 가격·할인·예산 판단
   - 해결되지 않은 정책 충돌
   - 신규 채널·신규 SKU 활성화
   - 완료 조건을 바꾸는 기능 확대
   - 자동 rollback이 성공한 실패의 재개 조건
4. 다음 항목은 해당 실행을 즉시 멈추고 부작용을 격리한다. 다른 독립 작업까지 함께
   멈추지는 않는다.
   - 결제·환불·정산·계정·권한 변경
   - `WB-HIGH`
   - 고객정보·credential·처방·원가 원문 노출 위험
   - 예산 초과
   - 화장품 표현 Gate 미통과
   - rollback 실패 또는 비가역적 외부 변경
5. `DECISION_QUEUE`는 `08:00 KST`에 한 번의 `DECISION DIGEST`로 전달한다. 필요하면
   `18:00 KST`에 추가 1회를 보낼 수 있다. 한 Digest는 최대 10개 항목이며 각 항목은
   질문, 확인된 배경, 선택지, 권고안과 미결정 시 기본 동작을 포함한다.
6. 작업 재개에 필요한 checkpoint에는 최소한 다음을 기록한다.
   - `Task-ID`, `Direction-Profile`, 정확한 40자리 `OS-Ref`
   - repository, branch와 마지막 검증 revision
   - 완료·미완료 단계, 실행한 테스트와 결과
   - 발생한 외부 부작용과 rollback 상태
   - 다음 실행 조건과 첫 번째 다음 행동
   - 승인 대기 항목과 영향받지 않는 계속 가능 작업
7. Claude Code 사용량 한도는 우회하지 않는다. 사용량 한도에 도달하면 작업을
   `WAITING_FOR_QUOTA`로 checkpoint하고, 허용량이 복구된 뒤 새 Worker 또는 명시적으로
   재개한 세션이 같은 작업을 이어받는다. 별도 과금 API·usage credit 자동 전환은
   승인된 비용 상한이 없으면 금지한다.
8. Company 운영 큐의 단일 Primary는 Hermes다. Orca를 사용할 경우 Hermes가 고정한
   `Task-ID`·`OS-Ref`·권한 범위 안에서 Claude Code Worker의 dispatch, heartbeat,
   `worker_done`과 재개를 감독하는 하위 실행 조정자로 사용한다. Orca와 Hermes가 같은
   작업을 각각 Primary로 소유하지 않는다.
9. 구현·데이터·API·테스트·배포의 작업 소유자는 `DEC-0012`에 따라 Claude Code다.
   정책 변경이 필요하면 Claude Code가 Codex 작업으로 직접 반환하며 대표에게 파일 복사,
   SHA 전달 또는 도구 선택을 요구하지 않는다.

## 이유

승인된 범위의 실행은 밤에도 계속하면서 대표에게는 권한 확대와 실제 사업 판단만 묶어서
올릴 수 있다. 대화 세션이 아닌 외부 checkpoint를 기준으로 삼으면 사용량 리셋, Context
압축, 프로세스 재시작에도 작업이 중복되거나 사라지지 않는다.

## 영향 범위

### 적용

- Hermes 장기 작업 큐와 Slack 상태 보고
- Claude Code의 Workbench·Hub·B2C 자동화 작업
- Orca를 사용하는 Worker DAG와 재개
- 대표 Decision Digest

### 비적용

- 이 Decision은 기존 가격·예산·표현·외부 쓰기 권한을 새로 부여하지 않는다.
- `Commerce Control Rules`가 없는 `L2`·`L3` 외부 쓰기를 허용하지 않는다.
- 결제·환불·정산·계정·권한 변경을 자동화하지 않는다.
- Claude Code 사용량 제한을 우회하거나 무제한 비용 집행을 허용하지 않는다.
- 같은 branch를 Codex와 Claude Code가 공동 소유하도록 허용하지 않는다.

## 전환과 검증

1. Hermes 작업 상태에 `DECISION_QUEUE`와 `WAITING_FOR_QUOTA`를 추가한다.
2. Claude Code Worker가 종료·한도 도달·실패 전에 checkpoint를 남기는지 검증한다.
3. Orca를 사용할 경우 단일 Hermes Task와 Orca dispatch가 동일 `Task-ID`에 연결되는지
   확인한다.
4. 1주간 새벽 즉시 질문 수, 아침 Digest 항목 수, 중복 실행, checkpoint 없는 중단과
   대표 응답 대기시간을 측정한다.
5. 성공 기준은 승인 범위 안 작업의 불필요한 즉시 질문 0건, checkpoint 없는 작업 유실
   0건, 동일 Task 중복 실행 0건과 기존 고위험 Gate 위반 0건이다.

## 재검토 조건

- 무인 실행에서 외부 오등록·예산 초과·민감정보 노출·중복 실행이 발생할 때
- Digest가 10개를 반복 초과하거나 대표의 실제 결정 부담을 줄이지 못할 때
- Hermes Primary 또는 Orca Runtime 구조가 변경될 때
- Claude Code의 사용량·과금·background-agent 방식이 변경될 때

## 관련 문서

- Direction: `../../LEVEL-1_DIRECTION/MISSION.md`, `../../LEVEL-1_DIRECTION/VISION.md`
- Business: `../../LEVEL-2_BUSINESS/B2C.md`, `../../LEVEL-2_BUSINESS/MARKETING.md`
- Decision: `DEC-0009_REVENUE-FIRST.md`, `DEC-0012_AI-WORK-ALLOCATION.md`,
  `DEC-0013_CHANNEL-LISTING-AUTOMATION.md`
- SOP: `../SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`,
  `../SOP/SOP-014_COMMERCE-CONTROL-RULES.md`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
