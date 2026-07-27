# Marketing

- 상태: ACTIVE
- 버전: 0.2
- 소유자: GP Company CEO / Marketing Owner
- 적용 Decision: DEC-0009
- 작성일: 2026-07-23
- 다음 검토일: 2026-08-23

## Revenue Objective

Marketing은 콘텐츠를 만드는 기능이 아니라 자격 있는 고객을 확보하고, 브랜드 이해,
구매, 재구매와 추천을 반복 가능하게 만드는 Revenue Engine이다.

- GP Company: Hair·Scalp 중심 소량 OEM 제조 파트너로 신뢰와 B2B 문의 확보
- 젠틀파파: 가족의 일상에서 출발한 Hair·Scalp 브랜드로 신규 구매와 재구매 성장

현재 우선 Runtime은 젠틀파파 B2C이며 B2B Marketing은 `WF-001`과 연결해 별도 Pipeline로
측정한다.

## Customer Journey

| 단계 | 핵심 질문 | 주요 수단 | 책임 Agent | 핵심 KPI |
|---|---|---|---|---|
| Acquisition | 자격 있는 신규 고객이 들어오는가 | SmartStore·아이디어스 노출, SEO, Blog, Shorts, SNS, 광고 | SmartStore, Idus, Content | 신규 방문, 신규 고객, CAC |
| Activation | 고객이 브랜드·제품 가치를 이해하는가 | 브랜드 스토리, 상세페이지, 콘텐츠, 랜딩 | Content, Channel Growth | 상품상세 진입, 체류·스크롤, 관심 행동 |
| Conversion | 관심이 주문과 기여이익으로 전환되는가 | 상품정보, Offer, 쿠폰, 광고·구매 동선 개선 | SmartStore, Idus | 전환율, 주문, 매출, 기여이익, ROAS |
| Retention | 구매 고객이 다시 구매하는가 | CRM, 재구매 Campaign, 후기 후속 | CRM | 재구매율, 복귀 고객, 재구매 매출 |
| Referral | 만족이 리뷰와 추천으로 확산되는가 | 리뷰, UGC, 공유, 추천 | Review & Referral | 후기 수집률, 유효 리뷰, 추천 주문 |

각 단계의 KPI는 다음 단계와 매출에 연결한다. 조회·발행량처럼 중간지표만 좋아진 Campaign은
성공으로 확정하지 않는다.

## Channel Responsibility

### SmartStore

- 검색·쇼핑 유입, 상품상세, 구매 동선, 광고, 쿠폰과 채널 내 재구매를 관리한다.
- 방문자, 전환율, 주문, 매출, 광고비, ROAS와 기여이익을 같은 기간·제품 기준으로 본다.
- 네이버 플랫폼 수치와 내부 주문·원가 수치의 기준 시각과 집계 차이를 기록한다.

### 아이디어스

- 작품 발견, 작가·브랜드 관심, 즐겨찾기, 후기, 신규 고객과 채널 매출을 관리한다.
- 신규 고객, 즐겨찾기, 전환율, 리뷰, 매출, 재구매와 기여이익을 본다.
- SmartStore의 전술을 근거 없이 복사하지 않고 아이디어스 고객 행동으로 별도 실험한다.

### Content and Organic

- SEO, Blog, Shorts와 SNS는 Acquisition·Activation을 담당한다.
- 콘텐츠마다 하나의 Journey 단계, 제품, CTA, Campaign-ID와 측정 가능한 다음 행동을 둔다.
- 콘텐츠 생산량보다 자격 있는 유입과 직접·보조 전환을 우선한다.

### CRM and Referral

- 구매 이력과 동의 범위 안에서 재구매·후기·추천을 운영한다.
- 고객 원문·연락처는 권한 저장소에 두고 OS에는 집계와 비식별 Insight만 남긴다.

## Campaign Unit

모든 Marketing 작업은 다음 Campaign 계약으로 운영한다.

1. Revenue 목표와 Customer Journey 단계
2. 대상 고객과 해결할 문제
3. 제품·Offer·채널과 하나의 우선 CTA
4. 기준선, 목표 KPI, Guardrail과 데이터 원천
5. 예산·할인·Claim·외부 발행 승인
6. 실행 revision과 `Campaign-ID`
7. 결과 측정일과 attribution model·window
8. `SCALE`, `ITERATE`, `STOP` Decision
9. EXPERIMENT·PRACTICE·FAILURE·INSIGHT 후보

목표 수치는 실제 기준선과 CEO Decision 없이 임의로 생성하지 않는다.

## Revenue Attribution

- 주문·매출·비용은 원천 시스템의 관측값을 우선한다.
- 직접 추적, 보조 전환, 모델 추정과 단순 상관관계를 구분한다.
- Campaign 기여 매출은 attribution model·window·제외 조건을 함께 표시한다.
- 동일 주문을 여러 Agent 성과로 중복 합산하지 않는다.
- 매출과 함께 할인·광고비·수수료·추적 가능한 변동비를 반영한 기여이익을 본다.

## Weekly Revenue Cycle

1. 채널·제품·Journey 단계별 매출 병목 확인
2. 기대 Revenue Impact와 실행비용으로 Campaign 우선순위 결정
3. Campaign Brief 승인
4. Agent 실행과 Human Gate
5. 채널·주문·비용 Evidence 수집
6. Revenue Review와 `SCALE`, `ITERATE`, `STOP`
7. Knowledge·Decision·SOP 갱신
8. 다음 주 Campaign에 학습 반영

## Approval and Guardrails

- 예산·할인·가격·쿠폰 범위, 외부 게시, 고객 발송과 신규 Claim은 승인받는다.
- ROAS가 좋아도 기여이익·현금·재고·브랜드 신뢰를 악화시키면 확대하지 않는다.
- 질병 치료, 탈모 치료와 확인되지 않은 효능을 단정하지 않는다.
- 고객 동의·수신 거부·개인정보 정책을 준수한다.

## Knowledge Feedback

- 반복 재현된 성공은 `PRACTICE`
- 가설·기간·변수·결과가 있는 단일 실행은 `EXPERIMENT`
- 실패 조건과 재발 방지는 `FAILURE`
- 반복 고객 행동과 요구는 `INSIGHT`

성과가 좋았다는 이유만으로 원인과 적용 범위를 확정하지 않는다.

## Related Execution

- Agent: `../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- Workflow: `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- SOP: `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- Content SOP: `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-005_CONTENT-PRODUCTION.md`
- KPI: `../LEVEL-5_MANAGEMENT-CONTROL/KPI.md`

## Unconfirmed Before PILOT

- 채널·제품별 기준선과 목표
- 승인 가능한 주간·월간 예산
- 가격·할인·쿠폰 범위
- attribution model과 window
- 채널 데이터 접근권한과 Owner
- CRM 동의·보존·발송 정책
