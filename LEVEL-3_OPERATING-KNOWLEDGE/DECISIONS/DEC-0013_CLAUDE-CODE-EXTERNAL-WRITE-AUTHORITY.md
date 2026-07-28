# DEC-0013 Claude Code 외부 상품 등록 쓰기 권한

- 상태: ACTIVE
- 결정일: 2026-07-28
- 적용일: 2026-07-28
- 결정자/소유자: GP Company CEO
- 적용 범위: 승인된 카탈로그와 쿠팡 상품 등록·수정·게시
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

카탈로그와 쿠팡 API credential이 준비되어도 Company OS에 외부 쓰기 실행권한이 없으면
Claude Code는 안전하게 상품 등록 버튼을 실행할 수 없다. 반대로 무제한 외부 쓰기 권한은
가격·재고·화장품 표현·브랜드 신뢰와 채널 계정에 과도한 위험을 만든다.

## 결정

1. Claude Code를 승인된 상품 카탈로그와 쿠팡 판매자 계정의 **외부 쓰기 실행자**로 지정한다.
2. 허용 작업은 다음에 한정한다.
   - 상품 생성·수정·등록·게시·판매중지 요청
   - 승인된 상품 이미지·상세설명·옵션·카테고리·가격·재고의 동기화
   - API 결과 확인, idempotent 재시도와 실패한 등록의 안전한 중단
3. 실제 외부 쓰기는 각 실행마다 유효한 `External Write Permit`을 확인한 경우에만 허용한다.
   Permit에는 최소한 Task-ID, 채널·스토어, 상품/SKU와 revision, 작업 종류, 가격·재고,
   표현·이미지 검수 상태, 승인자, 만료시각이 있어야 한다.
4. Claude Code는 Permit 범위를 벗어난 상품, 가격·재고·표현·채널 또는 revision을 등록하지
   않는다. 변경된 revision에는 새 Permit이 필요하다.
5. 첫 등록, 신규 상품, 가격·재고·표현의 중대한 변경, 판매중지와 재게시에는 대표의
   명시적 상품별 승인을 요구한다. 이미 승인된 상품 revision의 기술적 재시도만 별도 승인을
   요구하지 않는다.
6. 실행 전에는 dry-run 또는 API 검증, 중복 등록 확인, 필수 필드·카테고리·이미지·표현
   검수, rollback 또는 판매중지 방법을 확인한다. 실행 후에는 외부 상품 ID·결과·시각·
   실행 주체만 비식별 로그로 남긴다.
7. credential은 OS·GitHub·Slack·Preview·스크린샷에 기록하지 않으며, Claude Code가
   접근 가능한 분리된 secret store에서만 사용한다.

## 이유

이 Decision은 Claude Code가 등록 버튼을 실제로 누를 수 있게 하되, 대표가 가격·재고·
표현·판매 대상의 사업 판단을 통제하도록 분리한다. 기술 실행의 병목은 줄이고, 외부
계정의 오등록·중복 등록·규제 표현 위험은 Permit과 로그로 제한한다.

## 영향 범위

### 적용

- 상품 카탈로그와 쿠팡의 상품 등록·수정·게시·판매중지 API 또는 UI 자동화
- Claude Code의 외부 쓰기 Preflight, 실행, 재시도와 결과 기록
- Workbench·Hermes의 Permit 생성과 승인 상태 표시

### 비적용

- 결제·환불·정산·광고비 집행, 계약, 고객 메시지 발송, 가격·마진 정책 결정
- 고객 개인정보, 처방·함량, 원가·단가의 외부 전송
- Permit 없는 대량 일괄 등록·수정 또는 다른 채널로의 권한 확대
- Codex의 외부 시스템 구현·credential 접근

## 결과와 Trade-off

- 승인된 상품은 Claude Code가 대표의 중계 없이 외부 등록까지 완료할 수 있다.
- 상품별 Permit 생성이 필요하지만, 이는 등록 버튼을 막는 절차가 아니라 실제로 무엇을
  등록했는지 증명하는 최소 안전장치다.

## 전환과 검증

1. Claude Code가 카탈로그·쿠팡 구현에 Permit 검증, dry-run, idempotency와 결과 로그를 추가한다.
2. 첫 상품은 sandbox 또는 비공개/임시 등록 가능 범위에서 API 요청·응답과 rollback을 검증한다.
3. 첫 운영 등록은 대표 승인 Permit으로 수행하고, 외부 상품 ID와 화면·API 결과를 보고한다.
4. 성공 기준은 Permit 없는 외부 쓰기 0건, 중복 등록 0건, 실행 결과 기록률 100%다.

## 재검토 조건

- 쿠팡 또는 카탈로그 API 권한·정책·인증 방식이 변경될 때
- 오등록, 중복 등록, 규제 표현 위반 또는 rollback 실패가 발생할 때
- 다른 판매 채널·광고·결제·고객 메시지로 쓰기 범위를 확대하려 할 때

## 관련 문서

- Business: `LEVEL-2_BUSINESS/B2C.md`, `LEVEL-2_BUSINESS/MARKETING.md`
- Context: `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/CURRENT-PRIORITIES.md`
- Decision: `DEC-0009_REVENUE-FIRST.md`, `DEC-0012_AI-WORK-ALLOCATION.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`, `SOP-011_MARKETING-EXPERIMENT.md`
- Agent: `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- Automation: `LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`
