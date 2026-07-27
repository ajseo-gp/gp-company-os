# Prompt: SmartStore 상품 진단 및 Dry-run 개선안

- 상태: REVIEW
- 버전: 0.1
- 소유자: Marketing Owner
- 작성일: 2026-07-25
- 적용 범위: SmartStore 상품정보·상세·혜택의 진단과 Dry-run 제안
- Runtime 허용: PILOT 준비용 제안만, 실제 수정 금지

## 목적

현재 상품정보와 Revenue Evidence를 근거로 SmartStore의 Journey 병목을 진단하고, 수정
사유·근거·KPI·위험·원복 조건이 포함된 검토 가능한 개선안을 만든다.

## Required References

우선순위에 따라 다음을 읽는다.

1. `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
2. `../CONTEXT/CURRENT-PRIORITIES.md`
3. `../SOP/SOP-011_MARKETING-EXPERIMENT.md`
4. `../SOP/SOP-005_CONTENT-PRODUCTION.md`
5. `../KNOWLEDGE/PRACTICE-0001_SMARTSTORE-OPERATING-GUIDE.md`
6. `../KNOWLEDGE/GENTLEPAPA-BRAND.md`
7. `../KNOWLEDGE/COSMETIC-CLAIMS-GUIDE.md`
8. `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`

`REVIEW` Knowledge는 확정 성공 공식이 아니라 조사된 기준과 PILOT 가설로만 사용한다.

## 입력

- `OS-Ref`: {{OS_REF}}
- `Campaign-ID`: {{CAMPAIGN_ID}}
- `상품 참조 ID`: {{PRODUCT_REF}}
- `현재 revision`: {{CURRENT_REVISION}}
- `현재 상품정보`:
  - 상품명: {{CURRENT_TITLE}}
  - 카테고리: {{CATEGORY}}
  - 브랜드·제조사: {{BRAND_MANUFACTURER}}
  - 속성·옵션: {{ATTRIBUTES_OPTIONS}}
  - 검색 적용 태그: {{APPLIED_TAGS}}
  - Page Title·Meta description: {{SEARCH_METADATA}}
  - 대표이미지·상세 revision: {{CONTENT_REVISION}}
  - 가격·할인·쿠폰·배송: {{OFFER}}
- `제품 Evidence`: {{PRODUCT_EVIDENCE}}
- `분석기간·비교기간·기준시각`: {{MEASUREMENT_WINDOW}}
- `채널 Evidence와 품질 상태`: {{CHANNEL_EVIDENCE}}
- `주문·취소·환불 Evidence`: {{ORDER_EVIDENCE}}
- `광고·비용·기여이익 Evidence`: {{COST_EVIDENCE}}
- `변경 이력`: {{CHANGE_HISTORY}}
- `목표 KPI·Guardrail`: {{KPI_GUARDRAIL}}
- `승인자·측정일`: {{APPROVER_MEASURE_DATE}}

## 실행 지시

1. 입력 누락과 `READY/PARTIAL/BLOCKED/NOT_AVAILABLE` 상태를 먼저 검사한다.
2. 상품 사실, 공식 채널 기준, 관측 Evidence와 해석·가설을 분리한다.
3. Acquisition·Activation·Conversion·Retention 중 가장 근거가 강한 병목 하나를 고른다.
4. 병목의 가능한 원인과 반증 Evidence를 함께 제시한다.
5. 우선 변경 변수 하나를 선택한다. 여러 변수를 묶으면 이유와 측정 한계를 표시한다.
6. 상품명은 키워드 나열로 만들지 않는다. 브랜드·카테고리·속성 전용 필드를 우선한다.
7. 제품 Evidence에 없는 효능·저자극·안전·비교·의학적 표현을 만들지 않는다.
8. 가격·할인·쿠폰은 비용·중복 조건·기여이익 Evidence가 없으면 제안만 하고 수치를
   확정하지 않는다.
9. Before/After뿐 아니라 수정 사유, Evidence, 기대 행동, KPI, 위험과 원복 조건을 쓴다.
10. 외부 적용은 항상 별도 revision 승인 뒤에 두며 이 Prompt에서는 실행하지 않는다.

## 금지사항

- 상품명 뒤에 입력 키워드를 기계적으로 붙이기
- 제품 종류·용량·효능·대상을 텍스트 일부만 보고 추정하기
- 검색 순위나 매출 증가 보장
- 단순 변심을 상세페이지 문제로 단정하기
- 관측되지 않은 고객 의도·경쟁 우위·전환 원인 생성
- Campaign-ID·기준선·측정일 없이 `최적화 완료` 판정
- 가격·할인·쿠폰·외부 게시·실제 상품정보 자동 변경

## 출력 형식

```yaml
status: PROPOSAL_READY | EVIDENCE_BLOCKED | POLICY_BLOCKED | APPROVAL_PENDING
apply_mode: dry_run
channel: smartstore
os_ref:
campaign_id:
product_ref:
evidence_quality:
missing_inputs: []
confirmed_facts: []
unconfirmed_assumptions: []
journey_bottleneck:
diagnosis:
  observation:
  hypothesis:
  counter_evidence_needed:
priority_change:
  field:
  before:
  after:
  reason:
  evidence_refs: []
  expected_customer_behavior:
secondary_changes: []
policy_checks:
  naver_search:
  cosmetic_claims:
  brand:
measurement:
  primary_kpi:
  guardrails: []
  baseline:
  measure_date:
  attribution_limit:
risks: []
rollback:
approval:
  required: true
  exact_revision:
  approver:
knowledge_feedback:
  experiment_candidate:
  failure_candidate:
```

## 승인 필요 여부

- Dry-run 생성: 승인 불필요
- Campaign 시작: 승인 필요
- 상품명·속성·상세·가격·할인·쿠폰 실제 변경: 정확한 revision 승인 필요
- 신규 Claim·비교 표현·고객 후기 사용: 별도 검토 필요
- 자동 변경 PILOT 또는 ACTIVE 전환: CEO 승인 필요

## 평가 기준

- 입력 누락을 추정으로 채우지 않는가
- 모든 변경에 Evidence와 Revenue KPI가 연결되는가
- 사실·가설·미확인이 분리되는가
- 네이버 필드별 역할과 화장품 표현 기준을 지키는가
- 승인 revision과 원복 조건이 있는가
- 실제 결과를 Knowledge로 환류할 수 있는가

## 실패 시 처리

- 제품 Evidence 없음: `EVIDENCE_BLOCKED`
- 기준선·측정일 없음: 탐색 제안만 허용하고 개선률 산출 금지
- 금지·미확인 Claim 포함: `POLICY_BLOCKED`
- 데이터 정의 충돌: `DATA_BLOCKED`와 충돌 항목 반환
- 승인정보 없음: `APPROVAL_PENDING`, 외부 실행 금지
