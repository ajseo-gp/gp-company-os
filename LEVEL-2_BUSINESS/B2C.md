# B2C Business

**Status:** ACTIVE

## Brand

젠틀파파는 아빠의 두피 고민에서 시작해 가족의 일상에서 제품을 검증하는 Hair·Scalp 중심 브랜드다.

### GentlePapa Canon Authority

- GP Company OS는 GentlePapa를 B2C 핵심 브랜드 도메인으로 등록한다.
- 브랜드 세계관·콘텐츠·제품 역할·고객 VOC의 단일 Canon 원본은
  `ajseo-gp/gp-company-hub/brands/gentlepapa`다.
- 공식 부팅 진입점은 `brands/gentlepapa/BOOT.md`다.
- Company OS는 GentlePapa 세계관 원문을 복제하지 않고 Authority와 실행 계약만 소유한다.
- GentlePapa 관련 Task는 시작 시 Hub `main`의 정확한 40자리 SHA를
  `GentlePapa-Canon-Ref`로 고정한다.
- 같은 Task/Campaign의 Content, Publisher, SmartStore 등 소비자가 서로 다른 Canon SHA를
  사용하면 `CANON_REVISION_MISMATCH`로 외부 실행 전에 차단한다.
- 제품·커머스 실행은 승인된 Current Product Brief가 없으면
  `CANON_PRODUCT_BRIEF_REQUIRED`로 Campaign 발급 전에 차단한다.
- 이 규칙의 정책 근거는 `DEC-0019`이며, `DEC-0019`가 ACTIVE가 되기 전에는 제안 상태다.

## Core Growth Loop

Acquisition → Activation → Conversion → Retention → Referral → Evidence → Knowledge → 개선

## Operating Model

- `gp-company-os`가 B2C 전략, 정책, KPI 정의와 승인 게이트의 원본이 된다.
- Growth Orchestrator가 Journey 병목을 Campaign과 작업으로 분해하고 전문 Agent를 지휘한다.
- 실행 Agent는 분석, 고객 인사이트, 캠페인, 콘텐츠, 커머스와 표현·브랜드 QA를 담당한다.
- SmartStore와 아이디어스는 별도 Growth Agent가 채널별 고객 행동·매출·기여이익을 책임진다.
- 모든 Campaign은 Journey 단계, Campaign-ID, 제품, 비용과 Revenue Evidence를 가진다.
- GP Workbench는 작업 큐, 진행 상태, 승인함, 실행 로그, KPI와 피드백을 관리한다.
- 대표에게는 정책 예외, 승인 범위 초과, 고위험 또는 되돌리기 어려운 항목만 올린다.

## Priority Metrics

- 신규 고객과 Customer Acquisition Cost
- 제품별 매출
- 구매전환율
- 객단가
- 재구매율
- 리뷰 수와 평점
- 채널별 유입
- 채널·Campaign별 직접 매출과 기여 매출
- 채널·Campaign별 기여이익
- 프로모션별 수익성
- 캠페인별 목표 달성
- 고객 피드백의 제품·콘텐츠 반영률
- 대표 승인과 재작업 건수

## Operating Rules

- 할인은 매출이 아니라 기여이익 기준으로 평가한다.
- 신제품보다 기존 제품 재구매 구조 개선을 우선 검토한다.
- 상세페이지와 콘텐츠의 표현은 화장품 광고 안전 기준을 따른다.
- 고객 리뷰의 불편사항은 Knowledge와 제품 개선 후보로 저장한다.
- 고객 원문과 개인정보는 권한이 분리된 시스템에 보관하고 OS에는 검증된 요약만 반영한다.
- 목표값, 예산, 할인 범위와 자동 게시 권한은 별도 Decision 없이 추정하지 않는다.
- 직접 매출, attribution model에 따른 기여 매출과 단순 상관관계를 구분한다.
- 동일 주문을 여러 채널·Agent 성과로 중복 집계하지 않는다.
