# Management Dashboard

- 상태: DRAFT
- 버전: 0.2
- 소유자: GP Company CEO / Revenue Analytics Owner
- 적용 Decision: DEC-0009
- 기준일: 2026-07-23

## Phase 1 Minimum Viable Dashboard

첫 화면은 다음 다섯 가지에 답해야 한다.

1. 이번 주 B2C 순매출은 기준선보다 좋아졌는가?
2. 기여이익을 남기는 성장인가?
3. 신규 고객과 재구매 매출 중 어디가 변했는가?
4. SmartStore와 아이디어스 중 어느 채널·Journey가 가장 큰 병목인가?
5. 이번 주 `SCALE`, `ITERATE`, `STOP`할 Campaign은 무엇인가?

모든 숫자에는 기간, 기준시각, 원천, `READY/PARTIAL/BLOCKED/NOT_AVAILABLE` 상태와
기준선 대비를 표시한다. 데이터 상태가 다른 숫자를 하나의 확정 합계처럼 표시하지 않는다.

## CEO Summary

### Revenue First

- 이번 주 B2C 순매출·기여이익과 기준선·목표 대비
- 신규 고객·신규 고객 매출·CAC
- 재구매 매출 비중·재구매율
- SmartStore: 방문·전환·주문·매출·ROAS·기여이익
- 아이디어스: 신규 고객·즐겨찾기·전환·리뷰·매출·기여이익
- Journey 병목: Acquisition / Activation / Conversion / Retention / Referral
- 진행 Campaign과 `SCALE`, `ITERATE`, `STOP`
- 데이터 품질·attribution·중복 매출 경보
- 대표의 마케팅 승인·분석·실행 병목시간

### Data Quality Banner

- Snapshot 기준일·기준시각과 마지막 성공 수집
- 필수 원천 완전성, 지연·중복 주문과 미해결 reconciliation
- 환불·취소 반영 상태와 승인 원가·광고비·수수료 포함 범위
- attribution model·window와 직접 매출·기여 매출 구분
- `BLOCKED` Metric과 해결 Owner·예정일

### Revenue Engine 1 — Hair & Scalp

- B2B/B2C 매출과 기여이익
- 입금 완료 / 미수금
- 신규 OEM 문의
- 연구중·지연 레시피와 확정 대기
- 샘플 조정과 레시피→견적→LOT 연결 상태
- 발송 견적
- 계약·생산 진행 건
- B2C 주문·재구매
- 콘텐츠의 자격 있는 유입·다음 행동·직접·보조 전환

### Revenue Engine 2 — AI & Company OS

- 내부 검증 사례와 측정 결과
- 외부 문의·제안·계약
- 구축 매출과 반복 매출
- 제품·서비스 도입 현황
- 고객이 확인한 성과

### Company Control

- 현금잔고와 4주 전망
- 대표 직접 반복업무와 승인 대기
- Agent 절감시간·재작업·오류
- 하위 저장소 OS 동기화 상태
- 코드·브랜드·계약·데이터 소유권 미확인 항목

## Update Frequency

- 현금·미수금: 주 2회 이상
- OEM Pipeline: 실시간 또는 일간
- B2C 판매: 일간
- 콘텐츠: 주간
- SmartStore·아이디어스 판매·광고: 일간
- Revenue Campaign·Journey 병목: 주간
- AI·Company OS Pipeline: 주간
- Agent·Repository Governance: 주간
- 자산 소유권과 양도가능성: 월간
- 전체 CEO Dashboard: 주간

## Phase 1 Exit

- SmartStore·아이디어스 Revenue Snapshot이 동일한 기준일로 생성된다.
- CEO Weekly Revenue Review가 `READY` 또는 범위가 명확한 `PARTIAL` 데이터로 진행된다.
- 첫 Campaign이 기준선·비용·결과와 `SCALE/ITERATE/STOP`에 연결된다.
- 누락·권한·산식 문제는 숫자 0이 아니라 `BLOCKED/NOT_AVAILABLE`로 노출된다.

## Related Documents

- KPI: `KPI.md`
- Weekly Review: `WEEKLY-REVIEW/TEMPLATE.md`
- Workflow: `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`
- Automation: `../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-007_REVENUE-SNAPSHOT.md`
