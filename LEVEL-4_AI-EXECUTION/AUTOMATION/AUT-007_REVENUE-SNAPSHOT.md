# AUT-007 Revenue Snapshot

- 상태: PLANNED
- 우선순위: P0
- 소유자: Revenue Analytics Owner
- 구현 위치: `gpcompany-lab` / GP Workbench — 실제 경로 REVIEW
- 버전: 0.1
- 작성일: 2026-07-23
- 다음 검토일: SmartStore 광고·정산 및 최신 아이디어스 주문 export 확보 시

## Purpose

SmartStore·아이디어스의 채널 행동, 주문·취소·환불, 광고·수수료·할인과 승인된 원가를
같은 기준시각으로 묶어 CEO Weekly Revenue Review가 신뢰할 수 있는 Snapshot을 만든다.

이 자동화는 매출을 예측하거나 Campaign 성과를 임의 귀속하지 않는다. 관측값, 데이터
상태와 계산 가능한 KPI를 제공하는 것이 목적이다.

## Related Workflow and SOP

- Workflow: `../WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- Weekly Review: `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-006_WEEKLY-REVIEW.md`
- Marketing Experiment: `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- KPI Contract: `../../LEVEL-5_MANAGEMENT-CONTROL/KPI.md`

## Trigger

- 일간: 승인된 KST 기준시각 이후 자동 수집
- 주간: Weekly Review 전에 완료 기간을 잠그는 Snapshot 생성
- 수동: 데이터 정정 후 승인된 Owner가 같은 기간을 새 revision으로 재생성

실제 스케줄, timeout과 원천별 지연 허용시간은 데이터 접근 방식 확인 후 확정한다.

## Inputs and Validation

### 필수 입력

- 기간 시작·종료, KST 기준시각과 Snapshot type
- SmartStore·아이디어스 원천 식별자와 source revision
- 제품·채널 ID 매핑
- 결제완료 주문, 취소·환불과 주문 상태
- 광고비·수수료·할인·승인 원가의 포함 범위
- Campaign-ID와 attribution 조건이 있는 경우 승인된 Campaign Register
- 비식별 고객키 사용 승인과 보존 정책

### 주문 원천과 정산 원천의 분리

Revenue Snapshot의 매출 기간은 원칙적으로 `구매/결제 발생일` 기준의 주문 원천으로
잠근다. 정산 리포트는 배송완료·정산기준일·지급일처럼 다른 기간 기준을 사용할 수
있으므로 주문 원천을 대신하지 않는다.

| 원천 | Revenue Snapshot | Finance reconciliation |
|---|---|---|
| 주문·취소·환불 export | Primary input | 정산 리포트와 대조 |
| 채널 정산 리포트 | 주문 기준 기간의 Primary input으로 사용 금지 | 수수료·부가세·판매자 부담금·지급금 검증 |
| 채널 행동/광고 export | 방문·전환·ROAS Driver | 필요 시 비용 대조 |

주문 원천과 정산 원천을 같은 기간의 매출처럼 합산하지 않는다. 두 원천의 차이는
배송·정산 지연, 환불, 수수료, 판매자 부담금과 지급 시점으로 설명하고 reconciliation
결과를 별도 보존한다.

### 검증

1. 접근권한과 credential 주체 확인
2. 기간·timezone·원천 freshness 확인
3. 주문 ID·상품 line 중복 확인
4. 취소·환불이 원주문에 연결되는지 확인
5. 제품·채널 ID 미매핑 항목 분리
6. 비용이 이미 순매출 또는 다른 비용에 반영됐는지 확인
7. 고객키·Campaign-ID가 승인 범위 안에서만 사용되는지 확인

필수 원천이 없으면 0을 생성하지 않고 해당 Metric을 `BLOCKED` 또는 `NOT_AVAILABLE`로
표시한다.

## Processing

```text
원천 수집
→ 원본 revision·기준시각 잠금
→ 채널·제품·주문 상태 정규화
→ 중복·취소·환불·비용 검증
→ 기준일 × 채널 × 제품 집계
→ KPI 계산
→ 원천 합계와 reconciliation
→ data_status·품질 경보
→ Snapshot revision 저장
```

- 원천 기록은 변경하지 않는다.
- 정정은 기존 Snapshot을 덮어쓰지 않고 새 revision으로 만든다.
- SmartStore와 아이디어스의 정의가 다르면 채널별 원본 정의를 유지한다.
- attribution model·window가 없으면 직접 추적 매출 외 Campaign 기여 매출을 계산하지 않는다.

## Outputs

### Snapshot Header

- `snapshot_id`, `revision`, `type`
- 기간 시작·종료, KST 기준시각과 생성시각
- 사용한 OS-Ref, KPI contract version
- 원천별 revision·마지막 성공 수집·Owner
- 전체 `data_status`, 누락·중복·지연과 reconciliation

### Metric Rows

최소 grain은 `기준일 × 채널 × 제품`이며 다음을 포함한다.

- 결제완료 주문·수량·상품금액, 취소·환불과 `REV-NET`
- 신규·재구매 고객과 재구매 매출 비중 — 승인된 키가 있을 때
- 방문·전환·객단가와 채널 고유 행동
- 광고비·ROAS·CAC — 직접 추적 범위
- 승인 원가·수수료·할인·변동비와 `REV-CONTRIBUTION`
- Campaign-ID·Journey·attribution model/window — 승인된 경우
- Metric별 `READY/PARTIAL/BLOCKED/NOT_AVAILABLE`

### Review Output

- Weekly Review 숫자 섹션 초안
- 기준선 대비 변동과 가장 큰 Journey·채널 병목 후보
- `BLOCKED` Metric, 해결 Owner와 필요한 승인

병목 후보는 Decision이 아니다. Growth Orchestrator 또는 CEO Review에서 선택한다.

## Authority and Approval

- 승인된 원천의 읽기와 내부 집계만 자동 실행할 수 있다.
- 신규 데이터 접근, PII·원가 권한, 산식·attribution 변경은 Owner와 CEO 승인이 필요하다.
- 가격·할인·예산·광고·외부 게시·고객 발송을 실행할 권한이 없다.
- Snapshot은 원천 정산·회계장부를 대체하지 않는다.

## Idempotency, Retry and Timeout

다음 조합을 기본 idempotency key로 사용한다.

```text
<period-start>:<period-end>:<cutoff-kst>:<snapshot-type>:<source-revision-set>
```

- 같은 key는 같은 revision을 반환한다.
- 원천 revision 또는 정정 규칙이 바뀌면 새 Snapshot revision을 만든다.
- 재시도 전 기존 실행과 부분 수집 상태를 확인한다.
- 한 원천 timeout은 다른 원천을 0으로 만들지 않고 `PARTIAL/BLOCKED`로 종료한다.

## Failure, Rollback and Manual Handoff

- 접근 실패: credential을 출력하지 않고 원천·시각·Owner만 기록
- 중복·환불 연결 실패: 영향 범위를 격리하고 관련 Metric `BLOCKED`
- 원천 합계 불일치: 양쪽 관측값과 차이를 보존하고 Revenue Analytics Owner에게 인계
- 비용 정의 불명확: `REV-NET`과 원천 비용은 보존하되 기여이익 `BLOCKED`
- 잘못된 Snapshot: 삭제·덮어쓰기 대신 `SUPERSEDED` 표시 후 새 revision 생성
- 반복 실패: Weekly Review에 수동 입력 범위와 안전한 fallback을 명시

## Audit, Security and Retention

- 실행 ID, Trigger, 실행 주체, OS-Ref, 원천 revision, 검증 결과와 정정 이력을 기록한다.
- 공개 GitHub·Slack에 주문 원문, 고객 PII, 원가 원문, credential을 기록하지 않는다.
- Workbench에는 집계값, 상태와 권한 저장소의 안전한 참조만 노출한다.
- 보존기간과 삭제 절차는 원천 시스템·개인정보·재무 정책 확정 후 적용한다.

## Activation Criteria

### `PLANNED → PILOT`

- SmartStore·아이디어스 원천·Owner·접근방식·기준시각 확인
- 제품·주문 상태·비용·고객키 매핑 검토
- `REV-NET` 기준과 기여이익 비용 범위 승인
- 확보 가능한 최근 기간의 수동 기준선과 자동 Snapshot 비교
- 중복, 취소·환불, 누락, 원천 지연과 정정 revision 테스트 통과
- 주문 원문·PII·원가가 공개 로그에 노출되지 않는지 확인
- Revenue Analytics Owner와 CEO가 PILOT 범위 승인

## Confirmed Source Review — 2026-07-24

### 아이디어스

아이디어스 2026년 7월 국내 1차 정산 리포트의 구조를 실제 파일로 검토했다. 실제 금액,
사업자정보, 주문번호, 상품명과 고객정보는 OS 저장소에 복사하지 않았다.

- 확인된 탭: `정산 정보`, `정산 요약`, `상세 내역`, `후기 적립금`, `고객 혜택 적립금`
- 확인 가능한 항목: 판매금액, 플랫폼·결제 수수료, 수수료 부가세, 판매자 부담 적립금,
  정산 예정금과 최종 지급금
- `상세 내역`의 주문번호·상품 line은 정산대상 주문이며 구매일과 정산기준일이 함께 존재
- 방문자, 전체 구매 cohort, 승인 원가, 배송·포장 변동비, 안정적인 고객 신규·재구매
  구분은 이 파일만으로 확인할 수 없음

따라서 이 파일은 아이디어스 `Finance reconciliation` 원천으로 승인 후보이며,
Weekly Revenue Snapshot의 주문 기준 `REV-NET` 원천으로는 아직 `BLOCKED`다. 아이디어스
주문·취소·환불 export와 SmartStore 주문·행동·광고·정산 export를 별도로 확보해야 한다.

과거 아이디어스 주문 export(2023년)의 구조도 추가 확인했다.

- 매출 Adapter 후보 열: 주문번호, 주문상태, 작품명, 수량, 결제금액
- 별도 열로 포함되는 개인정보: 주문자·수령인, 전화번호, 우편번호, 주소, 요청·메모
- 안전 경계: 매출 Adapter는 허용 목록의 매출 열만 읽고 개인정보 열을 즉시 제외한다.
- 고객 KPI: 승인된 비식별 고객키를 만들지 않으므로 신규·재구매 KPI는 `NOT_AVAILABLE`

이 과거 파일은 Adapter 초안과 개인정보 차단 테스트에는 사용할 수 있지만, 현재 아이디어스
export 형식과 취소·환불 상태 범위를 대신 승인하지 않는다. 최신 완료 기간 export로 다시
검증하기 전에는 결과를 `PARTIAL`로만 사용한다.

### SmartStore

SmartStore의 동일한 30일 조회기간과 직전 30일 비교기간을 포함한 집계 export 구조를
실제 파일로 검토했다. 실제 매출값과 제품별 결과는 OS 저장소에 복사하지 않았다.

- 확인된 판매 리포트: `채널 × 건수`, `상품 × 건수`
- 확인된 방문 리포트: `상품 × 건수`, `상품 × 고객수`, `경로 × 건수`
- 판매 리포트에서 확인 가능한 항목: 결제·환불 건수와 수량, 총·순 판매금액, 환불금액,
  방문, 전환, 배송비와 판매자·네이버 부담 할인
- 방문 리포트에서 확인 가능한 항목: 방문·결제 귀속, 상품·경로 1~3단계, 고유 방문고객,
  결제고객과 고객 기준 전환
- 확인한 파일에는 고객명·전화번호·주소·주문 메모 같은 고객 PII가 포함되지 않음

Adapter와 집계에는 다음 제약을 의무 적용한다.

1. `채널 × 건수` 파일에는 `전체` 행과 동일 상점 행이 같은 값으로 함께 존재한다.
   두 계층을 합산하지 않고 Snapshot scope에 맞는 한 계층만 선택한다.
2. 같은 설정으로 받은 중복 파일은 파일명보다 셀 내용 또는 source revision으로 식별해
   한 번만 처리한다.
3. 방문 리포트의 결제·매출은 방문 경로에 귀속된 값이며 전체 판매 리포트의 주문·매출과
   같다고 가정하지 않는다. attribution coverage를 별도 표시한다.
4. 확인 기간의 상품 상세와 전체 합계가 일치하는 경우에도 주문 line 원천이 아니므로
   `READY`로 승격하지 않는다. 비교기간에는 상품 상세와 전체 합계가 불일치할 수 있어
   제품별 전기 대비를 `PARTIAL`로 처리한다.
5. `판매금액(순)`은 채널 집계 관측값으로 보존하되 VAT·배송비·할인·취소·환불 기준이
   승인된 `revenue_basis`와 주문 원천으로 검증되기 전에는 canonical `REV-NET`으로
   확정하지 않는다.
6. 고객수 파일에는 안정적인 고객키가 없으므로 신규·재구매와 채널 간 고객 통합에는
   사용하지 않는다.

현재 SmartStore 집계 export는 개인정보 없는 수동 Revenue 기준선과 방문·전환·제품·경로
병목 탐색에는 `PARTIAL`로 사용할 수 있다. 주문·취소·환불 원천, 광고비, 정산·수수료와
승인 원가가 연결되기 전에는 기여이익·ROAS·CAC와 Campaign 확대 판단에 사용하지 않는다.

#### 주문조회 export 검증 — 2026-07-25

SmartStore 최신 주문조회 export의 열 구조와 현재 30일 범위를 추가로 검토했다. 주문번호,
상품주문번호와 고객 식별값은 OS 저장소에 복사하지 않았고, 비식별 집계와 검증 결과만
사용했다.

- 확인된 업무 열: 상품주문번호, 주문번호, 주문일시, 주문·클레임 상태, 상품번호·상품명,
  옵션, 수량
- 별도 개인정보 열: 구매자명, 구매자 ID, 수취인명
- 현재 30일의 고유 상품주문번호 수와 판매 집계의 주문수가 일치했고 중복
  상품주문번호는 확인되지 않음
- 취소 상품주문은 판매 집계의 환불 건수와 일치함
- CEO 운영 확인상 현재기간 취소 사유는 모두 `단순 변심`이지만, 고객별 세부사유와
  취소 시각은 원천에 존재하지 않음
- 결제일시, 상품·결제금액, 환불금액·일시, 취소 세부사유와 유입 채널은 이 export로
  확인할 수 없음

따라서 이 export는 SmartStore 상품주문·수량·상품·상태 Adapter와 집계 주문수
reconciliation에는 `PARTIAL` 승인 후보로 사용할 수 있다. `구매/결제 발생일` 기준
주문금액과 취소·환불금액을 원주문에 연결하기 전에는 canonical `REV-NET` 원천으로
승격하지 않는다.

Adapter는 허용 목록의 업무 열만 읽고 개인정보 열을 변환 초기에 제외한다. `단순 변심`은
현재기간 집계 Context로만 사용하며, 고객별 원인이나 향후 취소의 기본값으로 자동
채우지 않는다.

### `PILOT → ACTIVE`

- 최소 네 번의 Weekly Snapshot과 Review에서 정정 이력·장애 처리 검증
- 모든 필수 Metric이 `READY`이거나 승인된 `PARTIAL` 범위를 명확히 표시
- 원천 합계 차이가 없거나 모든 차이에 설명·Owner가 존재
- 중복 매출 확정 보고 0건
- 운영 책임, 알림, 수동 fallback과 보존정책 확인

## Operating KPI

- 필수 원천 완전성
- Snapshot 적시 생성률과 freshness
- 원천 합계 reconciliation 차이와 해결시간
- 중복 주문·매출 확정 보고 건수
- 정정 revision 비율과 원인
- `READY/PARTIAL/BLOCKED` Metric 비율
- 대표의 주간 Revenue 집계·정리 시간

고정 목표값은 첫 수동 기준선과 Owner 승인 후 확정한다. 정확성과 중복 방지는 성장 목표가
아니라 활성화 품질 Gate다.

## Unconfirmed Before Implementation

- SmartStore 결제일·상품금액과 취소·환불 금액·시각을 원주문에 연결하는 export/API 범위
- SmartStore 광고비·Campaign·소재·검색어 export/API와 attribution 기준
- SmartStore 정산·수수료·지급금 export/API와 주문 원천 reconciliation 방식
- 최신 아이디어스 주문·취소·환불 export/API 형식과 상태 범위
- 주문·광고·정산 원천의 지연과 기준시각
- Finance 승인 원가·수수료·배송·포장비 원천
- 채널 간 고객 중복을 처리할 수 있는 승인된 비식별 키
- `gpcompany-lab`의 실제 구현 경로와 운영 저장소
- Snapshot 보존기간과 접근권한 Owner
