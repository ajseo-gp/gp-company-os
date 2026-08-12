# DEC-0017 대표실 단일 접수·압축 보고와 무인 실행

- 상태: ACTIVE
- 결정일: 2026-08-12
- 적용일: 2026-08-12
- 결정자/소유자: GP Company CEO
- 승인 근거: PR #15 merge 후 2026-08-12 대표의 활성화 지시
- 적용 범위: 대표의 회사 운영 요청·보고·결정, Hermes 작업 큐, GP Workbench 대표실
- 대체하는 Decision: DEC-0005의 사람용 주 인터페이스 조항(전환 완료 후)
- 대체된 Decision: 없음

## 배경

대표의 요청과 보고가 ChatGPT, Codex, Slack, GitHub와 개별 작업 화면에 흩어지면 같은 일이
중복 접수되고, 서로 다른 시점의 답변이 하나의 결정처럼 섞인다. 대화와 보고가 늘어날수록
대표가 목록을 찾아 상태를 재구성해야 하므로, 자동화가 오히려 새로운 관리 업무를 만든다.

현재 `DEC-0005`는 GPcompany Slack을 사람과 Hermes 사이의 운영 인터페이스로 정하고 있다.
GP Workbench에는 실행 상태와 승인 항목을 보는 화면이 있으나, 대표가 자연어로 요청하고
Atlas의 압축 보고를 받아 정책·권한·실행을 한곳에서 결정하는 대표실 계약은 아직 없다.

미병합 커밋 `f048715`에는 `DEC-0015 무인 실행과 Decision Digest` 초안이 있으나 OS main의
권위 문서가 아니다. 그 초안의 안전한 무인 실행 원칙은 유지하되, 최대 10건의 Digest
목록을 대표에게 넘기는 방식은 사용하지 않는다. 대표가 보고를 찾는 대신 Atlas가 지금
봐야 할 것만 압축해야 한다.

## 결정

### 1. 대표실을 사람용 단일 공식 접수면으로 전환한다

1. GP Workbench 홈의 **대표실**을 대표의 회사 운영 요청·보고·결정·권한 관리 단일
   공식 접수면으로 전환한다.
2. 대표는 평소 말하듯 자연어 한 문장으로 요청한다. `Task-ID`, `OS-Ref`, 저장소, 작업자,
   상태 태그와 승인 문구를 직접 입력하지 않는다.
3. ChatGPT, Codex와 Slack은 조사·실행·알림 채널로 사용할 수 있지만 별도의 회사 업무
   원본을 만들지 않는다. 다른 채널에서 시작된 정식 요청도 하나의 대표실 작업에 연결한다.
4. 대표실 검증이 끝날 때까지 GPcompany Slack을 현행 접수면으로 유지한다. 전환 완료
   증거 없이 Slack을 먼저 중단하지 않는다.

### 2. Atlas는 보고 창구이고 Hermes가 작업 원본을 소유한다

1. **Atlas**는 `CEO Co-Operator`의 사람용 보고 역할이다. 대표의 요청을 이해하고,
   회사 기준과 현재 상태를 확인해 결론·선택지·권고안을 보고한다.
2. Hermes Primary는 하나의 `Task-ID`와 고정 `OS-Ref`를 가진 회사 작업 원본을 소유한다.
   Atlas, Orca, Claude Code, Codex가 각각 별도 원본을 만들지 않는다.
3. Orca는 Hermes가 정한 작업·권한·완료 조건 안에서 여러 Worker를 나누고 합치는 하위
   실행 조정자로만 사용한다.
4. 정책·Decision·SOP 원본은 Codex가, 개발·데이터·API·테스트·배포는 Claude Code가
   `DEC-0012`에 따라 분리 수행한다. 같은 branch를 공동 소유하지 않는다.

### 3. 대표는 보고 목록을 찾지 않는다

대표실 첫 화면은 대화 기록이나 작업 목록이 아니라 **현재 대표 브리핑**이다. Atlas는
새 보고가 생길 때 기존 요약을 갱신하고, 대표가 아래 세 구역만 보게 한다.

| 구역 | 보여주는 내용 | 기본 한도 |
|---|---|---|
| 지금 결정 | 대표 판단 없이는 진행할 수 없는 선택 | 최대 3건 |
| 오늘 알 것 | 매출·고객·운영에 의미 있는 변화와 위험 | 최대 3개 영역 요약 |
| 안전하게 진행 중 | 승인 범위 안에서 계속되는 업무 | 전체를 한 줄로 묶음 |

- 같은 원인·같은 결정으로 묶이는 보고는 하나로 합친다.
- 새 상태는 이전 요약을 갱신하며, 이전 대화와 상세 증거는 보관함에서만 펼쳐 본다.
- 대표가 직접 작업·보고 목록을 순회해야 현재 상태를 알 수 있으면 보고 실패로 본다.
- P0 안전사고·보안·고객 피해·비가역 변경은 한도를 넘어 즉시 별도 표시할 수 있다.
- 한도를 넘는 일반 항목은 숨기는 것이 아니라 Atlas가 우선순위와 공통 원인을 다시
  정리해 다음 브리핑으로 넘긴다.

각 결정 항목은 다음만 먼저 보여준다.

1. 결론
2. 왜 지금 대표가 봐야 하는지
3. 매출·고객·회사 운영 영향
4. 선택지와 Atlas 권고안
5. 응답하지 않을 때의 안전한 기본 동작
6. 다음 보고 조건

기술 로그, Worker 대화, commit과 원문 Evidence는 기본 화면에서 접고 필요할 때만 연다.

### 4. 한 요청은 하나의 살아 있는 업무가 된다

1. 새 자연어 요청은 기존 열린 업무와 목적·대상·완료 조건을 비교한다.
2. 같은 업무이면 새 목록을 만들지 않고 기존 업무의 목표나 조건에 추가한다.
3. 다른 업무이면 새 `Task-ID`를 만들고 대표에게 자연어로 접수 범위와 안전선을 보고한다.
4. 대화량이 아니라 현재 목표·결정·다음 행동·적용 결과가 업무의 상태가 된다.
5. 완료 보고 뒤 재개하면 기존 증거를 연결한 새 실행 구간으로 기록해 과거 결과를
   덮어쓰지 않는다.

### 5. 정책과 권한은 대표실에서 결정하되 OS main에서 효력이 생긴다

1. Atlas는 대표의 입력을 일반 업무, 운영 지시, 정책·권한 변경 후보로 분류한다.
2. 정책·권한 변경 후보는 관련 ACTIVE Decision, 영향받는 부서·화면·자동화와 위험을
   먼저 확인해 하나의 결정안으로 올린다.
3. 대표가 승인하면 Codex가 정확한 변경 revision을 준비하고 검증한다. 대표가 확인한
   동일 revision이 `gp-company-os` main에 merge되어야 ACTIVE 효력이 생긴다.
4. 대표실 버튼이나 대화 기록만으로 GPcompany OS 정책이 바뀐 것으로 간주하지 않는다.
5. 권한 부여는 ACTIVE OS 근거가 생긴 뒤 적용한다. 권한 회수는 피해 방지를 위한 즉시
   정지가 가능하지만, 같은 작업 안에서 OS 기록을 완료하기 전 재개하지 않는다.

### 6. 결정된 정책은 Brand·Factory에 직접 덮어쓰지 않는다

1. OS main의 새 commit을 기준으로 Hermes와 Hub가 영향받는 실행 저장소를 식별한다.
2. 각 실행 저장소에는 같은 `OS-Ref`를 가진 별도 적용 작업 또는 Draft PR을 만든다.
3. Brand·Factory·Agent·Automation은 자신의 원본과 검증 책임을 유지한다. OS가 다른
   저장소의 현재 구현 상태를 추정하거나 실행 코드를 직접 보관하지 않는다.
4. 대표실은 다음 상태를 분리해 보여준다.

```text
정책 결정 → 전달됨 → 구현됨 → 운영 적용됨 → 결과 확인됨
```

5. `운영 적용됨`과 `결과 확인됨`이 없으면 정책 전달이 끝났더라도 완료로 보고하지 않는다.
6. 실행 저장소에서 정책 충돌이나 적용 불가가 발견되면 OS를 조용히 해석 변경하지 않고
   대표실의 하나의 영향 보고로 되돌린다.

### 7. 대표가 응답하지 않아도 안전한 일은 계속한다

1. 기본 무인 실행 창은 `22:00-08:00 KST`로 한다. 대표가 응답할 수 없는 다른 시간에도
   같은 안전 규칙을 적용할 수 있다.
2. 읽기·분석·dry-run, `WB-LOW`, 이미 승인된 완료 조건 안의 테스트·검증과 독립된
   가역 작업은 추가 질문 없이 계속한다.
3. 가격·예산·외부 공개·신규 SKU·권한 확대·정책 충돌처럼 대표 결정이 필요한 항목은
   해당 단계만 멈추고 다른 독립 작업은 계속한다.
4. 결제·환불·정산·계정·권한 변경, 민감정보 위험, 예산 초과, rollback 실패와 비가역
   변경은 즉시 멈추고 부작용을 격리한다.
5. 대표 결정 대기는 현재 브리핑의 `지금 결정`으로 합쳐 올린다. 이전 초안처럼 최대
   10건의 질문 목록을 그대로 전달하지 않는다.
6. 작업자가 바뀌거나 사용량 한도에 도달해도 `Task-ID`, `OS-Ref`, 완료·미완료 단계,
   검증 결과, 부작용·복구 상태와 첫 다음 행동을 남겨 같은 업무를 안전하게 이어간다.

## 이유

대표의 시간을 줄이는 핵심은 보고를 많이 저장하는 것이 아니라, 회사 전체에서 지금
대표가 판단할 것만 한 화면으로 압축하는 것이다. 동시에 하나의 Task와 OS 기준을 유지하면
대화 도구와 작업자가 바뀌어도 중복·누락·권한 혼선을 막을 수 있다.

정책 결정과 실행 적용을 분리하면 OS가 개발 속도를 무조건 늦추는 문서가 되지 않는다.
승인 범위 안의 실행은 계속하고, 회사 방향·권한·예외만 OS에서 통제할 수 있다.

## 영향 범위

### 적용

- GP Workbench 홈·대표실·회사 현황·결정함·정책·권한·적용 현황
- Atlas/CEO Co-Operator의 보고 계약
- Hermes Primary 작업 큐와 대표 결정 대기
- Orca Worker 조정과 checkpoint
- GPcompany OS 변경의 Brand·Factory·Hub·Agent 전달 상태

### 비적용

- 이 Decision 자체는 가격·예산·외부 쓰기·결제·계정 권한을 새로 부여하지 않는다.
- Workbench가 GPcompany OS 원본 저장소를 대체하지 않는다.
- Atlas가 대표의 승인이나 확인되지 않은 회사 사실을 대신 만들지 않는다.
- OS가 Brand·Factory의 구현 상태표와 실행 데이터를 복사해 보관하지 않는다.
- 이 Decision 승인만으로 Workbench·Hub 구현, merge 또는 배포를 승인하지 않는다.

## 결과와 Trade-off

- 대표는 보고 목록을 순회하지 않고 현재 판단과 회사 영향만 볼 수 있다.
- Slack·ChatGPT·Codex에서 시작된 요청도 하나의 회사 업무로 추적할 수 있다.
- 정책 결정과 실제 적용·검증 사이의 미완료 구간이 드러난다.
- Atlas의 우선순위 판단과 요약 품질이 낮으면 중요한 내용을 놓칠 수 있으므로 원문 증거와
  P0 예외 경로를 유지해야 한다.
- 대표실 전환 전까지 Slack과 Workbench를 함께 운영하므로 일시적인 동기화 비용이 생긴다.

## 전환과 검증

1. 대표가 이 Decision의 접수면·브리핑 한도·정책 효력·전달 원칙을 승인한다.
2. Codex가 `DEC-0005`, `SOP-007`, `WF-003`, `AGENT-CEO-COOPERATOR`, `AGENT-HERMES`의
   전환안을 같은 OS revision에 반영한다.
3. Claude Code가 승인된 `OS-Ref`를 기준으로 Workbench 대표실과 Hub 동기화를 별도
   branch에서 구현한다.
4. 첫 Pilot은 `스마트스토어 매출 자동화 복구` 한 건으로 한다.
5. Pilot에서 자연어 접수, 중복 방지, 현재 브리핑, 대표 승인, 실제 적용 전 Gate,
   적용 결과와 다음 보고가 하나의 Task로 이어지는지 확인한다.
6. 대표가 작업 목록을 찾지 않고 첫 화면만으로 결정할 수 있는지 실제 사용으로 확인한다.
7. 전환 성공 뒤 `DEC-0005`의 사람용 주 인터페이스를 Slack에서 대표실로 바꾸고 Slack은
   알림·비상 대체 채널로 낮춘다.

성공 기준:

- 동일 요청의 중복 Task 0건
- 대표가 직접 목록을 순회해야 확인한 중요 결정 0건
- 정책 승인만 되고 실행 저장소 적용 상태가 사라진 건 0건
- 승인 범위 밖 외부 실행 0건
- checkpoint 없는 작업 유실 0건
- Pilot 종료 시 `정책 결정/전달/구현/적용/결과 확인` 상태가 각각 판별 가능

## 재검토 조건

- 첫 화면 한도가 실제 중요 결정을 숨기거나 대표 판단을 늦출 때
- Atlas와 Hermes가 같은 업무를 각각 Primary로 소유할 때
- Workbench·Slack·GitHub의 상태 불일치가 반복될 때
- 무인 실행에서 외부 오등록·예산 초과·민감정보 노출·중복 실행이 발생할 때
- 대표실이 정식 공개 서비스가 되거나 사용자·권한 구조가 변경될 때

## 관련 문서

- Direction: `../../LEVEL-1_DIRECTION/MANIFEST.md`, `../../LEVEL-1_DIRECTION/BLUEPRINT.md`
- Decision: `DEC-0005_HERMES-SLACK-ORCHESTRATION.md`,
  `DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`, `DEC-0009_REVENUE-FIRST.md`,
  `DEC-0011_ORGANIZATIONAL-LEARNING.md`, `DEC-0012_AI-WORK-ALLOCATION.md`,
  `DEC-0013_CHANNEL-LISTING-AUTOMATION.md`, `DEC-0014_TIERED-DIRECTION-BOOT.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`,
  `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-005_WORKBENCH-DIRECT-DEVELOPMENT.md`
- SOP: `../SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`,
  `../SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-CEO-COOPERATOR.md`,
  `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- KPI: `../../LEVEL-5_MANAGEMENT-CONTROL/DASHBOARD.md`

---

## 작업 메타데이터

```yaml
task_id: GP-20260812-CEO-OFFICE
os_ref: 60bcdb2ec8ee88287e3664bf0b1b31a287fa246d
direction_profile: D2
decision_refs: [DEC-0005, DEC-0007, DEC-0009, DEC-0011, DEC-0012, DEC-0013, DEC-0014]
approval_class: C
learning_level: L1
learning_preflight:
  applied:
    - 대표 자연어 입력과 기계 식별자 자동 생성
    - Hermes 단일 Primary와 Workbench 실행 기록 경계
    - Revenue First와 고위험 승인 Gate
  not_applied:
    - 미병합 f048715의 Commerce Control Rules 구현 상태
  no_applicable_knowledge: false
outcome: RESULT_PENDING
enforcement_point: OS-INDEX.yaml#ceo_office / gpcompany-lab 대표실 요구사항
```
