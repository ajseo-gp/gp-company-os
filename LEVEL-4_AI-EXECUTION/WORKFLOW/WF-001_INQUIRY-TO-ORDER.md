# WF-001 Inquiry to Order

- 상태: ACTIVE
- 소유자: OEM Owner / Production Owner
- 적용 사업: Hair & Scalp B2B
- 버전: 0.2

## Purpose

고객 문의를 검증 가능한 연구·견적·수주·생산·납품 기록으로 연결한다.

## Trigger and Completion

- Trigger: 신규 OEM/B2B 문의가 고유 문의 ID로 접수됨
- 완료: 납품·후속 조치가 기록되거나, 취소 사유와 승인자가 기록됨

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

## Roles and Handoffs

| 구간 | 책임 | 인계 |
|---|---|---|
| 문의·분류 | OEM Intake | 구조화 요구와 누락정보 |
| 연구 | Research Owner / R&D Agent | 승인된 recipe revision과 검증 범위 |
| 견적·수주 | OEM Owner / CEO | 승인된 가격·조건과 주문 상태 |
| 생산·출고 | Production Owner / Production Agent | LOT·검수·출고 증거 |
| 후속·학습 | Customer / Knowledge Steward | 응대 상태와 Knowledge 후보 |

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

## Knowledge Feedback

반복되는 고객 요구는 INSIGHT, 재현된 연구·생산 교훈은 LESSON/PRACTICE, 실패 조건은
FAILURE 후보로 분류한다. 원본 고객정보와 처방은 Knowledge에 복사하지 않는다.
