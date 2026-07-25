# KPI Framework

- 상태: ACTIVE
- 버전: 0.2
- 소유자: GP Company CEO / Revenue Analytics Owner
- 적용 범위: Hair & Scalp Revenue Engine, Weekly Revenue Review
- 적용 Decision: DEC-0009
- 기준일: 2026-07-23
- 다음 검토일: 2026-08-23

## Revenue First North Star

현재 단계의 North Star는 Hair·Scalp 사업의 `매출`과 `기여이익`이다. 신규 고객, 전환,
재구매와 추천은 North Star를 설명하는 Customer Journey Driver다.

Guardrail은 현금, 재고, 환불·불만, 화장품 표현, 개인정보와 브랜드 신뢰다. 매출이
증가해도 Guardrail을 악화시키면 성공으로 확정하지 않는다.

## CEO Weekly Scorecard

주간 Review는 많은 숫자를 동일한 중요도로 나열하지 않고 다음 순서로 판단한다.

| 구분 | Metric | 주간 결정 |
|---|---|---|
| Primary 1 | B2C 순매출 | 매출이 기준선보다 증가·감소한 원인과 우선 채널 |
| Primary 2 | B2C 기여이익 | 광고·할인·수수료·변동비를 고려해 확대 가능한 매출인지 |
| Primary 3 | 재구매 매출 비중 | 신규 고객 의존 없이 반복 매출이 성장하는지 |
| Driver | 신규 고객·신규 고객 매출 | Acquisition이 실제 구매로 이어지는지 |
| Driver | 채널 전환율·객단가 | 방문 이후 가장 큰 Conversion 병목 |
| Driver | CAC·ROAS | 유료 Acquisition의 비용 효율 |
| Guardrail | 환불·불만·재고·현금 | 매출 성장이 고객·운영 안정성을 훼손하는지 |

Primary와 Guardrail을 먼저 보고, Driver는 변동 원인을 설명하고 다음 Campaign을 고르는 데
사용한다. 조회수·발행량·클릭은 Primary KPI가 아니다.

## Canonical Metric Definitions — B2C PILOT

실제 원천 필드가 확인되기 전에는 아래 이름을 원천 시스템 컬럼명으로 간주하지 않는다.
Revenue Analytics Owner가 채널별 원천 필드를 매핑하고 Finance Owner가 비용 처리를
검토한 뒤 `READY`로 전환한다.

| ID | 정의와 계산 | 최소 원천 | 갱신 | Owner |
|---|---|---|---|---|
| `REV-NET` | 결제완료 상품금액에서 취소·환불 상품금액을 차감한다. 할인 반영 여부, 배송비와 VAT 포함 여부는 `revenue_basis`에 고정한다. | 채널 주문·취소·환불 | 일간/주간 잠금 | Revenue Analytics |
| `REV-CONTRIBUTION` | `REV-NET - 매출원가 - 미반영 판매자 할인 - 플랫폼·결제 수수료 - 광고비 - 추적 가능한 배송·포장 변동비`. 같은 비용을 두 번 차감하지 않는다. | 주문·승인 원가·비용 | 주간 | Revenue Analytics + Finance |
| `REV-REPEAT-SHARE` | 재구매 고객 `REV-NET ÷ 전체 REV-NET`. 승인된 안정적 비식별 고객키가 없으면 `BLOCKED`다. | 주문·비식별 고객키 | 주간 | Revenue Analytics |
| `ACQ-NEW-CUSTOMER` | 측정기간 첫 구매일이 해당 기간 안에 있는 고유 고객 수. 채널 간 동일인 통합은 승인된 키가 있을 때만 한다. | 주문·비식별 고객키 | 주간 | Channel Growth |
| `ACQ-CAC` | 해당 Acquisition Campaign 비용 ÷ 직접 추적 가능한 신규 고객. 추적 불가 고객을 임의 배분하지 않는다. | Campaign 비용·신규 주문 | Campaign 종료 | Channel Growth + Analytics |
| `CONV-RATE` | 같은 채널·기간의 결제완료 주문 수 ÷ 승인된 방문자 수. 채널 원천 정의가 다르면 교차 채널 합산하지 않는다. | 채널 방문·주문 | 일간/주간 | Channel Growth |
| `CONV-AOV` | `REV-NET ÷ 결제완료 주문 수` | 주문·취소·환불 | 일간/주간 | Revenue Analytics |
| `ADS-ROAS` | 직접 추적 광고매출 ÷ 광고비. attribution window와 환불 반영 여부를 함께 표시한다. | 광고·주문 | Campaign 종료 | Channel Growth + Analytics |
| `REFUND-RATE` | 취소·환불 상품금액 ÷ 결제완료 상품금액 | 주문·취소·환불 | 주간 | Customer / Channel Growth |

`REV-NET`의 VAT·배송비 기준과 `REV-CONTRIBUTION`의 승인 원가·변동비 범위는 첫
PILOT 전에 Finance Owner와 CEO가 확정한다. 확정 전에는 원천별 관측값을 보존하고
기여이익을 추정하지 않는다.

## Minimum Revenue Dataset

Revenue Snapshot의 최소 grain은 `기준일 × 채널 × 제품`이다. Campaign과 고객 Segment는
근거가 있을 때만 추가한다.

| 필드 그룹 | 필수 항목 | 원천 권위 |
|---|---|---|
| 식별 | 기준일, 기준시각, 채널, 제품 ID, 원천 revision | 승인된 채널·상품 Master |
| 주문 | 결제완료 주문·수량·상품금액, 취소·환불 | SmartStore·아이디어스 주문 원천 |
| 고객 | 신규·재구매 구분에 필요한 비식별 키 | 승인된 고객/주문 원천 |
| 채널 행동 | 방문자, 상품상세 행동, 즐겨찾기·리뷰 등 채널 고유 행동 | 각 채널 Analytics |
| 비용 | 광고비, 수수료, 할인, 승인 원가, 추적 가능한 변동비 | 광고·정산·Finance 승인 원천 |
| Campaign | Campaign-ID, Journey, 기간, revision, attribution 조건 | GP Workbench Campaign Register |
| 품질 | 누락·중복·지연, reconciliation 차이, `data_status` | Revenue Snapshot 검증 로그 |

실제 데이터·고객 PII·credential·원가 원문은 권한 저장소에 둔다. OS에는 정의, 안전한
참조와 집계 상태만 둔다.

정산 리포트는 수수료·부가세·판매자 부담금·지급금 reconciliation에 사용한다. 구매일과
정산기준일이 다른 정산대상 파일을 주문 발생 기준 매출 원천으로 대체하거나, 같은 기간의
주문 매출과 합산하지 않는다.

## Data Status

모든 Revenue 숫자는 값과 함께 다음 상태 중 하나를 표시한다.

| 상태 | 의미 | 사용 가능 범위 |
|---|---|---|
| `READY` | 필수 원천·기간·산식·중복·환불 검증 완료 | CEO Review와 Campaign Decision |
| `PARTIAL` | 일부 원천·기간·비용이 누락됐으나 범위가 명시됨 | 방향성 관찰만 가능 |
| `BLOCKED` | 필수 원천·정의·권한 또는 reconciliation 문제 | 매출 기여·확대 판단 금지 |
| `NOT_AVAILABLE` | 해당 채널이 제공하지 않거나 아직 수집하지 않음 | 0으로 대체 금지 |

`0`은 관측 결과가 실제 0인 경우에만 사용한다. 누락과 접근 불가를 0으로 기록하지 않는다.

## Baseline and Target Rule

1. 첫 기준선은 가능한 경우 최근 완료된 28일을 사용하고, 주간 값은 동일 요일 구성을 가진
   직전 4주 중앙값과 함께 본다.
2. 프로모션, 품절, 가격변경, 채널 장애처럼 비교를 왜곡하는 사건을 표시한다.
3. 기준선이 없으면 Campaign을 `EXPLORATORY`로 표시하고 개선률을 확정하지 않는다.
4. 목표는 기준선, 재고·현금·마진, 실행 레버와 기간을 검토한 CEO Decision으로 확정한다.
5. 채널 간 정의가 다르면 합산값보다 채널별 값을 우선하고 차이를 문서화한다.

## Revenue PILOT Entry Gate

다음을 모두 확인하기 전에는 Marketing Agent를 `PILOT`으로 전환하지 않는다.

- SmartStore·아이디어스의 승인된 주문·취소·환불·광고·행동 데이터 원천과 Owner
- 데이터 접근권한, 기준시각, 보존 위치와 PII 처리
- 제품 ID·채널 ID·주문 상태의 매핑과 중복 제거 규칙
- `REV-NET` 기준과 기여이익 비용 범위
- 최소 28일 또는 확보 가능한 전체 기간의 기준선과 데이터 상태
- 첫 대상 제품·Journey 병목·Campaign Owner·예산·승인 Gate

## Customer Journey KPI

| 단계 | Outcome KPI | Driver KPI | 대표 질문 |
|---|---|---|---|
| Acquisition | 신규 고객, 신규 고객 매출, CAC | 신규 방문, 자격 있는 유입, 채널별 클릭 | 어떤 채널이 구매 가능성이 있는 고객을 데려오는가 |
| Activation | 활성 고객의 구매·보조 전환 | 상품상세 진입, 체류·스크롤, 관심 행동 | 고객이 브랜드와 제품 가치를 이해하는가 |
| Conversion | 주문, 매출, 기여이익 | 전환율, 객단가, 장바구니·구매 동선 | 관심이 수익성 있는 주문이 되는가 |
| Retention | 재구매율, 재구매 매출·기여이익 | 복귀 고객, 구매 간격, CRM 반응 | 만족 고객이 다시 구매하는가 |
| Referral | 추천 주문·매출 | 후기 수집률, 유효 리뷰, UGC·공유 | 만족이 신규 신뢰와 구매로 이어지는가 |

## Marketing Agent KPI

| Agent | Primary KPI | Guardrail / Quality KPI |
|---|---|---|
| Growth Orchestrator | 총매출, 기여이익, 신규 고객, 재구매 매출 | Campaign 완료율, 대표 병목시간, 학습 재사용 |
| SmartStore Growth | 방문자, 전환율, 주문, 매출, ROAS, CAC, 기여이익 | 환불·불만, 할인율, 재고 위험 |
| Idus Growth | 신규 고객, 즐겨찾기, 전환율, 리뷰, 매출, 기여이익 | 환불·불만, 채널 정책 위반 |
| Content | 발행 완료율, 자격 있는 유입, 다음 행동, 직접·보조 전환 | 표현 오류, 재작업, 제작 리드타임 |
| CRM Retention | 재구매율, 재구매 매출, 휴면 복귀 | 수신 거부·불만, 개인정보 위반 |
| Review & Referral | 후기 수집률, 유효 리뷰, 추천 주문 | 보상·표시 위반, 고객 불만 |
| Revenue Analytics | 데이터 완전성, Campaign 연결률, 리포트 정확도·적시성 | 중복 매출, 미정의 지표, 미확인 attribution |

Agent KPI는 같은 주문을 중복 합산하지 않는다. Primary KPI 결과에 기여한 중간지표는
Driver로 표시한다.

## Revenue Measurement Contract

각 KPI는 다음을 가진다.

- 이름, 계산식, 단위, 원천 시스템과 기준 시각
- Journey, 채널, 제품, Campaign-ID와 Owner
- 갱신 주기, 기준선, 목표와 목표 승인자
- attribution model·window·제외 조건
- 직접 관측, 기여 추정 또는 상관관계 구분
- 환불·취소·광고비·수수료·할인·추적 가능한 변동비 처리

## Revenue Engine 1 — Hair & Scalp Business

| 영역 | 핵심 KPI | 목적 |
|---|---|---|
| B2B | 문의 수, 응답시간, 견적률, 계약률, 평균 계약액, 재발주율 | 제조 매출 전환과 고객 유지 |
| R&D | 연구 접수 수, 연구 리드타임, 레시피 확정률, 샘플 조정 횟수, 목표 원가 도달률 | 고객 요구의 생산 가능한 제품 전환 |
| B2C | 제품별 매출, 전환율, 객단가, 재구매율, 기여이익 | 브랜드 성장과 고객가치 |
| Production | 리드타임, 불량률, 로스율, 납기 준수율 | 생산 안정성 |
| Marketing | Journey·채널별 신규 고객, 전환, 매출, 기여이익, 재구매·추천 | 반복 가능한 Revenue Growth |

## Revenue Engine 2 — AI & Company OS Business

| 영역 | 핵심 KPI | 목적 |
|---|---|---|
| Pipeline | 문의 수, 제안률, 계약률 | 외부 매출 전환 |
| Revenue | 구축 매출, 반복 매출, 프로젝트별 기여이익 | 독립 수익 엔진 검증 |
| Adoption | 도입 완료율, 활성 사용, 핵심 Workflow 실행 | 제품 사용과 정착 |
| Customer Outcome | 시간 절감, 오류 감소, 고객이 승인한 성과 지표 | 효과 검증 |
| Productization | 공통 기능 비중, 고객별 맞춤 작업 비중, 재사용률 | 반복 가능한 제품화 |

## Company Transferability

| 영역 | 핵심 KPI | 목적 |
|---|---|---|
| CEO Dependency | 대표 직접 반복업무, 대표 승인 건수, 위임 완료율 | 핵심인물 의존 감소 |
| Operating System | SOP 적용률, Agent 완료율, 재작업률, 오류율 | 실행 재현성 |
| Repository Governance | OS 동기화율, 미반영 Decision, 변경 추적률 | 통제 원본 일치 |
| Asset Readiness | 코드·브랜드·계약·데이터 소유권 확인율 | 인수 가능한 자산 구축 |

## Finance

| 영역 | 핵심 KPI | 목적 |
|---|---|---|
| Cash | 현금잔고, 미수금, 고정비 커버 | 생존과 유동성 |
| Profitability | 수익 엔진별 매출, 총이익, 기여이익 | 사업별 수익성 |
| Concentration | 고객별·채널별 매출 비중 | 집중 위험 관리 |

## Rule

- 정의와 데이터 원천이 없는 숫자는 KPI로 사용하지 않는다.
- 각 KPI는 계산식, 단위, 원천, 담당자, 갱신 주기와 연결된 의사결정을 가져야 한다.
- 목표값은 실제 기준 데이터와 CEO Decision 없이 임의로 설정하지 않는다.
- 고객 성과는 고객이 승인하거나 객관적으로 확인 가능한 근거로 측정한다.
- 매출과 attribution 기반 기여 매출을 구분하고 model·window 없이 기여를 확정하지 않는다.
- 조회·발행·클릭 같은 중간지표만으로 Revenue Campaign 성공을 확정하지 않는다.

## Related Documents

- Decision: `../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0009_REVENUE-FIRST.md`
- Business: `../LEVEL-2_BUSINESS/MARKETING.md`
- Workflow: `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- SOP: `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-006_WEEKLY-REVIEW.md`,
  `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- Automation: `../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`
