# Workflow

Workflow는 여러 SOP, Agent, Automation을 업무 결과까지 연결한다.

## Workflow Contract

각 Workflow는 다음을 정의한다.

- ID, 상태, 소유자와 적용 사업
- Trigger와 종료 조건
- 상태와 허용 전이
- 역할·Agent·시스템별 책임과 인계
- 단계별 관련 SOP
- 자동화되는 단계와 수동 단계
- 승인·예외·재시도·취소 흐름
- 생성되는 기록과 Knowledge 환류
- KPI와 관련 Decision

Workflow에는 상세 작업법을 복사하지 않는다. 상세 단계는 SOP를 참조하며, Automation은
Workflow의 특정 상태 전이와 SOP 단계를 구현한다.

## Workflow Register

| ID | Workflow | 상태 | 주요 SOP | Agent/실행 주체 |
|---|---|---|---|---|
| WF-001 | Inquiry to Order | ACTIVE | SOP-001, 002, 010 | OEM Intake, R&D, Production |
| WF-002 | Content Engine | ACTIVE | SOP-005 | Content, Marketing |
| WF-003 | Slack to Hermes | ACTIVE | SOP-007 | Hermes |
| WF-004 | Preview to Automatic Release | ACTIVE | SOP-008 | Hermes, Automation |
| WF-005 | Workbench Direct Development | ACTIVE | SOP-009 | gpwb_bot, Claude Code |
| WF-006 | Revenue Growth Loop | ACTIVE | SOP-005, 011 | Marketing Growth Team |
| WF-007 | Targeted Knowledge Refresh | ACTIVE | SOP-012 | Knowledge Steward, Hermes |
| WF-008 | Organizational Learning Loop | ACTIVE | SOP-013 | Knowledge Steward, Hermes, Domain Agents |
| WF-009 | GPcompany OS 정책 전달과 적용 확인 | ACTIVE | SOP-016 | 대표, Atlas, Codex, Hermes, Claude Code |

`ACTIVE` 표시는 Workflow 기준이 승인되었다는 뜻이며, 연결 Automation이 실제 구현되었다는
뜻은 아니다. 실행 가능 여부는 Automation의 별도 상태를 확인한다.
