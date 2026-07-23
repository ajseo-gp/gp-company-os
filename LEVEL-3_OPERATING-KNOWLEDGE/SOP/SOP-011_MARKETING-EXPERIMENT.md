# SOP-011 Marketing Revenue Experiment

- 상태: ACTIVE
- 버전: 1.0
- 소유자: Marketing Owner
- 적용 Workflow: WF-006 Revenue Growth Loop
- 적용 Decision: DEC-0009
- 작성일: 2026-07-23
- 다음 검토일: 2026-08-23

## 목적

모든 Marketing 실행을 매출 가설, 기준선, 승인, Evidence와 학습이 완결된 Campaign
단위로 운영해 성공과 실패를 다음 성장 주기에 재사용한다.

## 적용 범위

- SmartStore·아이디어스 상품·광고·쿠폰·상세 개선
- SEO, Blog, Shorts, SNS와 상세페이지 콘텐츠
- CRM 재구매·휴면 복귀 Campaign
- 리뷰·UGC·추천 Campaign

B2B 문의→수주 흐름은 `WF-001`을 우선하고, 마케팅 유입 Campaign만 이 SOP로 측정한다.

## 필수 입력

- Revenue 목표와 Customer Journey 단계
- 대상 고객, 제품·Offer, 채널과 하나의 우선 CTA
- 문제·가설과 이전 Knowledge
- 기준선, 목표 KPI, Guardrail, 산식·원천·측정일
- 예상 비용·할인·리소스와 rollback 가능성
- Owner, 실행 Agent와 승인권자
- attribution model·window 또는 직접 관측만 가능 표시

필수 입력이 없으면 수치를 추정해 채우지 않고 `BRIEF_BLOCKED`로 반환한다.

## 실행 단계

### 1. Revenue 병목 선택

채널·제품·Journey KPI에서 가장 큰 병목을 한 개 선택한다. 단순 아이디어보다 예상
Revenue Impact, 실행비용, 학습가치와 위험을 함께 본다.

### 2. Campaign Brief 작성

고유 `Campaign-ID`를 만들고 목적, 가설, 대상, Offer, 채널, revision, 기간, KPI,
Guardrail, 데이터 원천, 비용과 승인 Gate를 기록한다.

### 3. 기준선 검증

Revenue Analytics가 기간·제품·채널·주문 중복, 누락, 환불, 비용과 데이터 기준 시각을
확인한다. 기준선이 없으면 탐색 Campaign으로 표시하고 매출 개선률을 확정하지 않는다.

### 4. 승인

예산·할인·가격·Claim·외부 발행·고객 발송·개인정보 사용과 자동화 범위를 승인받는다.
승인 revision이 바뀌면 다시 검토한다.

### 5. 실행

담당 Agent가 승인된 scope에서 실행하고 실제 revision, 시작·중지 시각, 비용, 예외와
고객 영향을 Campaign 기록에 연결한다.

### 6. 측정

사전에 정한 측정일에 채널 행동, 주문·환불, 매출, 비용과 Guardrail을 수집한다. 직접
관측값, attribution 결과와 상관관계를 구분한다.

### 7. Revenue Review

- `SCALE`: 목표와 Guardrail을 충족하고 확대 조건이 명확함
- `ITERATE`: 유의미한 학습이 있으나 가설·Offer·대상·채널 수정이 필요함
- `STOP`: 기대 매출·기여이익·고객·브랜드 기준을 충족하지 못함

확대는 새로운 scope·예산·기간을 가진 Campaign revision으로 다시 승인한다.

### 8. Knowledge 환류

- 단일 실행 결과: EXPERIMENT
- 반복 재현된 방법: PRACTICE 후보
- 실패 조건과 재발 방지: FAILURE
- 반복 고객 행동·요구: INSIGHT

Knowledge Steward가 근거·신뢰·적용 범위·제외 범위를 검증한다.

### 9. 다음 행동

결과 Decision, SOP·Prompt·Workflow 변경 후보와 다음 Campaign 우선순위를 연결하고 종료한다.

## 승인 필요 지점

- Campaign 시작과 확대
- 신규·증액 광고비
- 가격·할인·쿠폰·증정
- 외부 게시·광고·고객 발송
- 신규 Claim, 비교·의학적 표현
- 고객·원가 데이터 접근과 attribution 변경
- 자동화 PILOT·ACTIVE 전환

## 출력물

- 완결된 Campaign Brief와 Campaign-ID
- 승인·실행 revision과 비용 기록
- Revenue·Guardrail KPI readout
- `SCALE`, `ITERATE`, `STOP`과 이유
- Knowledge·Decision·SOP·Automation 후보

## 실패·예외 처리

- 데이터 누락·중복: `DATA_BLOCKED`, 매출 기여 확정 금지
- 승인 범위 초과: 실행 중지, 영향·비용·복구 보고
- 비용·불만·법규·재고 위험: 긴급 중지 후 Owner escalation
- 채널 장애: 실행 상태 보존, 복구 후 측정기간 영향 표시
- 결과 미측정: 완료로 닫지 않고 Owner와 새 측정일 지정

## 보안

고객 PII, 채널 credential, 원가 원문과 주문 원문은 권한 저장소에 둔다. OS에는 집계,
안전한 참조 ID, 정의와 검증 결과만 남긴다.

## 관련 문서

- `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- `../../LEVEL-2_BUSINESS/MARKETING.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- `../../LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
