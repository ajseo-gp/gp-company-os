# Automation Register

## Automation Definition

자동화는 트리거, 입력, 처리, 출력, 승인, 실패처리, 로그를 정의해야 한다.
반드시 ACTIVE Workflow와 SOP를 참조하며, 정책이나 승인 범위를 자동화 문서에서 새로
만들지 않는다.

필수 항목:

- ID, 상태, 소유자와 구현 위치
- 관련 Workflow 상태 전이와 SOP 단계
- Trigger, 입력 검증과 출력 계약
- 승인과 권한
- idempotency, 재시도, timeout
- 실패·rollback·수동 인계
- 감사 로그, 보안과 보존기간
- 구현 완료 조건과 운영 KPI

상태는 `PLANNED`, `PILOT`, `ACTIVE`, `PAUSED`, `ARCHIVED`를 사용한다. `PLANNED`는
실행 가능하다는 뜻이 아니며, `ACTIVE`는 구현·테스트·운영 책임자가 확인된 경우에만 쓴다.

| ID | 자동화 | 우선순위 | 상태 | Workflow/SOP |
|---|---|---|---|---|
| AUT-001 | OEM 문의 자동 분류 | P1 | PLANNED | WF-001 / SOP-001 |
| AUT-002 | 후속 연락 알림 | P1 | PLANNED | WF-001 / SOP 미정 |
| AUT-003 | 주간 KPI 집계 | P1 | PLANNED | Weekly Review / SOP-006 |
| AUT-004 | 콘텐츠 초안 생성 | P2 | PLANNED | WF-002 / SOP-005 |
| AUT-005 | 리뷰 수집·요약 | P2 | PLANNED | WF-002 / SOP 미정 |
| AUT-006 | 표준 Preview 승인 후 자동 merge·deploy | P1 | PLANNED | WF-004 / SOP-008 |
| [AUT-007](./AUT-007_REVENUE-SNAPSHOT.md) | 채널·주문·비용 Revenue Snapshot | P0 | PLANNED | WF-006 / SOP-006, 011 |
| AUT-008 | Journey 병목·Campaign Brief 초안 | P0 | PLANNED | WF-006 / SOP-011 |
| AUT-009 | 채널별 콘텐츠 package·성과 metadata 생성 | P1 | PLANNED | WF-002, 006 / SOP-005, 011 |
| AUT-010 | CRM 대상 적격성·재구매 알림 | P1 | PLANNED | WF-006 / Customer Communication SOP 미정 |
| AUT-011 | 후기·Referral 요청 후보 생성 | P1 | PLANNED | WF-006 / Customer Communication SOP 미정 |
| AUT-012 | Weekly Revenue Readout | P0 | PLANNED | WF-006 / SOP-011 |

`SOP 미정` 항목은 구현 차단 상태다. 먼저 SOP와 데이터·승인 계약을 확정한다.

## CEO Marketing Bottleneck Candidates

1. **AUT-007 Revenue Snapshot:** SmartStore·아이디어스·주문·비용 수치를 같은 기준일로
   모아 대표의 수기 집계를 줄인다.
2. **AUT-012 Revenue Readout:** Journey·채널·제품·Campaign별 병목과 데이터 품질 경보를
   주간 Review 초안으로 만든다.
3. **AUT-008 Campaign Brief:** 승인된 병목·Knowledge에서 가설·KPI·Guardrail·승인 항목을
   가진 Brief 초안을 만든다.
4. **AUT-009 Content Package:** 하나의 승인 메시지를 채널별 형식으로 변환하고 Campaign-ID와
   성과 metadata를 붙인다.
5. **AUT-010/011 CRM·Review 후보:** 고객 동의·제외 기준을 확인해 발송 후보만 만들고,
   외부 발송은 별도 SOP와 Human Gate 전에는 자동화하지 않는다.

첫 자동화는 게시·발송보다 Revenue 데이터 수집·정합성과 Review 준비를 우선한다.

## Revenue Runtime Activation Order

```text
AUT-007 Revenue Snapshot
→ AUT-012 Weekly Revenue Readout
→ AUT-008 Campaign Brief
→ AUT-009 Channel Content Package
→ AUT-010/011 CRM·Review 후보
```

`AUT-007`의 원천·산식·품질 Gate가 `PILOT` 기준을 충족하기 전에는 `AUT-012`가 확정
매출을 보고하거나 `AUT-008`이 매출 개선률을 가정하지 않는다.
