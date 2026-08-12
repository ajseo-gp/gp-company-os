# DEC-0018 Campaign-ID 발급과 운영 원본

- 상태: PROPOSED
- 결정일: 2026-08-13
- 적용일: 대표가 동일 revision을 승인하고 GPcompany OS main에 반영된 날
- 결정자/소유자: GP Company CEO
- 승인 근거: 2026-08-13 대표의 Campaign-ID 결정안 승인; 동일 문서 revision 검토 필요
- 적용 범위: Revenue Campaign·Experiment의 식별, 승인, 실행·측정 기록 연결
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

`DEC-0009`, `WF-006`과 `SOP-011`은 모든 매출 실행에 `Campaign-ID`를 기록하도록 요구하지만,
발급 형식·시점·주체·운영 원본과 대표실 업무 연결 규칙은 정하지 않았다. 이 공백 때문에
SmartStore Revenue Experiment를 대표 승인 카드에 올릴 때 식별자를 임의로 만들거나,
승인·실행·측정 기록이 서로 다른 업무처럼 분리될 위험이 있다.

Campaign-ID는 실행 코드가 편의상 만드는 문자열이 아니라 하나의 매출 가설이 승인,
외부 적용, 측정과 유지·되돌림 결정까지 같은 기록으로 이어지게 하는 회사 식별자다.

## 결정

### 1. 형식과 발급 시점

1. Campaign-ID 형식은 `CMP-YYYYMMDD-NNN`으로 통일한다.
2. 날짜는 발급 시점의 대한민국 표준시(`Asia/Seoul`)를 사용한다.
3. `NNN`은 같은 날짜 안에서 `001`부터 증가하는 세 자리 일련번호다.
4. CEO OFFICE가 완결된 Campaign 또는 Experiment revision으로 대표 승인 대기 카드를
   만들 때 Campaign-ID를 발급하고 상태를 `APPROVAL_PENDING`으로 기록한다.
5. 필수 입력이 없어 `BRIEF_BLOCKED` 또는 `DATA_BLOCKED`인 안건에는 Campaign-ID를
   발급하지 않는다.
6. 한 번 발급한 ID는 거절·취소·중단되더라도 재사용하거나 다른 Campaign에 재배정하지 않는다.

### 2. 발급 주체와 운영 원본

1. 사람에게 보이는 발급 주체는 GP Workbench의 **CEO OFFICE**다.
2. 번호 중복 방지, 상태 변경과 연결 기록의 운영 원본은
   `ajseo-gp/gp-company-hub`의 권한이 통제된 Campaign Registry다.
3. `gp-company-os`는 형식·권한·상태 규칙의 정본이며 개별 Campaign 실행 기록과 번호
   원장을 복사해 보관하지 않는다.
4. `ajseo-gp/gpcompany-lab`은 CEO OFFICE 승인 카드와 결과 화면을 제공하지만 별도의
   Campaign-ID를 만들거나 Hub 원장을 대체하지 않는다.
5. 동시 발급에서도 중복이 생기지 않아야 하며, 이미 처리한 동일 요청을 다시 동기화해도
   새 번호를 발급하지 않는 것이 구현 필수 조건이다.

### 3. 회사 업무와 revision 연결

1. 각 Campaign-ID는 Hermes가 소유한 정확히 하나의 `work_id`에 반드시 연결한다.
2. 같은 `work_id` 안에서 목적·대상·변수 또는 측정 구간이 다른 Campaign은 별도
   Campaign-ID를 가질 수 있다. 서로 다른 `work_id`가 하나의 Campaign-ID를 공유할 수는 없다.
3. 회사 Task-ID가 존재하면 함께 기록하되 `work_id`를 대신하지 않는다.
4. 승인 카드는 Campaign-ID, work_id, Task-ID(있는 경우), Campaign/Experiment revision,
   OS-Ref, 채널, 제품, 단일 변경 범위, 기준선·측정창, 승인 상태를 함께 고정한다.
5. 승인 뒤 위 값 중 실행 범위에 영향을 주는 값이 바뀌면 기존 승인은 무효가 되고 새
   revision으로 다시 승인받는다. 같은 Campaign의 수정이면 ID는 유지하고 revision 이력을
   추가하며, 목적·대상·변수가 달라진 새 실험이면 새 Campaign-ID를 발급한다.

### 4. 권한과 실행 경계

1. Campaign-ID 발급은 외부 실행 승인이나 쓰기 권한 부여가 아니다.
2. 실제 상품·가격·재고·광고·콘텐츠 변경은 해당 Campaign revision의 대표 승인과
   기존 Commerce Control Rules, 표현·데이터·rollback Gate를 모두 통과한 뒤에만 가능하다.
3. 가격·예산·계약·법률·규정·생산과 비가역 변경의 기존 대표 승인 Gate는 유지한다.
4. Campaign-ID, work_id 또는 승인 revision이 없는 controlled execution은 차단한다.
5. 운영 구현이 검증되기 전에는 형식에 맞는 번호를 사람이 임의 발급하거나 Pilot에
   소급 부여하지 않는다.

## 이유

대표는 CEO OFFICE에서 한 번 승인하고, Atlas는 같은 업무의 실행·측정·결과를 하나의
Campaign으로 보고해야 한다. 형식만 정하고 발급 원본을 정하지 않으면 중복과 소급 생성이
발생하고, 원본만 정하고 승인 revision을 묶지 않으면 다른 변경안이 승인된 것처럼 실행될
수 있다. 정책은 GPcompany OS, 운영 번호와 연결은 Hub, 사람용 화면은 Workbench로 역할을
분리하면 각 저장소의 원본 경계를 지키면서 전체 흐름을 추적할 수 있다.

## 영향 범위

### 적용

- SmartStore를 포함한 Revenue Campaign과 Marketing Experiment
- CEO OFFICE 승인 대기 카드와 Atlas 결과 보고
- Hub Campaign Registry의 발급·중복 방지·work_id/revision 연결
- Workbench의 Campaign-ID 표시, 승인 상태와 결과 이력
- Campaign별 실행 Evidence, 측정 결과와 `SCALE / ITERATE / STOP` 결정

### 비적용

- Campaign과 무관한 일반 회사 업무의 Task-ID·work_id 발급 규칙
- 개별 Campaign의 KPI 목표값, 가격·할인·광고 예산 또는 상품 변경안 결정
- Hub·Workbench의 구체적인 데이터베이스·API·UI 설계
- 이 Decision만으로 외부 채널 쓰기, 배포 또는 Runtime 권한을 활성화하는 것

## 결과와 Trade-off

- 승인 전부터 Campaign을 동일한 식별자로 추적할 수 있고, 거절·취소도 감사 가능한 이력으로 남는다.
- Hub 발급 원장이 준비되기 전에는 새 Campaign 승인 카드를 운영 상태로 만들 수 없다.
- 날짜별 일련번호를 쓰기 때문에 동시 발급과 반복 동기화에 대한 원자성·멱등성 검증이 필요하다.
- 한 work_id에 여러 Campaign이 연결될 수 있어 각 Campaign의 목적·대상·변수 구분이 필요하다.

## 전환과 검증

1. 이 Decision을 GPcompany OS main에 반영해 ACTIVE OS-Ref를 만든다.
2. Hermes가 같은 OS-Ref로 Hub와 Workbench에 별도 적용 업무를 전달한다.
3. Claude Code가 Hub Campaign Registry에 날짜별 순번, 중복 방지, work_id·revision 연결과
   상태 이력을 구현하고 충돌·재시도 검사를 통과시킨다.
4. Claude Code가 Workbench CEO OFFICE에 Hub가 발급한 ID와 정확한 승인 revision을 표시하고,
   Workbench 단독 발급이 불가능함을 검증한다.
5. SmartStore Revenue Pilot #1은 실제 상품 1개·변수 1개·기준선·변경 전후값·측정창이
   준비된 뒤 새 규칙으로 Campaign-ID를 발급해 `APPROVAL_PENDING` 카드로 올린다.
6. 대표 승인 전 외부 SmartStore 변경은 0건이어야 한다. 승인 후에도 실행 영수증,
   전후 snapshot, rollback payload, 제품 단위 KPI와 유지·되돌림 결정이 같은 Campaign-ID와
   work_id에 연결되어야 Pilot의 한 주기가 완료된다.

## 재검토 조건

- 하루 999건을 초과하거나 여러 발급 원장을 운영해야 하는 경우
- Hub 장애·복구 과정에서 번호 중복·건너뜀·재사용이 발생한 경우
- Campaign과 work_id의 관계를 1:1로 제한해야 할 운영 근거가 생긴 경우
- Campaign revision 변경이 승인 범위를 잘못 유지하거나 과도한 재승인을 만드는 경우
- 다른 시간대 또는 외부 Campaign 식별자와의 상호운용이 필요한 경우

## 관련 문서

- Business: `LEVEL-2_BUSINESS/MARKETING.md`, `LEVEL-2_BUSINESS/B2C.md`
- Context: `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/CURRENT-PRIORITIES.md`
- Decision: `DEC-0009_REVENUE-FIRST.md`, `DEC-0013_CHANNEL-LISTING-AUTOMATION.md`, `DEC-0017_CEO-OFFICE-AND-UNATTENDED-EXECUTION.md`
- Workflow: `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`, `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-009_COMPANY-OS-POLICY-PROPAGATION.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`, `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-016_COMPANY-OS-POLICY-LIFECYCLE.md`
- Agent/Automation: `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- KPI: `LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
