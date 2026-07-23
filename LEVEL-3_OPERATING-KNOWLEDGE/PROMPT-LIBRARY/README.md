# Prompt Library

검증된 반복 프롬프트를 저장한다. Prompt는 반드시 Context, Decision, Knowledge, SOP를 우선 참조하도록 작성한다.

Prompt는 정책, 회사 사실 또는 Agent 권한의 원본이 아니다. 관련 ACTIVE SOP와 Knowledge의
범위 안에서만 실행을 구체화한다.

## Prompt Header

- 목적
- 입력
- 참조 문서
- 금지사항
- 출력 형식
- 승인 필요 여부
- 버전과 평가 기준
- 실패 시 처리

Prompt 변경으로 결과의 승인 범위나 회사 정책이 달라지면 먼저 Decision·SOP·Agent를
수정한다. Prompt 성능은 실제 업무 결과와 오류율로 평가한다.
