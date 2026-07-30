# AUT-014 Channel Listing Execution

- 상태: PLANNED
- 소유자: Marketing Owner
- 구현 책임/위치: Claude Code / `gpcompany-lab`
- 버전: 0.1
- 작성일: 2026-07-30

## Related Workflow and SOP

- Workflow: `WF-006 Revenue Growth Loop` (`ACTIVE`)
- SOP: `SOP-014 Commerce Control Rules` (`DRAFT`)
- Decision: `DEC-0013 멀티채널 상품·가격·프로모션 자동화` (`ACTIVE`, 변경 승인 필요)

SOP-014가 ACTIVE가 되고 채널별 검증을 통과하기 전에는 `PLANNED`에서 전환하지 않는다.

## Trigger

승인된 카탈로그 revision의 상품이 `READY_FOR_CHANNEL` 상태가 되고, 정확히 일치하는 ACTIVE
CCR capability가 존재할 때 실행한다.

## Inputs

- Task-ID, OS-Ref, 채널·SKU·작업종류
- 카탈로그 revision과 승인 가격 원본 참조·기준시각
- CCR-ID/revision과 범위 제한 capability
- 채널 필수 필드·외부 상품 ID·현재 상태 snapshot
- claims 결과, idempotency key, rollback 또는 판매중지 경로

## Processing

1. `PRECHECK`: scope·revision·유효기간·가격 동일성·claims·필수 필드·중복을 검증한다.
2. `SNAPSHOT`: 변경 전 payload·가격·상태와 rollback 경로를 고정한다.
3. `WRITE`: 채널 API에 생성 또는 수정 요청을 한 번 보낸다.
4. `VERIFY`: 외부 상품 ID·표시 가격·승인/판매 상태를 재조회한다.
5. `COMPLETE`: 감사 로그와 다음 상태를 기록한다.
6. 실패하면 해당 채널×SKU를 격리하고 rollback 또는 판매중지를 수행한다.

## Channel Capability Contract

- 스마트스토어: 상품 생성·수정 payload의 `salePrice`를 승인 기준선과 대조하고, 이전
  snapshot으로 복구하거나 판매 중지한다.
- 쿠팡: 상품 생성 시 승인 가격을 보내고 승인 후 발급된 `vendorItemId`의 가격 변경 API를
  별도 capability로 실행한다.
- 다른 채널: 공식 쓰기 API·필수 필드·rollback이 검증될 때까지 `READ_ONLY`다.

2026-07-30 확인 기준 공식 API 근거:

- 네이버 커머스 상품 수정:
  `https://apicenter.commerce.naver.com/docs/commerce-api/current/update-channel-product-product`
- 네이버 커머스 그룹상품 등록:
  `https://apicenter.commerce.naver.com/docs/commerce-api/current/create-product-1-product`
- 쿠팡 상품 생성:
  `https://developers.coupangcorp.com/hc/ko/articles/360033877853`
- 쿠팡 상품 아이템별 가격 변경:
  `https://developers.coupangcorp.com/hc/ko/articles/360034156273`

## Outputs

- `CREATED`, `UPDATED`, `APPROVAL_PENDING`, `PRICE_SOURCE_BLOCKED`,
  `SCOPE_BLOCKED`, `ROLLED_BACK`, `PAUSED`
- 외부 상품 ID, 요청·확인 가격, 채널 상태, 실행·검증 시각
- Gate 결과, audit reference와 rollback 결과

## Approval and Authority

- read/import/dry-run: 자동
- 채널별 첫 `L1`: 대표 1건 승인
- 같은 ACTIVE capability 범위의 반복 등록: 자동
- 가격 변경·할인·프로모션: `FORMULA_CONTROLLED` capability가 없으면 금지
- 결제·환불·정산·계정·권한: 항상 금지

## Idempotency, Failure and Audit

- key: `channel + SKU + catalog revision + operation`
- 성공한 key는 재실행하지 않고 외부 상태만 확인한다.
- 일반 실패는 해당 채널×SKU만 격리한다.
- 같은 원인 3회 또는 rollback 실패는 전역 중단한다.
- Task-ID, CCR revision, capability scope, 변경 전·후 값, 승인, 외부 응답 상태와
  rollback을 기록하며 credential·원가 원문은 기록하지 않는다.

## Activation Criteria

- SOP-014 ACTIVE와 정확한 CCR revision 승인
- 스마트스토어·쿠팡 read/import·dry-run 통과
- 채널별 첫 L1 생성·조회 검증·rollback 또는 판매중지 성공
- 중복·가격불일치·만료 capability·API 오류·재시도 테스트 통과
- 범위 밖 쓰기 0건, 승인 가격과 외부 표시 가격 불일치 0건
