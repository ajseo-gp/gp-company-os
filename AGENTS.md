# Repository Instructions for AI Agents

이 지침은 저장소 전체에 적용된다.

## Required Boot

1. `SYSTEM_BOOT.md`를 먼저 읽는다.
2. `README.md`, `LEVEL-1_DIRECTION/DIRECTION-SNAPSHOT.md`와 `OS-INDEX.yaml`로 저장소 구조와
   작업 관련 문서를 찾는다.
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

## AI Work Allocation

- `DEC-0012`에 따라 Codex는 `gp-company-os`의 정책 수립, Decision·Context·SOP·Knowledge
  작성, 색인과 문서 정합성 검증을 담당한다.
- 개발, 데이터 처리·분석, API·DB·schema, 테스트, CI/CD, 인프라와 배포 구현은 Claude
  Code에 라우팅한다.
- Codex는 정책 근거 확인을 위한 기술 저장소 읽기·감사는 할 수 있지만, CEO의 건별
  fallback 승인 없이 Hub·Workbench·프로젝트 구현 branch를 수정하지 않는다.
- 정책과 구현이 섞인 요청은 Codex가 정책 경계를 먼저 고정하고 Claude Code가 별도
  저장소·branch에서 구현한다. 두 도구가 같은 branch를 공동 소유하지 않는다.
- `DEC-0013`에 따라 Claude Code는 스마트스토어·쿠팡 및 활성 쇼핑몰의 상품 등록, 가격,
  할인·프로모션을 자동 실행할 수 있다. Commerce Control Rules와 표현·SKU·예산·rollback·
  실행 기록 Gate를 통과하지 못하면 외부 쓰기를 실행하지 않는다.
- `DEC-0015`에 따라 비차단 정책 질문은 대표에게 즉시 중계시키지 않고 Codex 작업 또는
  `DECISION_QUEUE`로 직접 라우팅한다. 무인 실행은 checkpoint로 이어가며 비용 상한 없는
  별도 과금 API로 사용량 한도를 자동 우회하지 않는다.
- Claude Code가 정책 변경을 요청할 때 대표에게 파일·SHA·도구 선택을 전달시키지 않는다.
  Hermes·Orca·공유 작업 artifact 중 현재 활성 경로로 Codex에 직접 인계하고, 새
  `OS-Ref`를 받으면 Claude Code가 구현을 재개한다.

## Direction Reading Profiles

- 모든 작업은 `DEC-0014`에 따라 `D0`·`D1`·`D2`로 분류하고 Direction Snapshot을 읽는다.
- `D0` 단순 기술 변경은 Snapshot만, `D1` 매출·고객·기능 변경은 Snapshot과 `DEC-0009`,
  `D2` 가격·프로모션·외부 쓰기·신규 사업·권한·정책은 Mission·Vision 원문까지 읽는다.
- 같은 세션·같은 OS-Ref에서 이미 검증한 방향 문서는 다시 읽지 않고 checkpoint를 재사용한다.

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
