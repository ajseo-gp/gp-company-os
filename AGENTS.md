# Repository Instructions for AI Agents

이 지침은 저장소 전체에 적용된다.

## Required Boot

1. `SYSTEM_BOOT.md`를 먼저 읽는다.
2. `README.md`와 `OS-INDEX.yaml`로 저장소 구조와 작업 관련 문서를 찾는다.
3. 변경 전 관련 ACTIVE Decision → Context → SOP 순으로 충돌을 확인한다.
4. 작업 결과에 참조 문서, 확인되지 않은 항목과 승인 필요사항을 남긴다.

## Repository Rules

- 이 저장소는 회사 운영 정책의 원본이며 실제 고객·처방·원가 데이터 저장소가 아니다.
- 현재 실행 우선순위는 `DEC-0009 Revenue First`다. 신규 설계는 고객 확보·판매·재구매,
  대표의 마케팅 병목 또는 반복 가능한 성장에 대한 기여 경로를 표시한다.
- 회사 사실을 추측하지 않는다. 근거가 없으면 `미확인` 또는 `REVIEW`로 표시한다.
- 정책 변경은 Decision, 현재 상태 변경은 Context, 반복 절차 변경은 SOP에 먼저 반영한다.
- Workflow는 역할·시스템 간 상태 흐름, SOP는 한 반복 업무의 수행법으로 유지한다.
- Agent는 역할·입력·출력·참조·권한·승인·관계를 정의하고 최소 하나의 SOP를 참조한다.
- Automation은 ACTIVE Workflow와 SOP를 참조하고 Trigger·입출력·승인·실패·로그를 정의한다.
- Prompt는 정책이나 권한을 새로 만들 수 없다.
- Marketing Agent 세분화는 Journey·KPI·Workflow·SOP·인계가 있을 때 허용한다.
- 공개 저장소에 고객 PII, 이메일 원문, 처방·함량, 원가·단가, 계약 비밀과 credential을
  기록하지 않는다.

## Change Discipline

- 기존 사용자 변경과 unrelated 파일을 보존한다.
- 문서를 이동·삭제하기 전에 모든 참조와 하위 저장소 영향 범위를 확인한다.
- 새 문서에는 상태, 소유자, 버전 또는 작성일, 적용 범위와 관련 문서를 표시한다.
- ACTIVE 기준을 바꾸는 변경은 CEO 승인 여부를 명시한다.
- 링크, ID 중복, 레지스트리와 `OS-INDEX.yaml` 정합성을 검증한다.

## Runtime Boundary

`gp-company-os`는 정책과 실행 계약을 정의한다. Hermes 오케스트레이션 구현은
`gp-company-hub`, Workbench 코드와 운영 기록은 `gpcompany-lab` 및 권한이 분리된
운영 저장소가 원본이다. 다른 저장소의 상태를 이 저장소에서 추정하지 않는다.
