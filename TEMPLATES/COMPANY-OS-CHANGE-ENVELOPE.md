# Company OS 변경 내부 Envelope

- 상태: PROPOSED
- 버전: 0.1
- 소유자: GP Company CEO / Codex Policy Owner
- 적용 Decision: DEC-0017
- 적용 SOP: SOP-016

대표나 직원이 작성하는 양식이 아니다. Atlas, Hermes와 Codex가 대표의 자연어 요청을
정책 작업으로 분류한 경우 내부적으로 생성한다.

## 사람에게 보이는 접수 보고

```text
<업무명>으로 접수했습니다.
현재 확인할 것은 <핵심 확인 항목>입니다.
<승인 범위 안에서 바로 할 일>은 진행하고, <대표 결정이 필요한 지점>에서 보고드리겠습니다.
```

## 내부 기록

```yaml
task_id: GP-YYYYMMDD-NNN
request_source: workbench_ceo_office | transition_slack | linked_channel
requester: authorized_user_reference
natural_language_intent: ""
desired_outcome: ""
constraints: []
important_timing: null

current_os_ref: ajseo-gp/gp-company-os@<40-char-sha>
direction_profile: D0 | D1 | D2
classification:
  os_change_required: true | false | review
  document_types: [Decision, Context, SOP, Workflow, Agent, Automation, Knowledge]
  implementation_tasks_separated: []

impact_review:
  active_decisions: []
  conflicts: []
  authority_changes: []
  approval_gate_changes: []
  affected_domains: []
  affected_repositories: []
  revenue_customer_operating_impact: []
  confirmed_facts: []
  unconfirmed_items: []

ceo_decision_package:
  conclusion: ""
  why_now: ""
  options: []
  atlas_recommendation: ""
  trade_offs: []
  safe_default_without_response: ""
  next_report_condition: ""

policy_state: REQUESTED | CLASSIFIED | IMPACT_REVIEW | DRAFT_READY | CEO_APPROVED |
  REVISION_REQUESTED | REJECTED | ACTIVE | REVIEW | ARCHIVED
review_revision: null
approved_revision: null
active_os_ref: null

downstream:
  - target: ""
    owner: ""
    state: NOT_REQUIRED | DELIVERY_PENDING | DELIVERED | IMPLEMENTED | APPLIED | VERIFIED
    evidence: []
    result_pending: null

authority:
  grant: []
  revoke_or_freeze: []
  expiry_or_review_condition: []

completion:
  verified: false
  unresolved_items: []
  learning_candidate: null
```

## 생성 확인

- [ ] 같은 목적의 열린 정책 작업과 중복되지 않는다.
- [ ] 정확한 OS-Ref와 관련 ACTIVE Decision을 확인했다.
- [ ] 정책 변경과 구현 작업을 분리했다.
- [ ] 대표 승인 대상과 안전하게 계속할 일을 구분했다.
- [ ] 대표가 볼 결정안은 한 항목으로 압축했다.
- [ ] 승인 revision과 실제 merge revision을 분리 기록한다.
- [ ] 정책 상태와 대상별 적용 상태를 분리했다.
- [ ] 권한 부여·회수·기한·재개 조건을 기록했다.
- [ ] 다른 저장소 상태를 추정하거나 OS에 복제하지 않았다.
- [ ] 모든 적용 대상이 VERIFIED 또는 NOT_REQUIRED여야 완료된다.
