# DEC-0011 Evidence-to-Improvement Organizational Learning

- 상태: ACTIVE
- 결정일: 2026-07-26
- 적용일: 2026-07-26
- 결정자: GP Company CEO
- 소유자: GP Company CEO / Knowledge Steward
- 승인 근거: 2026-07-26 CEO의 Company OS 관련 활성화 패키지 승인
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

GP Company OS에는 Revenue Campaign 학습과 Targeted Knowledge Refresh가 존재하지만,
전사 반복 실행이 과거 학습을 먼저 소비하고 결과를 다시 운영 계약에 반영하도록 강제하는
공통 폐쇄 루프는 없다.

`DEC-0010`은 Repository·공식 원천·운영 Evidence의 변경분을 찾아 지식을 최신으로
유지한다. 이것만으로는 실행 결과에서 무엇을 배웠고 다음 Agent의 행동이 실제로
바뀌었는지 보장하지 않는다. Marketing 외 B2B·OEM·R&D·Production·Workbench·AI/OS
업무에도 같은 학습 구조가 필요하다.

AI Native Company의 학습은 모델이 임의로 정책을 바꾸는 것이 아니다. 승인된 범위에서
실행하고, 결과 Evidence를 검증하며, 재사용 가능한 학습을 SOP·Prompt·Agent·Automation에
연결하고, 다음 실행에서 개선 여부를 확인하는 운영 능력이다.

## 결정

다음을 전사 운영 원칙으로 적용한다.

1. 반복 가능하거나 Revenue·고객·품질·비용·대표 병목에 영향을 주는 Task는
   `Evidence-to-Improvement` 학습 계약을 가진다.
2. 실행 Agent는 작업 전에 관련 ACTIVE Knowledge, 최근 비교 가능한 EXPERIMENT·FAILURE와
   적용 SOP를 읽고 적용 항목·비적용 이유·미확인을 `Learning Preflight`에 남긴다.
3. Task는 실제 결과와 Evidence를 기록한다. 결과 측정이 나중이면 `RESULT_PENDING`으로
   두고 Owner·측정일·원천을 지정하며, 측정 전 성과를 확정하지 않는다.
4. Task 종료 시 새 학습 후보 또는 근거가 있는 `NO_NEW_LEARNING`을 남긴다. 반복 문제를
   단순 메모로 닫지 않는다.
5. 학습 후보는 회사 사실, 관측 Evidence, 해석·가설과 미확인을 분리하고
   EXPERIMENT·PRACTICE·FAILURE·INSIGHT·LESSON 중 하나로 분류한다.
6. Knowledge 생성만으로 학습 완료로 보지 않는다. 어떤 SOP·Prompt·Agent·Workflow·
   Automation이 다음 실행 전에 읽을지 `Enforcement Point`를 지정한다.
7. 다음 비교 가능한 실행에서 적용 여부와 결과를 검증한다. 재사용이 확인되지 않은 학습은
   `REUSE_UNVERIFIED` 상태로 유지하고 전사 Best Practice로 단정하지 않는다.
8. 단일 성공은 EXPERIMENT이며, 조건을 달리한 반복 Evidence와 적용 범위가 확인된 경우에만
   PRACTICE로 승격한다. 반증·환경 변경·성과 악화가 확인되면 범위를 축소하거나 보관한다.
9. 학습 깊이는 위험과 반복성에 비례한다.
   - `L0`: 저위험 일회성 작업 — 결과와 예외만 기록
   - `L1`: 반복 작업 — Preflight, 결과, 학습 후보와 다음 소비자 기록
   - `L2`: Revenue·고객·규제·생산·고비용 작업 — 기준선·가설·Guardrail·승인·결과·
     Enforcement·Reuse Verification 전체 적용
10. `Revenue First`는 유지한다. 학습은 매출을 2순위로 내리는 별도 목적이 아니라
    고객 확보·판매·재구매와 대표 병목 감소를 더 빠르고 반복 가능하게 만드는 배율이다.
11. AI는 학습 후보와 변경 초안을 만들 수 있지만 ACTIVE Decision·SOP·권한·승인 Gate를
    스스로 변경하지 않는다.
12. 원본 Evidence와 민감정보는 권한 있는 운영 저장소에 두고 OS에는 안전한 Evidence ID,
    검증 결과, 적용 범위와 운영 계약만 남긴다.
13. 이 Decision의 활성화 revision은 `SYSTEM_BOOT.md`의 AI Task Boot와 최소 결과 계약에
    Knowledge 사전 조회, 적용·비적용 이유와 사용 Evidence를 필수로 반영해야 한다.
    Decision만 ACTIVE로 바꾸고 Boot 계약을 그대로 두는 변경은 승인 완료로 보지 않는다.
14. Enforcement Point는 문서에 이름만 지정해서는 안 된다. 소비 파일의 정확한 경로와
    revision, 필수 조회 marker 또는 역참조를 가진 기계 검증 가능한 계약으로 등록하고,
    CI가 파일 존재·역참조·상태를 확인해야 한다.

## Repository and Runtime Contract

| 계층 | 책임 |
|---|---|
| `gp-company-os` | 학습 정책, 검증된 Knowledge, Workflow·SOP·Agent·Automation 계약 |
| `gp-company-hub` | Task 시작 전 학습 조회, Task 종료 후 결과·후보 라우팅, Enforcement 참조 주입 |
| `gpcompany-lab` / GP Workbench | Learning 상태, Owner·측정일, Evidence link, 재사용 여부와 KPI 표시 |
| 승인된 운영 저장소 | 채널·고객·연구·생산·비용의 권한 있는 원본 Evidence |

Hub와 Workbench의 실제 구현 상태는 별도 Repository 감사 전까지 `미확인`으로 유지한다.

## 이유

학습이 없는 자동화는 같은 행동을 더 빠르게 반복할 뿐이다. 반대로 학습 파일만 쌓고
실행자가 읽지 않으면 행동은 변하지 않는다. 사전 소비, 사후 Evidence, 운영 계약 반영과
재사용 검증을 하나의 루프로 묶어야 AI 실행량이 늘수록 회사의 성과와 재현성이 함께
개선된다.

위험 기반 깊이를 사용하면 모든 사소한 Task에 무거운 회고를 강제하지 않으면서 Revenue와
반복 업무에서 학습 누락을 막을 수 있다.

## 영향 범위

### 적용

- 전사 반복 Task와 Marketing·B2B/OEM·R&D·Production·Workbench·AI/OS 실행
- Hermes Task Envelope와 Agent 입력·출력·인계 계약
- Knowledge Steward의 검증·승격·재사용 확인 책임
- Workflow·SOP·Prompt·Agent·Automation 템플릿과 활성화 Gate
- Weekly Review·CEO Review·KPI·Dashboard
- OS·Hub·Workbench 간 Learning Record와 Evidence 참조

### 비적용

- Revenue First, 보안, 법률·규정, 외부 발행, 가격·계약·생산 승인 Gate를 우회하지 않는다.
- 모델 가중치의 자율 학습이나 비승인 데이터 수집을 허용하지 않는다.
- 고객 PII, 처방·함량, 원가·단가, 계약 비밀과 credential 원문을 OS에 저장하지 않는다.
- 단일 실행의 상관관계를 인과관계나 전사 Best Practice로 자동 승격하지 않는다.
- 모든 Task에 동일한 문서량과 분석비용을 강제하지 않는다.

## 결과와 Trade-off

- 같은 실패와 대표의 반복 지시를 줄이고 Agent 결과의 누적 개선을 검증할 수 있다.
- 초기에는 Learning Record, Owner, 측정일과 Enforcement 관리 비용이 증가한다.
- 측정 가능한 결과가 늦게 나타나는 Task는 `RESULT_PENDING`이 늘 수 있다.
- Knowledge Steward가 PLANNED인 동안 수동 검토 책임자를 지정해야 한다.
- 학습 KPI가 문서 개수 중심으로 변질될 위험을 재사용률·성과 변화·실패 재발률로 통제한다.

## 전환과 검증

1. 하나의 승인 revision에 이 Decision, `WF-008`, `SOP-013`과 다음 P0 변경을 포함한다.
   - `SYSTEM_BOOT.md`: AI Task Boot의 사전 Knowledge 조회와 최소 결과의 적용·비적용 기록
   - Agent·Workflow·Knowledge·Task 템플릿: Preflight, Outcome, Enforcement, Reuse field
   - `scripts/validate_os.rb`: 기계 판독 가능한 Enforcement 계약의 경로·역참조 검사
2. `SOP-006`의 출력 계약을 템플릿 자체가 아니라 기준기간을 가진 불변 Review 인스턴스로
   수정하고, 원본 저장소·파일명·ID 규칙을 확정한다.
3. Knowledge Steward가 PLANNED인 동안 WF-006·WF-007·WF-008의 수동 Reviewer와 대리자를
   지정한다. 수동 Owner가 없으면 해당 학습 상태 전이를 ACTIVE 실행으로 보고하지 않는다.
4. CEO가 이 전체 변경의 정확한 commit SHA와 적용일을 승인한다.
5. 현재 Revenue 우선순위와 직접 연결된 젠틀파파 B2C Campaign을 첫 `L2` PILOT으로 한다.
6. 비교 가능한 다음 Campaign에서 학습 소비와 결과 변화를 확인한다.
7. B2B/OEM 또는 Workbench 반복 Task 한 종류에 두 번째 Domain PILOT을 수행해 전사 적용
   가능성을 검증한다.
8. Hub에는 학습 조회·주입·후보 라우팅, Workbench에는 상태·Evidence·Owner·KPI 표시
   구현 후보를 정확한 Repository revision과 함께 만든다.
9. 최소 2개 Domain에서 2회 이상의 비교 가능한 루프가 닫힌 뒤 자동화 후보를 설계한다.

### 1회차 성공 기준 — 학습 생산

- Learning Preflight, 기준선·가설·Guardrail과 Outcome 또는 `RESULT_PENDING` 완결
- 검증 가능한 EXPERIMENT·FAILURE·INSIGHT·LESSON 후보 또는 근거 있는
  `NO_NEW_LEARNING`
- 원본 Evidence ID, Reviewer, 적용·제외 범위와 Enforcement Point 등록
- 소비 파일의 역참조와 CI 검증 통과

### 2회차 이후 성공 기준 — 학습 재사용과 성과

- 비교 가능한 다음 Task가 학습을 실제 조회·적용하거나 승인된 비적용 이유를 기록
- 적용 전후 결과와 Guardrail 비교
- 학습의 유지·범위 축소·PRACTICE 승격·REVIEW·ARCHIVE 판정
- 같은 FAILURE 재발과 대표의 반복 지시·재작업 감소

공통 Guardrail은 승인 없는 ACTIVE 기준 변경과 민감정보 유출 0건이다.

## 재검토 조건

- 학습 기록 비용이 성과 개선보다 커질 때
- `NO_NEW_LEARNING` 남용이나 결과 미측정 Task가 누적될 때
- 잘못된 Knowledge가 반복 적용되어 성과·품질·안전을 악화시킬 때
- Repository별 원본 책임이나 Runtime 구조가 변경될 때
- Knowledge Steward 또는 학습 자동화를 PILOT·ACTIVE로 전환할 때
- Revenue 우선순위나 Customer Journey가 변경될 때

## 활성화와 남은 승인사항

- 이 Decision과 Company OS 활성화 패키지는 2026-07-26 승인되었다.
- 첫 L2 PILOT을 시작하기 전에 실행 Owner, 수동 Knowledge Reviewer·대리자와 측정일을
  Task별로 지정한다. 역할이 비어 있으면 PILOT을 시작하지 않는다.
- Weekly Review 실행 기록의 원본은 GP Workbench로 한다. 구현 전 임시 원본이 필요하면
  승인된 운영 저장소와 안전한 Review-ID를 지정하며 OS에 운영 원문을 복사하지 않는다.
- 외부 게시·광고·가격·고객 발송, Hub·Workbench 코드 변경과 Agent·Automation의
  PILOT·ACTIVE 전환은 이번 승인에 포함되지 않으며 기존 Gate를 따른다.

## 관련 문서

- Business: `../../LEVEL-2_BUSINESS/BUSINESS.md`, `../../LEVEL-2_BUSINESS/MARKETING.md`
- Context: `../CONTEXT/ORGANIZATIONAL-LEARNING-GAP.md`
- Decision: `DEC-0009_REVENUE-FIRST.md`, `DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-008_ORGANIZATIONAL-LEARNING-LOOP.md`
- SOP: `../SOP/SOP-013_ORGANIZATIONAL-LEARNING-CYCLE.md`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-KNOWLEDGE-STEWARD.md`,
  `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- KPI: 재사용률, 개선 반영시간, 동일 실패 재발률, Revenue·대표 병목 개선
