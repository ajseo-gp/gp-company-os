# DEC-0012 Codex–Claude Code 역할 분리

- 상태: ACTIVE
- 결정일: 2026-07-28
- 적용일: 2026-07-28
- 결정자/소유자: GP Company CEO
- 적용 범위: 전사 AI 작업 라우팅과 저장소 변경
- 대체하는 Decision: `DEC-0007` 결정 8항의 Codex Hub 구현 책임
- 대체된 Decision: 없음

## 배경

대표가 Codex와 Claude Code 사이에서 개발 내용을 전달·조정하면 대표가 실행 병목이 되고,
같은 파일·branch의 중복 변경, 우선순위 상실과 AI 사용 크레딧 낭비가 발생한다. 정책과
구현의 소유권을 분리해 대표는 결과와 예외만 결정할 수 있어야 한다.

## 결정

1. **Codex는 Company OS의 정책 수립과 문서 관리를 전담한다.**
   - Decision·Context·SOP·Knowledge·Workflow·Agent 계약과 색인 작성·정합성 검증
   - 정책 충돌, 승인 필요사항, 역할·권한·근거의 감사와 대표 결정안 작성
   - 기술 저장소는 정책 근거 확인을 위한 읽기 전용 감사만 수행
2. **Claude Code는 기술 구현을 전담한다.**
   - 애플리케이션·Hub·Workbench·Automation 코드, UI·백엔드와 테스트
   - 데이터 수집·정제·분석·파이프라인, 데이터베이스·schema·migration
   - API 연동, 인증 구현, CI/CD, 인프라, 배포, smoke test와 rollback
3. Codex는 대표의 건별 명시적 fallback 승인 없이는 `gp-company-hub`,
   `gpcompany-lab` 또는 프로젝트 저장소의 구현 branch를 만들거나 수정하지 않는다.
4. Claude Code는 Company OS의 ACTIVE 정책을 임의로 만들거나 변경하지 않는다. 구현 중
   정책 변경이 필요하면 근거·영향·선택지를 Codex 작업으로 반환하고 승인된 새 OS-Ref를
   받은 뒤 구현을 재개한다.
5. 정책과 구현이 섞인 요청은 하나의 공동 branch에서 처리하지 않는다.
   - 먼저 Codex가 정책·완료 조건·승인 경계를 고정한다.
   - 다음으로 Claude Code가 고정 OS-Ref를 받아 별도 기술 저장소에서 구현한다.
6. Hermes와 `gpwb_bot`은 자연어 요청을 내부에서 분류하고 사람에게 도구 선택이나
   Task-ID·branch·SHA 전달을 요구하지 않는다.
7. 같은 Task-ID·파일·branch를 Codex와 Claude Code가 동시에 소유하지 않는다.
8. 이 분리는 비용 절감만을 위한 것이 아니다. 정책 판단과 구현 책임을 분리해 재작업,
   충돌, 승인 오인과 대표의 중계 업무를 줄이는 운영 통제다.

## 이유

Codex의 사용 범위를 고가치 정책·문서 판단으로 제한하면 크레딧을 보존하면서 Company
OS의 일관성을 유지할 수 있다. 개발·데이터·API 맥락은 Claude Code에 집중시켜 구현
연속성과 기술 검증 책임을 한 곳에 둔다.

## 영향 범위

### 적용

- `gp-company-os` 정책·문서 변경
- `gp-company-hub`, `gpcompany-lab`과 프로젝트 저장소의 기술 작업
- Hermes·Slack·Workbench의 작업 라우팅
- 개발, 데이터, API, CI/CD, 배포와 Runtime 운영

### 비적용

- 이 Decision은 Claude Code에 외부 게시, 결제, 계약, 고객·운영 데이터 쓰기 또는
  고위험 배포의 신규 권한을 부여하지 않는다.
- CEO, Hermes, Domain Agent와 Operator의 기존 사업 의사결정·승인 책임을 대체하지 않는다.
- Codex의 정책 근거 확인을 위한 읽기 전용 코드·Evidence 검토를 금지하지 않는다.

## 결과와 Trade-off

- 대표가 두 AI 사이에서 구현 내용을 전달하는 빈도와 Codex 크레딧 사용이 줄어든다.
- 정책이 필요한 구현은 OS 확정 후 시작하므로 초기 인계가 한 단계 추가될 수 있다.
- 긴급 fallback은 자동 전환하지 않고 대표의 건별 승인과 범위를 기록해야 한다.

## 전환과 검증

1. `AGENTS.md`, `README.md`, `OS-INDEX.yaml`과 Hermes 라우팅 계약에 역할 경계를 반영한다.
2. 진행 중인 Codex 기술 PR은 새 구현을 추가하지 않고 Claude Code에 인계하거나 종료한다.
3. 다음 4주간 잘못된 라우팅, 공동 branch 충돌, 대표의 수동 중계와 Codex의 기술 구현
   건수를 주간 Review에서 확인한다.
4. 성공 기준은 Codex의 무승인 기술 구현 0건, 동일 branch 공동 소유 0건, 개발·데이터·API
   작업의 Claude Code 라우팅 누락 0건이다.

## 재검토 조건

- Claude Code의 이용 가능성, 비용 구조 또는 기술 역량이 크게 바뀔 때
- 정책 문서와 기술 구현의 분리로 반복적인 전달 손실이 발생할 때
- 새로운 전사 구현 도구를 Primary로 지정할 때
- 보안 사고, 데이터 무결성 문제 또는 반복 rollback이 발생할 때

## 관련 문서

- Business: `LEVEL-2_BUSINESS/AI-COMPANY-OS-BUSINESS.md`
- Context: `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/CURRENT-PRIORITIES.md`
- Decision: `DEC-0005_HERMES-SLACK-ORCHESTRATION.md`, `DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- Workflow: `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`, `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-005_WORKBENCH-DIRECT-DEVELOPMENT.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`, `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- Agent: `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- KPI: `LEVEL-5_MANAGEMENT-CONTROL/KPI.md`
