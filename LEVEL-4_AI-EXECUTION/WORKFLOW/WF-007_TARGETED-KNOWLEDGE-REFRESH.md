# WF-007 Targeted Knowledge Refresh

- 상태: ACTIVE
- 소유자: Knowledge Steward / GP Company CEO
- 적용 사업: 전사, 단 Domain·과제별 제한 범위
- 적용 Decision: DEC-0010

## 목적

현재 우선과제에 필요한 Repository·운영 Evidence·공식 외부 원천의 변경분만 검토해
Knowledge·Prompt·Context·SOP 개선 후보를 만들고 검증된 checkpoint를 보존한다.

## Trigger and Completion

### Trigger

- 작업 시작 시 관련 지식이 없거나 검토일이 지난 경우
- 주간: 활성 우선과제의 정기 Delta Refresh
- 월간: 공식 기준·Knowledge·Prompt·Repository 정합성 심층 Refresh
- 긴급: 법규·플랫폼·보안·API·핵심 데이터 정의 변경 신호

### 완료

- 범위와 예산 안에서 source revision과 변경분을 검토함
- 변경 없음 또는 변경 후보·영향·미확인·승인사항을 기록함
- 다음 checkpoint와 검토일을 남김
- ACTIVE 기준 변경은 승인 전 후보 상태로 유지함

## State Flow

```text
REQUESTED → SCOPED → BASELINE_LOCKED → DELTA_COLLECTED → VALIDATED
→ CHANGE_PROPOSED 또는 NO_CHANGE
→ APPROVAL_PENDING 또는 CHECKPOINTED → CLOSED
```

| 현재 상태 | 전이 조건 | 다음 상태 | 책임 |
|---|---|---|---|
| `REQUESTED` | 질문·우선과제 확인 | `SCOPED` | Owner / Hermes |
| `SCOPED` | Repository·원천·예산·완료조건 확정 | `BASELINE_LOCKED` | Knowledge Steward |
| `BASELINE_LOCKED` | 이전 checkpoint 확인 | `DELTA_COLLECTED` | Domain Agent |
| `DELTA_COLLECTED` | 출처·변경·보안·충돌 검증 | `VALIDATED` | Knowledge Steward |
| `VALIDATED` | 의미 있는 변경 없음 | `NO_CHANGE` | Knowledge Steward |
| `VALIDATED` | 개선·충돌 후보 존재 | `CHANGE_PROPOSED` | Knowledge Steward |
| `CHANGE_PROPOSED` | ACTIVE 의미·권한 변경 | `APPROVAL_PENDING` | CEO / Owner |
| `NO_CHANGE` 또는 승인 결과 | checkpoint 기록 | `CHECKPOINTED` | Knowledge Steward |
| `CHECKPOINTED` | 다음 검토일 기록 | `CLOSED` | Owner |

## Roles and Handoffs

| 단계 | 역할 | 입력 | 출력 |
|---|---|---|---|
| 접수·우선순위 | CEO Co-Operator / Hermes | 현재 과제·Revenue 기여 | Refresh 요청 |
| 범위·예산 | Knowledge Steward | OS Index·checkpoint | Scope Manifest |
| 변경 수집 | Domain Agent | 허용 Repository·공식 원천 | Delta Evidence |
| 검증·분류 | Knowledge Steward | Delta와 출처 | 문서 유형별 후보 |
| 승인 | CEO / 문서 Owner | 영향 분석·revision | 승인·수정·거절 |
| checkpoint | Knowledge Steward | 검증 결과 | 다음 baseline·검토일 |

상세 수행법은 `SOP-012`를 따른다. Hermes는 전사 조사로 자동 확대하지 않는다.

## Related SOP and Automation

- SOP: `SOP-012 Targeted Knowledge Refresh`
- 관련 Review: `SOP-006 Weekly Review`
- Automation: `AUT-013 Targeted Knowledge Refresh`
- Automation이 `PLANNED`인 동안 수동 수행한다.

## Exceptions and Escalation

- baseline 없음: 관련 문서의 첫 bounded baseline만 만들고 범위를 기록한다.
- source 접근 불가: `SOURCE_BLOCKED`, 대체 원천과 신뢰 차이를 보고한다.
- 예산 부족: `BUDGET_BLOCKED`, 완료 범위와 추가 조사 가치를 보고한다.
- 민감정보 필요: 승인된 보안 저장소와 최소 접근 원칙을 따른다.
- 간접 영향 발견: 중지 후 영향 Repository·예산 확장을 승인 요청한다.
- 법규·보안 위험: 일반 cadence를 중지하고 즉시 escalation한다.

## Outputs and Records

- Refresh-ID와 유형: `TASK`, `WEEKLY`, `MONTHLY`, `URGENT`
- 질문·Revenue 또는 운영 기여
- Scope Manifest, 제외 범위와 예산
- baseline·source revision·기준일
- 변경·충돌·미확인·접근 차단
- 변경 없음 또는 문서별 개선 후보
- 승인 결과, checkpoint와 다음 검토일

## Knowledge Feedback

Refresh 결과 자체가 Knowledge는 아니다. 검증된 회사 사실은 FACT, 재현된 운영 방법은
PRACTICE, 실패 조건은 FAILURE, 단일 실행은 EXPERIMENT, 반복 고객 행동은 INSIGHT 후보로
분류한다. 외부 공식 기준과 GP Company 성과 지식을 구분한다.

## KPI

- checkpoint·source revision·다음 검토일 완전성
- 전체 재독 대비 Delta 검토 비율과 동일 자료 재독 감소
- 공식 기준·Runtime drift 탐지 적시성
- 채택된 Knowledge·Prompt·SOP 개선안
- `BUDGET_BLOCKED`, `SOURCE_BLOCKED`와 누락 재발률
- Refresh당 토큰·시간 사용과 의사결정 기여

## 관련 문서

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-012_TARGETED-KNOWLEDGE-REFRESH.md`
- `../AGENTS/AGENT-KNOWLEDGE-STEWARD.md`
- `../AUTOMATION/AUT-013_TARGETED-KNOWLEDGE-REFRESH.md`
