# WF-006 Revenue Growth Loop

- 상태: ACTIVE
- 소유자: GP Company CEO / Marketing Owner
- 적용 사업: Hair & Scalp B2C
- 버전: 1.1
- 적용 Decision: DEC-0009
- 작성일: 2026-07-23
- 변경일: 2026-07-26
- Learning-Ref: DEC-0011

## Purpose

Customer Journey의 가장 큰 매출 병목을 Campaign으로 실행하고, 결과 Evidence를
Knowledge·Decision·SOP와 다음 Campaign에 환류한다.

## Trigger and Completion

- Trigger: Revenue Review에서 Journey·채널·제품의 우선 병목이 근거와 함께 선택됨
- 완료: Campaign 결과, Revenue Evidence, `SCALE/ITERATE/STOP`, Knowledge 후보와 다음
  행동이 기록되거나 승인된 취소 사유가 기록됨

## Revenue Loop

```text
Revenue 목표·병목
→ Campaign Brief
→ 예산·표현·발행 승인
→ 전문 Marketing Agent 실행
→ 채널·주문·비용 Evidence
→ Revenue Analytics
→ SCALE / ITERATE / STOP
→ Knowledge / Decision / SOP
→ 다음 Campaign
```

## Roles and Handoffs

| 구간 | 책임 | 입력 | 출력 |
|---|---|---|---|
| 병목·우선순위 | Growth Orchestrator | KPI, 재고·마진·예산, Knowledge | 우선 Journey·Campaign |
| 채널 실행 | SmartStore / Idus Growth | 승인된 Brief와 Guardrail | 채널 revision·결과 |
| 콘텐츠 | Content Agent | 메시지·CTA·Evidence | 발행 가능한 콘텐츠 package |
| 재구매 | CRM Retention | 동의된 구매·Segment | 발송 package·재구매 결과 |
| 후기·추천 | Review & Referral | 구매·후기·동의 | 리뷰·추천 Evidence |
| 측정 | Revenue Analytics | 채널·주문·비용·Campaign data | Revenue readout·품질 경보 |
| 학습 | Knowledge Steward | 결과·실패·적용 범위 | Knowledge·SOP·Decision 후보 |

## State Model

| 현재 상태 | 진입 조건 | 다음 상태 | 책임자 | 생성 기록 |
|---|---|---|---|---|
| `BOTTLENECK_IDENTIFIED` | KPI·Evidence로 병목 식별 | `BRIEF_DRAFTED` | Growth Orchestrator | 병목·기준선 |
| `BRIEF_DRAFTED` | Campaign 계약 완성 | `APPROVAL_PENDING` | 실행 Agent | Brief·예상 영향 |
| `APPROVAL_PENDING` | 예산·표현·발행 Gate 제출 | `APPROVED`, `REJECTED` | 승인권자 | 승인·수정·거절 |
| `APPROVED` | scope·revision·기간 고정 | `RUNNING` | 실행 Agent | Campaign-ID |
| `RUNNING` | 승인 범위 내 실행 | `MEASURING`, `PAUSED` | 실행 Agent | 실행·비용 Evidence |
| `MEASURING` | 결과 측정일 도달 | `REVIEWED`, `DATA_BLOCKED` | Revenue Analytics | KPI·품질·attribution |
| `REVIEWED` | 결과와 Guardrail 검토 | `SCALE`, `ITERATE`, `STOP` | Growth Orchestrator/CEO | 결과 Decision |
| `SCALE` | 확대 승인 | `BRIEF_DRAFTED`, `CLOSED` | Owner | 확대 scope·예산 |
| `ITERATE` | 새 가설·변수 정의 | `BRIEF_DRAFTED` | 실행 Agent | 다음 revision |
| `STOP` | 중단·손실·학습 기록 | `KNOWLEDGE_PROPOSED` | Owner | 중단 사유 |
| `KNOWLEDGE_PROPOSED` | 근거·범위·검증자 포함 | `CLOSED` | Knowledge Steward | Knowledge 후보 |

## Campaign Data Contract

- Campaign-ID, Task-ID와 가능한 경우 OS-Ref
- Journey 단계, 채널, 제품·Offer와 대상 Segment
- 가설, 기준선, 목표 KPI와 Guardrail
- 기간, Owner, 예산·할인·발행 승인
- 콘텐츠·상세페이지·쿠폰·광고 revision
- 방문·행동·주문·환불·매출·비용 데이터 원천과 기준 시각
- attribution model·window·제외 조건 또는 직접 관측만 가능 표시
- `SCALE`, `ITERATE`, `STOP`과 Knowledge 후보

## Related SOP

- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-005_CONTENT-PRODUCTION.md`

채널별 외부 발행·고객 발송 SOP가 없으면 해당 단계는 자동화하지 않고 Human Gate를 유지한다.

## Approval and Exceptions

- Campaign 시작: 예산·할인·가격·Claim·발행·고객 발송 범위 승인
- Campaign 확대: 실제 결과·기여이익·재고·현금 Guardrail 재검토
- 데이터 예외: attribution·원가·주문 중복 문제를 숨기지 않고 `DATA_BLOCKED`
- 긴급 중단: 법규·브랜드·고객 불만·비용 폭주·재고 위험 시 Owner가 중지 후 보고

## Cancellation and Recovery

- 취소·중단 시 이미 사용한 비용, 노출·발송, 고객 영향과 복구 필요사항을 기록한다.
- 게시물·쿠폰·광고 rollback 가능 여부와 Owner를 Brief에 포함한다.
- 잘못된 매출 연결은 원본을 삭제하지 않고 정정 이력을 남긴다.

## Knowledge Feedback

Campaign 시작 전 관련 ACTIVE Knowledge와 비교 가능한 EXPERIMENT·FAILURE를 읽고
적용·비적용 이유를 Learning Preflight에 남긴다. Campaign Outcome은 `WF-008`로
Enforcement Point와 다음 비교 Campaign의 Reuse Verification까지 연결한다.

```text
Evidence
→ EXPERIMENT / FAILURE / INSIGHT 후보
→ Knowledge Steward 검증
→ SCALE / ITERATE / STOP Decision
→ SOP·Prompt·Workflow 개선
→ 다음 Campaign
```

한 번의 성공은 EXPERIMENT다. 조건을 달리해 반복 재현되고 적용 범위가 확인된 경우에만
PRACTICE로 승격한다. 실패도 비용·조건·원인·재발 방지를 포함해 FAILURE로 남긴다.

## KPI

- Revenue: 매출, 기여이익, 신규 고객, 재구매 매출
- Journey: Acquisition→Activation→Conversion→Retention→Referral 단계 전환
- Channel: SmartStore·아이디어스별 방문, 전환, 주문, 매출, 비용
- Execution: Brief→Launch 시간, Campaign 완료율, 승인 대기와 재작업
- Learning: 완결된 Experiment, 재현된 Practice, Failure 재발률
- CEO Bottleneck: 대표의 마케팅 실행·분석·승인 시간

KPI 산식·원천·주기·목표는 `LEVEL-5_MANAGEMENT-CONTROL/KPI.md`와 CEO Decision을 따른다.

## Related Documents

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0009_REVENUE-FIRST.md`
- `../../LEVEL-2_BUSINESS/MARKETING.md`
- `../AGENTS/AGENT-MARKETING-GROWTH-TEAM.md`
- `../../LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
