# KPI Framework

## Revenue First North Star

현재 단계의 North Star는 Hair·Scalp 사업의 `매출`과 `기여이익`이다. 신규 고객, 전환,
재구매와 추천은 North Star를 설명하는 Customer Journey Driver다.

Guardrail은 현금, 재고, 환불·불만, 화장품 표현, 개인정보와 브랜드 신뢰다. 매출이
증가해도 Guardrail을 악화시키면 성공으로 확정하지 않는다.

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
