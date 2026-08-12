# SOP-016 Company OS 정책 운영

- 상태: PROPOSED
- 버전: 0.1
- 소유자: GP Company CEO / Codex Policy Owner
- 적용 Decision: DEC-0017
- 적용 범위: Company OS 정책·권한·Decision·Context·SOP의 제안, 승인, 적용과 재검토
- 기준일: 2026-08-12
- 다음 검토일: 첫 대표실 Pilot 종료 후

## 목적

대표가 자연어로 회사 정책과 권한을 제안·결정하고, Company OS 정본 반영부터
Brand·Factory·Hub·Agent 적용 결과까지 한 흐름으로 통제하도록 한다.

Company OS에 장기 기준과 실행 화면의 세부사항이 뒤섞여 개발이 불필요하게 느려지거나,
반대로 정책과 권한을 확인하지 않고 실행이 앞서는 일을 막는다.

## 적용 범위

- 회사 방향, 사업 우선순위, 권한, 승인 Gate와 예외
- 새로운 Agent·Automation·Workflow의 역할과 실행 범위
- 반복 업무 절차와 검증 기준
- 현재 회사 상태·제약·우선순위의 변경
- OS 변경이 Hub, Workbench, Brand, Factory와 프로젝트 저장소에 미치는 영향

다음은 이 SOP로 OS에 직접 저장하지 않는다.

- 화면의 픽셀·색상·컴포넌트·일시적인 탭 구현 상태
- 개별 작업의 기술 설계, 코드, API·DB schema와 테스트 구현
- 고객·처방·원가·계약·credential 원문
- 실행 로그, 채널 원본 데이터와 저장소별 현재 구현 상태표

단, 오판·권한 위반을 막는 전사 불변 조건은 UI에서 시작됐더라도 Decision이나 SOP로
승격할 수 있다.

## 역할과 책임

| 역할 | 책임 | 하지 않는 일 |
|---|---|---|
| 대표 | 목표·정책·권한·예외의 최종 결정 | 문서 형식·ID·commit 직접 관리 |
| Atlas / CEO Co-Operator | 자연어 접수, 분류, 영향 확인, 결정안·압축 보고 | 승인 사실 생성, 실행 큐 중복 소유 |
| Codex | OS 문서 초안, 충돌·링크·색인 검증, 정확한 revision 준비 | Workbench·Hub 구현 branch 수정 |
| Hermes Primary | 활성 OS-Ref 고정, 적용 작업 생성·라우팅, 상태 연결 | 정책 내용 임의 해석·변경 |
| Orca | 고정된 Task·권한 안의 Worker 분배·회수 | 별도 Company 작업 원본 생성 |
| Claude Code | Hub·Workbench·프로젝트 구현, 테스트, Preview·Release | ACTIVE OS 정책 원본 변경 |
| 실행 Owner | 자신의 저장소 적용 검수와 운영 결과 확인 | 미검증 적용을 완료로 보고 |

## 대표 입력

대표에게 요구하는 입력은 자연어 요청과 필요한 경우 다음 세 가지뿐이다.

- 원하는 결과
- 꼭 지켜야 할 제한
- 중요한 시점

내용이 부족해도 먼저 현재 기준과 안전한 조사 범위를 확인한다. 선택에 따라 회사 방향이나
권한이 달라질 때만 짧은 결정 질문을 올린다. 대표에게 문서 종류, ID, OS-Ref, 저장소,
branch와 승인등급을 선택하게 하지 않는다.

Atlas와 Hermes는 `TEMPLATES/COMPANY-OS-CHANGE-ENVELOPE.md`를 내부적으로 생성한다.

## 문서 분류 기준

요청을 먼저 아래처럼 분류한다. 여러 유형이 섞이면 정책 경계를 먼저 확정하고 구현을
별도 작업으로 분리한다.

| 대표의 의도 | OS 기록 | 실행 저장소 기록 |
|---|---|---|
| 회사가 무엇을 선택하고 왜 지키는가 | Decision | 적용 PR·실행 증거 |
| 지금 회사의 상태·제약·우선순위는 무엇인가 | Context | 원본 데이터 참조 |
| 한 반복 업무를 어떻게 수행하는가 | SOP | 실행 로그 |
| 여러 역할·시스템이 어떤 상태로 인계하는가 | Workflow | 큐·상태 기록 |
| Agent가 무엇을 읽고 어디까지 할 수 있는가 | Agent | Runtime 설정 |
| 어떤 Trigger로 기계 실행하는가 | Automation | 실행 코드·로그 |
| 어떤 사실·교훈이 검증됐는가 | Knowledge | 원본 Evidence |
| 화면·기능을 어떻게 구현하는가 | OS에 저장하지 않음 | 요건·코드·테스트 |

다음 질문이 모두 `아니오`이면 일반적으로 OS 변경이 아니다.

1. 회사 방향·사업 우선순위가 달라지는가?
2. 사람·Agent의 권한이나 승인 지점이 달라지는가?
3. 반복 업무의 표준·금지·완료 기준이 달라지는가?
4. 여러 저장소·부서가 따라야 할 공통 불변 조건인가?
5. 기존 ACTIVE Decision의 의미나 예외가 달라지는가?

## 표준 상태

정책의 상태와 실행 적용 상태를 한 값으로 합치지 않는다.

### 정책 상태

```text
REQUESTED → CLASSIFIED → IMPACT_REVIEW → DRAFT_READY
→ CEO_APPROVED | REVISION_REQUESTED | REJECTED
→ ACTIVE | REVIEW | ARCHIVED
```

`CEO_APPROVED`는 대표 의사 확인 상태이고, `ACTIVE`는 승인된 동일 revision이 OS main에
merge된 상태다. 둘 사이가 다르면 실행 근거로 사용하지 않는다.

### 적용 상태

```text
NOT_REQUIRED | DELIVERY_PENDING → DELIVERED → IMPLEMENTED → APPLIED → VERIFIED
```

- `DELIVERED`: 영향받는 저장소에 고정 OS-Ref의 적용 작업이 생성됨
- `IMPLEMENTED`: 코드·문서·설정 변경과 검증이 완료됨
- `APPLIED`: 승인된 변경이 실제 운영 경로에 반영됨
- `VERIFIED`: 기대한 행동·결과와 부작용을 Evidence로 확인함

정책이 `ACTIVE`여도 적용 상태가 `VERIFIED`가 아니면 전체 업무를 완료로 닫지 않는다.

## 실행 단계

### 1. 자연어 접수와 중복 확인

1. 대표 입력을 기존 열린 정책 작업과 비교한다.
2. 같은 목적·영향이면 기존 Task에 추가하고 새 정책 작업을 만들지 않는다.
3. 다른 목적이면 Task-ID를 발급하고 현재 활성 40자리 OS-Ref를 고정한다.
4. Atlas가 자연어로 `접수한 범위 / 지금 할 일 / 대표 결정 시점 / 안전선`을 보고한다.

### 2. 정책 여부 분류

1. 문서 분류 기준으로 OS 변경 여부를 판정한다.
2. 구현 세부사항만 있으면 OS 변경 없이 Claude Code 실행 작업으로 보낸다.
3. 정책과 구현이 섞이면 Codex 정책 작업과 Claude Code 구현 작업으로 분리한다.
4. 수집원·Evidence가 없는 사실을 정책 근거로 확정하지 않는다.

### 3. 기존 기준과 영향 확인

1. 정확한 OS-Ref에서 관련 ACTIVE Decision → Context → SOP → Knowledge 순으로 확인한다.
2. 바뀌는 권한, 승인 Gate, 예외, 부서, 저장소, 화면과 자동화를 표시한다.
3. Revenue First, 고객·규제·보안·비가역 변경과 대표 병목 영향을 확인한다.
4. 다른 저장소의 상태는 정확한 revision이나 그 저장소의 권위 문서를 확인하지 못하면
   `미확인`으로 둔다.
5. 기존 ACTIVE 기준과 충돌하면 어느 문서를 대체·수정할지 결정안에 명시한다.

### 4. 대표 결정안 작성

Atlas는 `TEMPLATES/CEO-BRIEFING-TEMPLATE.md`에 따라 다음을 한 항목으로 압축한다.

- 결론과 지금 결정해야 하는 이유
- 확인된 배경과 미확인 사항
- 선택지, Atlas 권고안과 Trade-off
- 권한·매출·고객·운영 영향
- 응답하지 않을 때의 안전한 기본 동작
- 영향받는 문서·저장소와 다음 보고 조건

기술 로그와 문서 원문은 상세 보기로 접는다.

### 5. 초안과 정확한 revision 검증

1. Codex가 Decision·Context·SOP 등 필요한 문서만 최소 범위로 작성한다.
2. ID 중복, 링크, 색인, 상태, 원본 경계와 저장소 검사를 수행한다.
3. 대표가 검토할 revision을 고정하고 이후 수정되면 기존 승인을 재사용하지 않는다.
4. 제안 상태 문서는 ACTIVE 권한처럼 하위 실행에 배포하지 않는다.

### 6. 대표 승인·수정·거절

대표는 자연어 또는 대표실의 다음 의도로 답한다.

- 승인
- 수정 요청
- 보류
- 거절

Atlas가 의도를 구조화하되 범위를 추정해 넓히지 않는다. 조건부 승인은 조건을 문서와
완료 기준에 반영한 새 revision으로 다시 확인한다.

### 7. OS main 반영과 효력 발생

1. 승인된 동일 revision을 Company OS 변경 절차로 main에 반영한다.
2. merge된 정확한 40자리 commit SHA를 새 OS-Ref로 기록한다.
3. `ACTIVE` 상태와 적용일이 없는 제안은 권한 근거로 사용하지 않는다.
4. 대표실은 기술 식별자보다 `정책이 효력을 얻음`을 먼저 보고하고 SHA는 상세에 둔다.

### 8. 권한 부여와 회수

- **부여:** ACTIVE OS 근거와 적용 대상·범위·기한·승인·금지·회수 조건을 확인한 뒤
  Runtime에 적용한다. 문서 승인만으로 실제 권한이 부여됐다고 보고하지 않는다.
- **회수:** 고객·보안·비용 피해 방지를 위한 Runtime 즉시 정지가 가능하다. 정지 시각과
  영향 범위를 기록하고 같은 Task에서 OS 변경을 완료한다. OS 기록 전에는 재개하지 않는다.
- **임시 권한:** 종료 시점 또는 종료 조건과 자동 회수·확인 Owner가 없으면 부여하지 않는다.

### 9. Brand·Factory·Hub·Agent 전달

1. Hermes와 Hub가 새 OS-Ref의 변경 경로와 색인으로 영향 대상을 판정한다.
2. 대상별로 하나의 적용 작업 또는 Draft PR을 만들고 같은 OS-Ref를 연결한다.
3. 실행 저장소는 자체 원본·위험등급·Preview·테스트·Release 규칙을 따른다.
4. OS 문서를 실행 저장소에 복사해 별도 정책 원본을 만들지 않는다.
5. 적용 불가·충돌·추가 비용은 대상별 여러 질문이 아니라 Atlas의 하나의 영향 보고로
   대표에게 돌아온다.

### 10. 적용과 결과 확인

1. 실행 Owner가 `DELIVERED → IMPLEMENTED → APPLIED → VERIFIED` 증거를 연결한다.
2. UI 문구나 설정 존재만으로 운영 적용을 확정하지 않는다.
3. 실제 사용자 흐름, 권한 동작, 실행 로그 또는 정해진 KPI로 결과를 확인한다.
4. 결과가 나중에 발생하면 `RESULT_PENDING` Owner·측정일·원천을 남긴다.
5. 예상과 다른 결과는 Context·Knowledge·SOP·Decision 재검토 후보로 되돌린다.

### 11. 대표 보고와 종료

대표실 첫 화면에는 다음만 올린다.

- 지금 결정할 정책·권한 최대 3건
- 오늘 알 필요가 있는 적용 실패·부작용·지연의 영역별 요약
- 안전하게 진행 중인 적용 작업 전체 한 줄

모든 대상이 `NOT_REQUIRED` 또는 `VERIFIED`이고, 미해결 권한·충돌·측정이 없을 때 종료한다.

## 승인 필요 지점

- Mission·Vision·사업 우선순위 변경
- ACTIVE Decision·SOP·Agent·Workflow·Automation의 의미 변경
- 권한 부여·확대, 승인 Gate 완화와 예외 생성
- 가격·예산·계약·법률·규정·생산·외부 공개 기준 변경
- 민감정보 접근과 비가역 변경
- Workbench를 현행 Slack 대신 공식 대표 접수면으로 전환

승인된 규칙 안의 가역적 구현, 조사, dry-run, 테스트와 문서 정합성 보정은 해당 위험등급과
완료 조건 안에서 계속할 수 있다.

## 출력물

- 내부 Company OS Change Envelope
- 분류 결과와 변경·비변경 근거
- 영향 분석과 대표 결정안
- 검증된 OS 변경 revision과 merge된 OS-Ref
- 영향 대상별 적용 Task 또는 Draft PR
- `정책 상태`와 `적용 상태`의 분리 기록
- 적용·결과 Evidence 또는 `RESULT_PENDING`
- 재검토 조건과 다음 대표 보고

## 실패·예외 처리

| 조건 | 처리 |
|---|---|
| 기준 commit이 OS main 조상이 아님 | `BLOCKED_GHOST_REF`, 권한 적용 금지 |
| 대표 승인 revision과 merge revision이 다름 | 승인 무효, 새 revision 재검토 |
| 정책인지 구현인지 분류 불명확 | 읽기·분석만 진행하고 권한 확대 금지 |
| ACTIVE Decision 충돌 | 충돌 문서와 선택지를 대표에게 한 항목으로 보고 |
| 영향 저장소 상태 미확인 | 추정하지 않고 `DELIVERY_PENDING` 또는 `미확인` |
| 일부 대상만 적용됨 | 전체 완료 금지, 대상별 상태와 안전 영향 표시 |
| Runtime 권한 회수 실패 | 관련 실행 중지·격리, P0 보고 |
| Evidence 없이 완료 주장 | `VERIFICATION_BLOCKED` |
| 대표실·Slack 중복 Task | 하나의 기존 Task로 병합, 부작용 확인 |

## Repository Boundary

- `gp-company-os`: 정책, 권한, Decision, Context, SOP와 적용 계약
- `gp-company-hub`: Hermes·Orca·Agent 라우팅과 OS 변경 전달
- `gpcompany-lab`: 대표실·Brand·Factory 화면, 실행 상태와 적용 Evidence
- 프로젝트·채널 원본: 코드, 설정, 외부 실행과 결과 데이터

OS는 다른 저장소의 구현 상태를 복사하거나 추정하지 않는다. 실행 저장소는 OS 정책을
자체 문서로 바꿔 쓰지 않고 정확한 OS-Ref를 적용 근거로 연결한다.

## 관련 문서

- `../DECISIONS/DEC-0017_CEO-OFFICE-AND-UNATTENDED-EXECUTION.md`
- `../DECISIONS/DEC-0002_DOCUMENT-PRIORITY.md`
- `../DECISIONS/DEC-0005_HERMES-SLACK-ORCHESTRATION.md`
- `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- `../DECISIONS/DEC-0012_AI-WORK-ALLOCATION.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-009_COMPANY-OS-POLICY-PROPAGATION.md`
- `SOP-004_DECISION-RECORD.md`
- `SOP-007_HERMES-SLACK-ORCHESTRATION.md`
- `SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- `../../TEMPLATES/COMPANY-OS-CHANGE-ENVELOPE.md`
- `../../TEMPLATES/CEO-BRIEFING-TEMPLATE.md`
