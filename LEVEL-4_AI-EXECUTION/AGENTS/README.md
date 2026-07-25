# Agents

Agent는 역할, 입력, 출력, 참조문서, 권한, 승인 지점과 다른 Agent와의 인계를 가진다.

`문서 상태`는 역할 계약의 승인 수준이고, `Runtime 상태`는 실제 구현·운영 여부다. 명세가
ACTIVE여도 Runtime이 `PLANNED`이면 실행 가능한 Agent로 취급하지 않는다.

## Required Fields

- Mission과 책임 범위
- 입력과 출력 계약
- 필수 Decision·Context·Workflow·SOP·Knowledge
- 허용 권한과 금지 범위
- Human 승인 지점
- 다른 Agent·사람·시스템과의 인계
- 실패·예외·감사 기록
- 사전 Knowledge 소비·Outcome·Enforcement Point와 Reuse Verification
- 성공 지표

모든 Agent는 최소 하나의 SOP를 참조한다. 참조할 ACTIVE SOP가 없으면 Agent Runtime을
`ACTIVE`로 전환하지 않는다.

전체 구조, 현재 Runtime 상태와 향후 역할은
[`AGENT-ARCHITECTURE.md`](./AGENT-ARCHITECTURE.md)를 따른다. 신규 명세는
[`../../TEMPLATES/AGENT-TEMPLATE.md`](../../TEMPLATES/AGENT-TEMPLATE.md)를 사용한다.
