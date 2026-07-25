# SOP-006 Weekly Review

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO / Review Owner
- 적용 범위: GP Company 주간 경영 Review
- 적용 Decision: DEC-0009
- 작성일: 2026-07-23
- 다음 검토일: 2026-08-23

## 목적

매주 같은 기준시각의 Revenue·운영 Evidence를 검토해 가장 큰 병목 하나, 다음 주 우선순위
세 개, 필요한 CEO Decision과 Knowledge 환류를 확정한다.

## 일정과 완료 조건

- 일정: 매주 1회, 30~45분
- 완료: 데이터 상태, Primary KPI, 단일 Journey 병목, Campaign Decision, Owner·완료일과
  다음 Snapshot 기준일이 기록됨

데이터가 `BLOCKED`여도 Review를 취소하지 않는다. 숫자를 추정하는 대신 데이터 차단을
해결하는 일을 우선순위로 결정한다.

## 필수 입력

- 같은 기준시각의 SmartStore·아이디어스·주문·취소·환불·비용 Revenue Snapshot
- B2C 순매출·기여이익·재구매 매출 비중과 데이터 상태
- 진행 Campaign의 비용·revision·결과·Guardrail
- B2B 문의·견적·계약·입금과 생산·연구 주요 지연
- 고객 불만, 재고·현금·표현·개인정보 Guardrail
- 대표가 마케팅 분석·기획·승인·발행에 사용한 시간
- 미완료 업무, Agent·Automation 오류와 이전 주 Action

## 수행 단계

### 1. Snapshot 잠금

Review 시작 전에 기간, 기준시각, 원천 revision과 마지막 성공 수집을 고정한다. 회의 중
새로 들어온 주문은 다음 Snapshot에 반영한다.

### 2. 데이터 품질 Gate

누락·중복·환불, 광고비·수수료·할인·원가 범위와 reconciliation 차이를 확인하고 각
Metric을 `READY`, `PARTIAL`, `BLOCKED`, `NOT_AVAILABLE`로 표시한다. 누락값을 0으로
대체하지 않는다.

### 3. Primary KPI Review

순매출 → 기여이익 → 재구매 매출 비중 순으로 기준선과 비교한다. 신규 고객, 전환율,
객단가, CAC·ROAS와 채널 행동은 변동 원인을 진단하는 Driver로 사용한다.

### 4. 단일 병목 선택

SmartStore·아이디어스와 Acquisition→Referral 중 다음 주 매출에 가장 큰 영향을 줄 수
있는 병목 하나를 선택한다. 예상 Revenue Impact, 실행비용, 학습가치, 재고·현금과 위험을
함께 기록한다.

### 5. Campaign과 우선순위 결정

- 진행 Campaign: `SCALE`, `ITERATE`, `STOP`, `DATA_BLOCKED`
- 신규 Campaign: Brief Owner, 기준선, 측정일과 승인 필요사항
- 다음 주 우선순위: Revenue Impact, Owner와 완료일이 있는 세 개 이하

기준선·원천·Owner·승인 범위가 없으면 Campaign을 시작하지 않고 `BRIEF_BLOCKED`로 둔다.

### 6. CEO Decision과 안전 상태

예산·가격·할인·Claim·외부 발행·고객 발송·개인정보·고위험 자동화만 CEO Decision으로
올린다. 승인되지 않은 동안 유지할 가역적 안전 상태를 함께 기록한다.

### 7. Knowledge와 다음 Review 연결

새 Evidence를 EXPERIMENT·PRACTICE 후보·FAILURE·INSIGHT로 분류하고, 필요한
Knowledge·SOP·Decision 변경 후보와 다음 Snapshot 기준일을 지정한다.

## 승인과 권한

- CEO: 목표·예산·가격·정책·예외·고위험 실행 승인
- Review Owner: 승인된 기준 안의 우선순위와 Owner 지정
- Revenue Analytics Owner: 데이터 상태·산식·reconciliation 검증
- Agent: 승인된 Action 실행과 Evidence 제출

## 출력

- 완결된 `LEVEL-5_MANAGEMENT-CONTROL/WEEKLY-REVIEW/TEMPLATE.md`
- 다음 주 우선순위 세 개 이하와 Owner·완료일
- Campaign `SCALE/ITERATE/STOP/DATA_BLOCKED`
- CEO Decision 요청과 미승인 시 안전 상태
- Knowledge·SOP·Decision·Automation 후보

## 실패·예외

- 필수 원천 누락: `BLOCKED`, 매출 기여와 확대 판단 금지
- 원천 간 불일치: 관측값을 보존하고 차이·Owner·해결일 기록
- Review 미개최: Review Owner가 1영업일 안에 비동기 초안과 Decision 대기 항목 공유
- Owner 없는 Action: 우선순위로 확정하지 않음
- 지난주 Action 미완료: 원인·Revenue 영향·중단/재계획을 기록

## 관련 문서

- Decision: `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- KPI: `../../LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
- Dashboard: `../../LEVEL-5_MANAGEMENT-CONTROL/DASHBOARD.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- Marketing Experiment: `SOP-011_MARKETING-EXPERIMENT.md`
- Revenue Snapshot: `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`
