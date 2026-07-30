# Commerce Control Rules 현재 상태

- 상태: ACTIVE
- 소유자: GP Company CEO / Marketing Owner
- 기준일: 2026-07-30
- 다음 검토일: 첫 규칙 instance 승인 시 또는 2026-08-06
- 적용 범위: 스마트스토어·쿠팡 및 대표가 활성화한 쇼핑몰의 상품·가격·프로모션
- 원본 근거: DEC-0013

## 확인된 현재 상태

- 활성 규칙 revision: `NONE`
- 활성 외부 쓰기 capability: `NONE`
- 채널별 첫 `L1` 승인 기록: `NONE`
- 규칙 instance 원본 위치: `미지정`
- 마지막 검증 실행 ID: `NONE`
- 구현 상태: Workbench 제안 경로는 외부 쓰기를 강제로 비활성화하며, 스마트스토어
  쓰기 Adapter와 쿠팡 승인 후 가격 변경 경로의 운영 검증은 미완료
- 구현 감사 기준: `gpcompany-lab` branch `ajseo-gp/workbench-closed-loop-p3`,
  commit `c0a028ec410f9f87134cf50d72289ef8f5fe89ea`

따라서 현재 가능한 범위는 조회·카탈로그 import·dry-run·Adapter 구현과 테스트다.
실제 신규 등록과 가격 외부 쓰기는 아직 허용되지 않는다.

## 확인된 차단 원인

1. `DEC-0013`은 ACTIVE지만 이를 실행하는 Context·SOP·Automation 계약이 main에 없다.
2. 승인된 실제 `CCR` instance와 가격 기준선 원본 참조가 없다.
3. 구현이 전역 `externalWriteEnabled=false`로 fail-closed 되어 있고 범위 제한 capability
   활성화 경로가 없다.
4. 채널별 첫 `L1` 승인·실행·rollback Evidence가 없다.

## 해제 후보

- 후보 revision: `CCR-BASELINE-001`
- 모드: `FIXED_BASELINE`
- 가격 원천: 권한 저장소의 승인된 상품 마스터 가격
- 기존 판매 SKU 대조: 해당 채널의 현재 판매 가격
- 허용 가격 변화량: `0`
- 실행 권한 단위: `채널×SKU×LISTING_CREATE×CCR-BASELINE-001`
- 상태: `DRAFT`

실제 채널·SKU·가격 값은 권한 저장소에서 import하기 전까지 `미확인`이다. AI가 빈 값을
채우지 않는다. 신규 상품에 승인 가격 원천이 없거나 기존 채널 가격과 승인 상품 마스터가
불일치하면 `PRICE_SOURCE_BLOCKED`로 유지한다.

## 원본 경계

Company OS에는 규칙 구조와 안전한 revision·승인·검증 참조만 저장한다. 실제 가격,
원가·마진 입력, credential과 채널 운영 원문은 권한이 분리된 Workbench 또는 운영 저장소가
원본이다.

## 활성화 조건

- `CCR-BASELINE-001`의 정확한 채널·SKU와 승인 가격 원본 확정
- claims·필수 필드·SKU·중복·snapshot·idempotency Gate 통과
- 채널별 rollback 또는 판매중지 dry-run 통과
- 스마트스토어와 쿠팡 각각 첫 `L1` 1건 승인·검증
- 범위 제한 capability와 감사 로그의 운영 검증

## 관련 문서

- Decision: `../DECISIONS/DEC-0013_CHANNEL-LISTING-AUTOMATION.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- SOP: `../SOP/SOP-014_COMMERCE-CONTROL-RULES.md`
- Automation: `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-014_CHANNEL-LISTING-EXECUTION.md`
- Template: `../../TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`
