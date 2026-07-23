# DEC-0009 Revenue First 운영 우선순위

- 상태: ACTIVE
- 결정일: 2026-07-23
- 적용일: 2026-07-23
- 결정자/소유자: GP Company CEO
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

GP Company OS는 운영체계로서 성장하고 있지만 현재 회사의 가장 큰 병목은 운영 구조가
아니라 매출이다. 시스템 완성도를 높이는 작업이 신규 고객, 구매, 재구매 또는 대표의
마케팅 병목 감소와 연결되지 않으면 현재 단계의 우선순위가 아니다.

`DEC-0004`의 이중 수익 엔진은 유지한다. 이번 결정은 Hair·Scalp 사업의 Revenue Engine과
Marketing Runtime을 먼저 구축하고, 내부에서 매출 효과가 검증된 이후 B2B 자동화,
연구·생산 고도화와 Company OS 외부 상품화를 진행하도록 실행 순서를 조정한다.

## 결정

1. GP Company OS의 현재 최상위 실행 원칙을 `Revenue First`로 한다.
2. 모든 신규 설계·Agent·Automation은 신규 고객, 제품 판매, 재구매, 대표의 마케팅 병목
   또는 반복 가능한 성장에 대한 기여 경로를 먼저 설명한다.
3. Business 계층의 B2C Revenue Engine을 Customer Journey로 운영한다.
   - Customer Acquisition
   - Customer Activation
   - Customer Conversion
   - Customer Retention
   - Customer Referral
4. 마케팅은 단일 범용 Agent가 아니라 KPI와 인계가 명확한 전문 Agent 팀으로 설계할 수 있다.
5. SmartStore와 아이디어스는 고객 행동, 데이터와 운영 수단이 다르므로 별도 Growth Agent
   책임으로 분리한다.
6. 모든 마케팅 실행은 `Campaign-ID`, Journey 단계, 채널, 제품, 비용, 기간, Evidence와
   결과 KPI를 기록한다.
7. 관측 가능한 직접 매출과 모델에 따른 기여 매출을 구분한다. 승인된 attribution
   model·window가 없으면 추정 매출을 사실처럼 보고하지 않는다.
8. 매출 증가는 기여이익, 현금, 브랜드 신뢰, 화장품 표현, 개인정보와 고객 경험을
   훼손하지 않는 범위에서 추구한다.
9. Company OS의 실행 우선순위를 다음과 같이 둔다.
   1. Revenue Engine 구축
   2. Marketing Agent 운영
   3. B2B 자동화
   4. 생산 및 연구 운영 고도화
   5. Company OS 외부 제품화

## 이유

현재 단계에서 가장 가치 있는 Company OS는 문서를 가장 많이 가진 OS가 아니라 고객을
확보하고 판매·재구매를 만들며, 그 결과를 다음 실행에 재사용하는 OS다. 채널·고객 여정별
전문 역할은 대표가 직접 수행하던 분석·기획·제작·성과 검토를 분리하고, 각 병목과 KPI를
명확하게 만든다.

## 영향 범위

### 적용

- Business와 B2C 운영 우선순위
- Marketing Agent Architecture와 Runtime 순서
- Content·Growth·CRM·Review·Analytics Workflow
- KPI·Dashboard·Weekly Review와 Automation 우선순위
- Knowledge의 Experiment·Failure·Insight 축적
- Workbench의 Campaign·Journey·Revenue Evidence 연결

### 비적용

- 매출을 이유로 보안, 법률·규정, 화장품 표현, 개인정보와 승인 Gate를 우회하지 않는다.
- 근거 없는 할인, 광고비, Claim, 재고 또는 생산 결정을 자동 승인하지 않는다.
- `DEC-0004`의 두 수익 엔진과 장기적인 양도 가능 회사 목표를 폐기하지 않는다.

## 결과와 Trade-off

- 단기적으로 Architecture 정리와 외부 Company OS 상품화의 우선순위가 낮아진다.
- Marketing Agent와 매출 데이터 연결에 더 많은 설계·운영 자원을 배정한다.
- Agent 수는 증가할 수 있지만 각 Agent는 Journey, KPI, SOP와 인계가 없으면 생성하지 않는다.
- 매출 기여 추적을 위해 Campaign·채널·제품·비용·주문의 최소 데이터 품질이 필요하다.

## 전환과 검증

1. Business·Marketing·B2C 문서에 Customer Journey Revenue Engine을 반영한다.
2. Marketing Growth Team과 SmartStore·아이디어스 책임을 분리한다.
3. Revenue Growth Workflow와 Marketing Experiment SOP를 연결한다.
4. KPI·Dashboard를 고객 여정과 채널 매출 중심으로 바꾼다.
5. 첫 PILOT 전에 KPI 정의, 데이터 원천, 기준선, Owner와 승인 범위를 확정한다.
6. 최소 한 번의 완전한 Campaign 주기를 실행하고 Evidence→Knowledge→Decision 환류를 검증한다.

## 재검토 조건

- 매출 병목이 공급·생산능력·현금·품질 병목으로 바뀔 때
- Marketing Agent의 비용 또는 재작업이 매출 기여보다 커질 때
- SmartStore·아이디어스 외 채널이 주요 매출 비중을 차지할 때
- attribution model이나 고객 데이터 처리정책을 변경할 때
- Company OS 외부 제품화의 고객·매출 근거가 확보될 때

## 관련 문서

- Business: `LEVEL-2_BUSINESS/BUSINESS.md`, `LEVEL-2_BUSINESS/B2C.md`, `LEVEL-2_BUSINESS/MARKETING.md`
- Context: `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/CURRENT-PRIORITIES.md`
- Workflow: `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- Agent: `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- KPI: `LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
