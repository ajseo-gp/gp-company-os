# WF-008 Organizational Learning Loop

- 상태: ACTIVE
- 소유자: Knowledge Steward / GP Company CEO
- 적용 사업: 전사
- 버전: 1.0
- 작성일: 2026-07-25
- 검토일: 2026-08-26
- 적용 Decision: DEC-0011
- Learning-Ref: DEC-0011

## Purpose

반복 실행이 과거의 검증된 학습을 먼저 사용하고, 실제 결과를 Evidence로 남기며,
검증된 개선을 다음 실행 계약에 반영하고 재사용 효과까지 확인하도록 한다.

## Trigger and Completion

### Trigger

- 반복 가능한 Task 또는 Workflow가 생성됨
- Revenue·고객·품질·비용·규제·생산·대표 병목에 영향을 주는 L2 Task가 생성됨
- 반복 실패, 결과 편차, 고객 행동 변화 또는 새로운 운영 Evidence가 감지됨
- 기존 Knowledge의 반증·만료·Runtime drift가 발견됨

### Completion

- L0: 결과·예외가 기록됨
- L1: Learning Preflight, Outcome, 학습 후보 또는 `NO_NEW_LEARNING`, 다음 소비자가 기록됨
- L2: 기준선·가설·Guardrail·승인·Outcome·Enforcement Point와 비교 가능한 다음 실행의
  Reuse Verification이 연결됨
- 결과가 아직 없으면 `RESULT_PENDING` Owner·측정일·원천이 지정됨
- ACTIVE 기준 변경은 승인 전 후보 상태로 유지됨

## Roles and Systems

| 단계 | 책임 | 시스템 | 입력 | 출력 |
|---|---|---|---|---|
| 등급·범위 | Hermes / Workflow Owner | Hub·Workbench | Task 목적·위험·반복성 | L0/L1/L2·완료 계약 |
| 사전 학습 | 실행 Agent | OS·Hub | ACTIVE Knowledge·최근 비교 Evidence | Learning Preflight |
| 실행·Evidence | Domain Agent / Operator | 운영 원본·Workbench | 승인된 Task·SOP | 실제 결과·예외·Evidence ID |
| 검토·분류 | Knowledge Steward / 수동 Reviewer | OS Review Queue | Preflight·Outcome·Evidence | 학습 후보·신뢰·적용 범위 |
| 운영계약 반영 | 문서 Owner | OS·Hub | 승인된 학습 | SOP·Prompt·Agent·Workflow 후보 |
| 재사용 검증 | 다음 실행 Agent / Reviewer | Hub·Workbench | Enforcement Point·후속 Outcome | 적용 여부·결과 차이 |
| 경영 통제 | CEO Co-Operator / CEO | Review·Dashboard | 학습·성과 KPI | SCALE·ITERATE·STOP·승인 |

Knowledge Steward Runtime이 PLANNED인 동안 각 활성 Domain은 CEO가 승인한 수동 Reviewer와
대리자를 가져야 한다. `Knowledge Steward`라는 역할명만 기록하고 실제 수행자를 지정하지
않은 상태 전이는 실행 완료로 보지 않는다.

## State Model

```text
TASK_SCOPED
→ LEARNING_PREFLIGHT_DONE
→ RUNNING
→ OUTCOME_CAPTURED 또는 RESULT_PENDING
→ LEARNING_REVIEWED
→ NO_NEW_LEARNING 또는 KNOWLEDGE_PROPOSED
→ CONTROL_UPDATE_PROPOSED
→ APPROVED_AND_ENFORCED
→ REUSE_PENDING
→ REUSE_VERIFIED
→ CLOSED
```

| 현재 상태 | 조건/입력 | 다음 상태 | 책임자 | 관련 SOP | 생성 기록 |
|---|---|---|---|---|---|
| `TASK_SCOPED` | Task 등급·Domain·완료조건 확정 | `LEARNING_PREFLIGHT_DONE` | Hermes / Owner | SOP-013 | 등급·조회 범위 |
| `LEARNING_PREFLIGHT_DONE` | 적용·비적용 학습 기록 | `RUNNING` | 실행 Agent | Domain SOP | Preflight |
| `RUNNING` | 결과 측정 가능 | `OUTCOME_CAPTURED` | Domain Agent | Domain SOP | Outcome·Evidence |
| `RUNNING` | 결과가 미래 시점에 발생 | `RESULT_PENDING` | Owner | SOP-013 | 측정 Owner·일자 |
| `RESULT_PENDING` | 측정일·원천 도달 | `OUTCOME_CAPTURED` | Owner / Analytics | SOP-013 | Outcome·품질 상태 |
| `OUTCOME_CAPTURED` | 사실·가설·미확인 분리 | `LEARNING_REVIEWED` | Reviewer | SOP-013 | 분류·신뢰·범위 |
| `LEARNING_REVIEWED` | 재사용 가치 없음 | `NO_NEW_LEARNING` | Reviewer | SOP-013 | 근거 |
| `LEARNING_REVIEWED` | 재사용 후보 존재 | `KNOWLEDGE_PROPOSED` | Knowledge Steward | SOP-013 | Knowledge 후보 |
| `KNOWLEDGE_PROPOSED` | 소비 계약 변경 필요 | `CONTROL_UPDATE_PROPOSED` | 문서 Owner | SOP-013 | 영향 분석·diff |
| `CONTROL_UPDATE_PROPOSED` | 승인 완료 | `APPROVED_AND_ENFORCED` | 승인권자 | 관련 변경 SOP | revision·Enforcement |
| `APPROVED_AND_ENFORCED` | 비교 가능한 다음 Task 지정 | `REUSE_PENDING` | Owner | SOP-013 | 후속 Task·검증일 |
| `REUSE_PENDING` | 적용·Outcome 확인 | `REUSE_VERIFIED` | Reviewer | SOP-013 | 결과 차이·판정 |
| `NO_NEW_LEARNING` 또는 `REUSE_VERIFIED` | 감사 필드 완결 | `CLOSED` | Owner | SOP-013 | 최종 상태 |

## Approval and Exceptions

- ACTIVE Decision·SOP·Prompt·Agent 권한·Automation 의미 변경은 문서 Owner와 기존 승인
  Gate를 따른다.
- Revenue·가격·예산·Claim·외부 발행·고객 발송·생산·법률·규정 승인은 학습을 이유로
  생략하지 않는다.
- L2 등급을 L0/L1으로 낮출 때는 이유와 승인자를 남긴다.
- Knowledge Steward Runtime이 PLANNED인 동안 CEO가 지정한 수동 Reviewer가 역할을 맡는다.
- 출처·결과·적용 범위가 불명확하면 `EVIDENCE_BLOCKED`로 승격을 중지한다.

## Cancellation and Recovery

- Task 취소: 취소 원인·이미 발생한 영향·재개 조건과 학습 후보를 남긴다.
- 잘못된 학습 적용: 실행을 안전 상태로 되돌리고 관련 Knowledge를 `REVIEW`로 전환하는
  후보와 영향받은 소비자를 식별한다.
- 결과 측정 누락: 완료로 숨기지 않고 `RESULT_PENDING`을 유지해 Owner에게 재할당한다.
- 잘못된 일반화: 적용 범위를 축소하고 PRACTICE 승격을 취소하는 Decision 후보를 만든다.

## Knowledge Feedback

```text
Learning Preflight
→ Execution and Outcome Evidence
→ EXPERIMENT / FAILURE / INSIGHT / LESSON
→ Evidence Validation
→ Knowledge + Enforcement Point
→ SOP / Prompt / Agent / Workflow update
→ Next comparable execution
→ Reuse Verification
→ retain / narrow / promote / archive
```

`DEC-0010`·`WF-007`은 출처와 지식의 최신성을 갱신하고, 이 Workflow는 실행 결과로 행동을
개선한다. 두 Workflow는 서로 대체하지 않는다.

## KPI

- L1/L2 Preflight·Outcome·Enforcement 완전성
- 결과 발생→학습 검토→운영계약 반영 리드타임
- 다음 유사 Task의 검증된 학습 재사용률
- 동일 FAILURE 재발률과 재작업률
- EXPERIMENT→PRACTICE 승격의 재현 Evidence 완전성
- 학습 적용 전후 Revenue·기여이익·품질·리드타임·대표 병목 변화
- `RESULT_PENDING`, `REUSE_UNVERIFIED`, `EVIDENCE_BLOCKED` 체류시간
- `NO_NEW_LEARNING ÷ 학습 검토 완료 L1/L2 Task`와 반복 제출 Agent·Domain
- 승인 위반과 민감정보 노출

## Related Documents

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0011_ORGANIZATIONAL-LEARNING.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/ORGANIZATIONAL-LEARNING-GAP.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-013_ORGANIZATIONAL-LEARNING-CYCLE.md`
- `../AGENTS/AGENT-KNOWLEDGE-STEWARD.md`
- `../AGENTS/AGENT-HERMES.md`
- `../../TEMPLATES/LEARNING-RECORD-TEMPLATE.md`
