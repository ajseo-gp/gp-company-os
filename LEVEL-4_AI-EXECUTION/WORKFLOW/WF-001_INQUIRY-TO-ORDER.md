# WF-001 Inquiry to Order

```text
문의 접수
→ OEM Intake Agent 분석
→ 누락정보 요청
→ 제조 가능성 검토
→ 가견적 작성
→ CEO 승인
→ 고객 발송
→ 후속 연락
→ 연구 조건 등록
→ 레시피 연구중
→ 레시피 확정
→ 샘플 개발·조정
→ 본견적·계약
→ 수주 확정·생산 스케쥴
→ LOT·생산 준비
→ 생산·검수
→ 납품
→ 재발주 관리
```

## State Controls

- 연구가 필요한 제품은 확정 레시피 없이 본견적·생산으로 넘기지 않는다.
- 연구중 저장은 생산 스케쥴을 생성하지 않는다.
- 레시피 확정 시 동일 레시피의 스케쥴을 한 건만 생성한다.
- 수주 또는 LOT가 연결된 확정 레시피는 승인된 정정 절차 없이 연구중으로 되돌리지 않는다.
- 실제 고객·처방·원가 데이터는 공개 저장소와 Slack에 기록하지 않는다.

## Related SOP

- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-001_OEM-INQUIRY.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-002_QUOTATION.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-010_RESEARCH-TO-PRODUCTION.md`

## KPI

- 최초 응답시간
- 문의→견적 전환율
- 견적→계약 전환율
- 평균 계약금액
- 평균 리드타임
- 연구 리드타임
- 레시피 확정→견적→수주→LOT 연결률
