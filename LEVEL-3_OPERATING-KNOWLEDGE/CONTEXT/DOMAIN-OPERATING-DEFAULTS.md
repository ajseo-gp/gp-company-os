# Domain 운영 기본 담당

- 상태: ACTIVE
- 소유자: GP Company CEO
- 기준일: 2026-07-29
- 다음 검토일: 2026-08-29
- 적용 범위: Organizational Learning의 실행 Owner·Reviewer·측정 기본값
- 원본 근거: DEC-0011, DEC-0015

## B2C 기본값

| 항목 | 기본값 |
|---|---|
| 실행 Owner | Marketing Owner / GP Company CEO |
| 기술 구현 Owner | Claude Code |
| 수동 Knowledge Reviewer | GP Company CEO |
| 검토 준비 대리 | CEO Co-Operator |
| 측정 주기 | Weekly Revenue Cycle |
| 결과 원본 | GP Workbench와 승인된 채널·커머스 원천 |
| 대표 보고 | 주간 Review, 예외는 Decision Digest |

Task는 이 기본값을 상속한다. 실행 Owner, Reviewer 또는 측정 주기가 예외인 경우에만
Task에 override를 기록한다.

검토 준비 대리는 Evidence 완결성, 중복, 적용 범위와 선택지를 준비할 수 있지만 대표의
가격·예산·정책·외부 쓰기 승인을 대체하지 않는다. 대리가 응답하지 못해도 승인된 Campaign
실행 자체를 막지 않으며, 해당 Learning Record의 `PRACTICE` 승격만 수동 Review 전까지
보류한다.

## 미확인·추가 지정 필요

- B2B/OEM, R&D, Production과 AI/OS Domain의 기본 담당
- CEO 부재 시 가격·예산·정책 결정을 대행할 사람

## 관련 문서

- Decision: `../DECISIONS/DEC-0011_ORGANIZATIONAL-LEARNING.md`,
  `../DECISIONS/DEC-0015_UNATTENDED-EXECUTION-DECISION-DIGEST.md`
- Business: `../../LEVEL-2_BUSINESS/B2C.md`, `../../LEVEL-2_BUSINESS/MARKETING.md`
- Agent: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-CEO-COOPERATOR.md`
