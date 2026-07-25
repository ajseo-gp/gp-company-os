# PRACTICE-0001 SmartStore 상품 운영 가이드

- 유형: PRACTICE
- 상태: REVIEW
- 소유자: Marketing Owner
- 작성일: 2026-07-25
- 검토일: 2026-08-25
- 적용 범위: 젠틀파파 SmartStore 상품정보·검색설정·상세·혜택의 Dry-run 진단
- 승인 상태: 공식 기준 조사 완료, GP Company 실전 성과 검증과 CEO 승인 전

## Reusable Statement

SmartStore 상품 운영은 상품명을 임의로 바꾸는 작업이 아니다. 현재 상품 revision, 제품
Evidence, 채널 행동·주문·취소 데이터와 변경 이력을 근거로 병목 가설을 세우고, 한 번에
통제 가능한 변수를 변경한 뒤 매출·기여이익·취소·환불 Guardrail로 검증하는 Revenue
Experiment다.

검색 노출, 상품상세 이해, 구매 전환, 취소·환불은 서로 다른 문제다. 데이터 없이
키워드를 추가하거나 상세페이지 문구를 바꾸는 제안은 `EVIDENCE_BLOCKED`로 처리한다.

## Evidence

### 네이버 공식 운영 기준

- 네이버 상품명 마스터는 가격비교 검색 최적화 가이드를 기준으로 상품명을 점검한다.
  중복 단어, 상품과 관계없는 키워드와 할인 정보는 어뷰징으로 인식되어 검색상 불이익을
  받을 수 있다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=14555
- 브랜드는 상품명 문자열만으로 대체하지 않는다. 공식 브랜드 필드 입력이 검색 적합도에
  사용되며, 상품과 관계없는 정보는 검색 제외나 불이익의 원인이 될 수 있다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=4709
- 직접 입력한 태그는 내부 기준에 따라 검색에 사용되지 않을 수 있다. 실제 적용 여부는
  판매자센터의 `검색에 적용되는 태그 확인`으로 확인해야 하며 태그 순서는 노출 순위에
  영향을 주지 않는다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=3386
- Page Title과 Meta description은 상품 공유와 검색엔진 판단에 쓰이는 별도 메타데이터다.
  미입력 시 상품명·스토어 소개가 기본값으로 사용된다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=4228
- 판매가는 실제 거래 관행에 따른 정가여야 한다. 허위·과장 정가와 할인율은 플랫폼
  제한과 표시광고 책임의 원인이 될 수 있다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=17680
- 첫구매 고객은 최근 2년간 결제 기준 구매 이력이 없는 고객으로 정의되며, 결제 후
  취소 고객의 처리 등 채널 고유 조건이 있다. 혜택 제안은 대상 정의와 중복 할인 조건을
  확인해야 한다.
  - 출처: https://help.sell.smartstore.naver.com/faq/content.help?faqId=12542

### 화장품 표현 기준

- 상품명·상세·검색 메타데이터도 화장품 표시·광고 검토 범위에서 제외하지 않는다.
- 최신 적용 버전과 제품별 기능성·시험·표시 근거는 발행 전에 별도로 확인한다.
- 출처: 식품의약품안전처 `화장품 표시·광고 관리 지침(민원인안내서)`
  - https://www.mfds.go.kr/brd/m_1060/view.do?Data_stts_gubun=C9999&company_cd=&company_nm=&itm_seq_1=0&itm_seq_2=0&multi_itm_seq=0&page=1&seq=15456

### GP Company 내부 Evidence

- 개인정보 없는 SmartStore 방문·판매 집계 export와 주문조회 구조는 검토되었다.
- 현재 데이터의 사용 가능 범위와 누락 항목은 `AUT-007 Revenue Snapshot`을 따른다.
- 실제 상품별 검색어·광고비·상세 행동·정산·원가가 모두 연결된 기준선은 아직
  `미확인`이다.

## Confidence

- 수준: MEDIUM
- 네이버·식약처의 공식 운영 기준 자체는 HIGH다.
- 이 기준을 적용한 특정 상품의 매출 효과는 GP Company Campaign으로 검증하지 않았으므로
  LOW이며, 외부 Best Practice를 회사의 성공 지식으로 간주하지 않는다.

## Applicability

### 필수 입력 Gate

다음 항목을 확인한 뒤에만 상품 수정안을 생성한다.

1. 채널과 SmartStore 상품번호 또는 안전한 내부 참조 ID
2. 현재 상품 revision
   - 상품명, 카테고리, 브랜드·제조사, 주요 속성, 옵션
   - 태그, Page Title, Meta description
   - 대표이미지·상세페이지 revision
   - 가격·할인·쿠폰과 배송 조건
3. 제품 Evidence
   - 정확한 제품명·유형·용량·사용법
   - 사용할 수 있는 Claim과 근거
   - 금지·미확인 표현
4. 같은 기준기간의 Revenue Evidence
   - 노출 또는 방문, 상품상세 진입, 주문, 매출
   - 취소·환불과 확인 가능한 사유
   - 광고비·할인·수수료·승인 원가의 가용 상태
5. 변경 이력과 측정기간
6. Campaign-ID, 목표 KPI, Guardrail, Owner와 승인자

하나라도 없으면 누락 항목과 영향 범위를 반환한다. 값을 추정하여 상품 사실이나 기준선을
만들지 않는다.

### 병목별 가설 라우팅

아래는 진단의 시작점이며 확정 원인이 아니다.

| 관측 패턴 | 우선 확인 | 허용되는 제안 |
|---|---|---|
| 노출·유입 부족 | 카테고리, 브랜드 필드, 검색 적용 태그, 유입 검색어, 광고 | 검색 적합도 가설과 필드 정합성 |
| 유입은 있으나 상세 진입·체류 부족 | 대표이미지, 상품명과 검색의도 일치, 첫 화면 | 메시지·이미지 가설 |
| 상세 진입은 있으나 주문 부족 | 제품 이해, 옵션, 가격·혜택, 배송, 리뷰·FAQ | Conversion 가설 |
| 단순 변심 취소 집중 | 변경 이력, 옵션 오선택, 기대와 실물 정보 차이, 쿠폰·광고 유입 | 기대 불일치 가설과 확인 계획 |
| 재구매 부족 | 구매주기, 제품 경험, 재구매 대상 정의, 혜택 비용 | Retention Campaign 가설 |

상관관계만으로 원인을 단정하지 않는다. 취소 사유가 `단순 변심`뿐이면 상세 원인은
`미확인`으로 유지하고 상품·날짜·옵션·Campaign 변경과의 집중 여부만 진단한다.

### 상품정보 운영 원칙

1. 상품명은 확인된 상품 정체성과 검색의도를 명료하게 표현한다.
2. 중복 키워드, 관련 없는 유입 키워드, 할인·배송·이벤트 문구를 상품명에 삽입하지 않는다.
3. 브랜드·제조사·카테고리·속성은 상품명 반복으로 대신하지 않고 전용 필드를 사용한다.
4. 태그 후보와 실제 검색 적용 태그를 구분한다.
5. Page Title·Meta description을 상품명과 구분해 공유·검색 문맥에 맞게 제안한다.
6. 제품 Evidence에 없는 저자극·안전·효능·비교 표현을 생성하지 않는다.
7. 가격·쿠폰은 목표 전환뿐 아니라 할인비용·기여이익·중복 조건을 함께 검토한다.
8. 여러 필드를 동시에 바꾸는 경우 각 변경의 효과를 분리할 수 없음을 명시한다.

### Experiment 단위

- 변경 전 revision과 스크린샷 또는 안전한 참조를 고정한다.
- 문제 하나, 우선 가설 하나, 주요 KPI 하나를 기본 단위로 한다.
- 제안에는 `왜`, `어떤 Evidence`, `기대 행동`, `위험`, `원복 조건`을 포함한다.
- 실제 적용은 승인된 revision만 수행한다.
- 결과는 사전 측정일에 같은 정의로 비교하고 `SCALE`, `ITERATE`, `STOP`으로 종료한다.

## Exclusions and Known Limits

- 이 문서는 네이버 검색 순위를 보장하지 않는다.
- 경쟁 상품을 모방하거나 확인되지 않은 외부 마케팅 공식을 승인하지 않는다.
- SmartStore 정책과 화면은 변경될 수 있으므로 발행·자동화 전 공식 도움말의 최신 상태를
  확인한다.
- 제품별 표시·광고 적합성과 기능성 범위는 별도 제품 Evidence 없이는 확정하지 않는다.
- 실제 상품·고객·원가 원문과 credential은 이 저장소에 저장하지 않는다.

## Operational Use

- Decision: `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- Business: `../../LEVEL-2_BUSINESS/MARKETING.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- SOP: `../SOP/SOP-011_MARKETING-EXPERIMENT.md`, `../SOP/SOP-005_CONTENT-PRODUCTION.md`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- Prompt: `../PROMPT-LIBRARY/PROMPT-SMARTSTORE-COMMERCE.md`
- Data contract: `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`

Commerce Graph는 이 Knowledge가 `ACTIVE`가 되기 전까지 `dry_run`과 `approval_required=true`
상태를 유지한다. `REVIEW` 상태에서는 연구된 규칙과 미확인 항목을 표시하는 PILOT
제안에만 사용한다.

## Revision Trigger

- 네이버 상품명·검색·브랜드·태그·혜택 정책 변경
- 식약처 화장품 표시·광고 지침 변경
- 첫 SmartStore Campaign 결과 확보
- 상품별 검색어·광고·정산·원가 데이터 연결
- 동일 운영 방법의 성공 또는 실패가 두 번 이상 재현
