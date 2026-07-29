# SOP-014 Commerce Control Rules 관리

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO / Marketing Owner
- 담당: Hermes Primary, Claude Code
- 작성일: 2026-07-29

## 목적

`DEC-0013`의 상품·가격·프로모션 자동화 범위를 한 번 승인한 규칙 revision으로 고정하고,
규칙 안의 반복 실행마다 대표 승인을 다시 요구하지 않도록 한다.

## 적용 범위

- 스마트스토어·쿠팡 및 대표가 활성화한 쇼핑몰
- 카탈로그 신규 등록, 콘텐츠·옵션·이미지, 가격·할인·쿠폰·프로모션
- 유료 집행이 포함될 경우 승인된 채널·기간·예산 상한

결제·환불·정산·계정·권한 변경에는 적용하지 않는다.

## 입력

- `TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`로 작성한 규칙 후보
- 승인된 카탈로그와 SKU revision
- 채널별 필수 필드·카테고리·길이 규칙
- 제품별 기능성 상태와 표현 Evidence
- 가격·할인·예산 입력의 권한 저장소 참조
- rollback 또는 판매중지 경로

## 절차

### 1. 규칙 후보 작성

1. 새 `CCR-ID`와 revision을 발급한다.
2. 적용 채널·SKU, 가격 범위 또는 산식, 최대 할인율, 허용 프로모션, 기간·예산,
   중단 조건과 rollback을 모두 채운다.
3. 비공개 원가·credential·고객 원문은 OS나 실행 로그에 복사하지 않는다.
4. 누락 필드가 있으면 상태를 `DRAFT`로 유지한다.

### 2. 사전 검증

Claude Code는 외부 쓰기 없이 다음을 검증한다.

- 승인 카탈로그와 채널 SKU의 동일성
- 가격 하한·상한·할인·예산의 결정 가능성
- 화장품 표현 `AUTO_ALLOW`, `AUTO_BLOCK`, `HUMAN_REVIEW` 판정
- 필수 필드·길이·카테고리와 중복 등록
- 변경 전 값 snapshot
- idempotency key
- rollback 또는 판매중지 dry-run
- Task-ID·CCR revision·변경 전후 값의 로그 계약

하나라도 실패하면 규칙을 활성화하지 않는다.

### 3. 승인과 활성화

1. 대표는 규칙 revision의 범위와 상한을 한 번 승인한다.
2. 채널별 첫 `L1` 상품은 별도로 1건 승인·실행·검증한다.
3. Claude Code는 승인된 정확한 revision과 검증 Evidence가 일치하는지 확인한다.
4. runtime 원본을 `ACTIVE`로 전환하고 Context에 안전한 revision 참조와 활성화 시각을
   기록한다.
5. 모든 Gate가 구현·검증된 뒤에만 `externalWriteEnabled=true`로 바꾼다.

### 4. 실행

1. 매 실행 전에 현재 활성 CCR revision을 다시 읽는다.
2. 채널·SKU·값·시각·예산이 규칙 범위인지 확인한다.
3. 표현·SKU·필수필드·중복·snapshot·rollback·로그 Gate를 통과한다.
4. 범위 안이면 추가 질문 없이 실행한다.
5. 범위 밖이면 실행하지 않고 `DECISION_QUEUE`에 넣는다.

### 5. 실패와 중단

- 일반 실패·채널 반려·규칙 이탈: 해당 `채널×SKU`만 격리한다.
- 자동 rollback 성공: 원인과 Evidence를 Digest에 넣고, 같은 범위는 Digest 전달 후
  수정된 입력으로 1회 재검증할 수 있다.
- 예산 초과: 해당 채널의 유료·가격·프로모션 실행 전체를 중단한다.
- 표현 Gate 미통과: 해당 SKU 외부 쓰기를 중단하고 사람 검토 전 재개하지 않는다.
- 같은 원인 3회 반복 또는 rollback 실패: 모든 채널 외부 쓰기를 중단하고 대표에게
  즉시 보고한다.

영향받지 않는 독립 채널·SKU의 규칙 내 작업은 계속할 수 있다.

## 승인

- 규칙 revision 최초 활성화와 범위·상한 확대: 대표 승인
- 채널별 첫 `L1`: 대표 승인
- 동일 ACTIVE revision 범위 안의 반복 `L1`·`L2`·`L3`: 추가 승인 없음
- 규칙 밖 가격·할인·예산·채널·SKU: 실행 금지, Decision Digest

## 출력과 로그

- `CCR-ID`와 revision
- Task-ID, 채널, SKU, 외부 상품 ID
- 변경 전·후 값
- 적용한 Gate와 결과
- 승인 상태와 실행 주체·시각
- idempotency key
- rollback 경로와 결과

## 실패·예외

- runtime 규칙 원본 접근 실패: 외부 쓰기 금지
- OS Context와 runtime ACTIVE revision 불일치: 외부 쓰기 금지
- 원가·예산 원천의 기준 시각 불명: 관련 가격·프로모션 실행 금지
- 채널 API 정책 변경: 해당 채널 중단, 규칙 재검토

## 관련 문서

- Decision: `../DECISIONS/DEC-0013_CHANNEL-LISTING-AUTOMATION.md`,
  `../DECISIONS/DEC-0015_UNATTENDED-EXECUTION-DECISION-DIGEST.md`
- Context: `../CONTEXT/COMMERCE-CONTROL-RULES.md`
- Knowledge: `../KNOWLEDGE/COSMETIC-CLAIMS-GUIDE.md`
- Template: `../../TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
