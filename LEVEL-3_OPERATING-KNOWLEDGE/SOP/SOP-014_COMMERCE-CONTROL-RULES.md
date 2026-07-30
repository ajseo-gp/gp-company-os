# SOP-014 Commerce Control Rules 관리

- 상태: DRAFT
- 버전: 1.1
- 소유자: GP Company CEO / Marketing Owner
- 담당: Hermes Primary, Claude Code
- 작성일: 2026-07-30
- 적용 Workflow: WF-006 Revenue Growth Loop

## 목적

`DEC-0013`의 상품·가격·프로모션 실행 범위를 revision으로 고정하고, 최초에는 승인 가격을
그대로 복제해 상품 등록을 열며 가격 최적화는 별도 승인 규칙이 생길 때까지 분리한다.

## 입력

- `TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml` 규칙 후보
- 승인된 카탈로그·SKU revision과 권한 저장소의 가격 원본 참조
- 기존 판매 상품의 채널 가격·외부 상품 ID snapshot
- 채널 필수 필드·카테고리·길이 규칙과 제품별 표현 Evidence
- rollback 또는 판매중지 경로

## 절차

### 1. 기준선 import

1. 외부 쓰기 없이 승인 상품 마스터의 SKU·가격·revision을 읽는다.
2. 같은 SKU가 이미 채널에 있으면 현재 판매 가격과 외부 상품 ID를 읽는다.
3. 동일성·기준시각을 확인한다. 가격을 AI가 추정하거나 산출하지 않는다.
4. 신규 상품의 승인 가격이 없거나 기존 가격과 불일치하면 `PRICE_SOURCE_BLOCKED`로 둔다.

### 2. 규칙 후보와 capability 작성

1. `CCR-ID`와 revision을 발급하고 `FIXED_BASELINE` 모드를 설정한다.
2. 채널·SKU·카탈로그 revision·승인 가격 원본·유효기간을 고정한다.
3. capability scope를 `채널×SKU×작업종류×CCR revision`으로 작성한다.
4. 최초 허용 가격 변화량은 `0`으로 한다. 전역 쓰기 권한은 만들지 않는다.

### 3. dry-run Gate

- 승인 카탈로그와 채널 SKU 동일성
- 가격 원본과 기준시각, 요청 가격과 승인 가격의 동일성
- 화장품 표현 판정, 필수 필드·길이·카테고리
- 중복 등록, 변경 전 snapshot, idempotency key
- rollback 또는 판매중지, 감사 로그

하나라도 실패하면 capability를 발급하지 않는다.

### 4. 최초 실행과 활성화

1. 대표가 정확한 `CCR` revision을 승인한다.
2. 채널별 첫 `L1` 1건을 별도 승인한다.
3. Claude Code가 상품 생성/수정 요청의 가격과 승인 기준선이 같은지 다시 검증한다.
4. 실행 후 외부 상품 ID·실제 표시 가격·상태를 재조회한다.
5. rollback 또는 판매중지 검증이 끝난 정확한 범위만 `ACTIVE` capability로 전환한다.

### 5. 반복 실행

ACTIVE capability의 채널·SKU·작업·revision·유효기간이 모두 일치할 때만 추가 질문 없이
실행한다. `FORMULA_CONTROLLED` 규칙이 별도로 승인되기 전에는 가격 변경·할인·프로모션을
실행하지 않는다.

## 승인

- 규칙 revision 최초 활성화와 범위·상한 확대: 대표 승인
- 채널별 첫 `L1`: 대표 승인
- 동일 ACTIVE revision 범위의 반복 등록: 추가 승인 없음
- 가격 변경 모드 전환과 규칙 밖 채널·SKU·가격: 실행 금지, Decision Queue

## 실패·중단·복구

- 일반 실패·채널 반려·규칙 이탈: 해당 `채널×SKU` capability 폐기 또는 일시중지
- 자동 rollback 성공: Evidence 기록 후 같은 범위 1회 재검증
- 표현 Gate 위반: 해당 SKU 중단, 사람 검토
- 같은 원인 3회 반복 또는 rollback 실패: 모든 외부 쓰기 중단·대표 보고
- 규칙 원본 접근 실패 또는 revision 불일치: 외부 쓰기 금지

## 출력과 로그

`CCR-ID/revision`, Task-ID, capability scope, 채널·SKU·외부 상품 ID, 카탈로그 revision,
가격 원본 참조와 기준시각, 변경 전·후 값, Gate·승인·실행 결과, idempotency key와 rollback
결과를 기록한다. credential·원가·고객 원문은 기록하지 않는다.

## 관련 문서

- Decision: `../DECISIONS/DEC-0013_CHANNEL-LISTING-AUTOMATION.md`
- Context: `../CONTEXT/COMMERCE-CONTROL-RULES.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- Automation: `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-014_CHANNEL-LISTING-EXECUTION.md`
- Template: `../../TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`
