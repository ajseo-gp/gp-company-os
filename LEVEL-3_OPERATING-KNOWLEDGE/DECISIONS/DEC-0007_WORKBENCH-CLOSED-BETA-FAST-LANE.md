# DEC-0007 GP Workbench Closed Beta Fast Lane

- 상태: ACTIVE
- 결정일: 2026-07-22
- 결정자: GP Company CEO
- 적용 저장소: `ajseo-gp/gpcompany-lab`

## 배경

GP Workbench는 현재 소수 사용자가 실제 업무에서 빠르게 사용하고 피드백하는 Closed Beta다.
대표와 연구원이 구현 지시 형식, Task-ID, OS-Ref, branch와 release 명령을 직접 관리하면
제품 판매·연구 업무보다 개발 중계에 시간이 더 많이 든다.

대표는 Claude Code Max 요금제를 사용하고 있으며, Mac mini의 `gpwb_bot`과 로컬 Claude
Code가 Workbench 맥락을 가장 직접적으로 다룰 수 있다. 따라서 Workbench의 저위험 반복
개선은 Hermes의 일반 Preview 승인 경로와 분리한다.

## 결정

1. GP Workbench 개발의 단일 구현 주체는 `gpwb_bot`이 실행하는 로컬 Claude Code다.
2. 대표와 연구원은 지정 Workbench Slack 채널에서 자연어와 이미지로 요청한다. 사람에게
   `Task-ID`, `OS-Ref`, 상태 태그, branch명 또는 승인 문구 입력을 요구하지 않는다.
3. `gpwb_bot`은 요청 접수 시 Task-ID, 요청자 Slack ID, 작업 branch와 적용 OS-Ref를
   자동 생성·기록한다.
4. Closed Beta의 저위험 변경은 Claude Code가 구현·검증·자체 승인·merge·deploy·smoke
   test까지 완료한다. 별도 Hermes 승인이나 사전 Human Preview를 기다리지 않는다.
5. 저위험 배포 후에는 같은 요청 스레드에 변경된 영역만 담은 PC·모바일 이미지, 운영 URL,
   revision, 테스트와 rollback 상태를 보고한다. 사람은 자연어로 후속 수정을 요청한다.
6. 중위험·고위험 변경은 배포 전에 변경 영역의 Preview와 사람 승인을 받는다. 이때도
   `gpwb_bot`이 승인 의도를 구조화하며 사람에게 기계 형식을 요구하지 않는다.
7. Hermes는 Workbench Fast Lane을 지휘하거나 동일 작업을 중복 구현하지 않는다. 다만
   정책 예외, 보안 사고 또는 명시적 escalation을 전달받으면 Company OS에 따라 처리한다.
8. `DEC-0012`에 따라 Codex는 `gp-company-os`의 정책·문서 관리를 담당하고, Claude
   Code는 Workbench·Hub를 포함한 개발·데이터·API 구현을 담당한다. 두 도구는 명시적
   fallback 승인 없이 상대 작업 branch에 commit하지 않는다.
9. Workbench 자동 실행은 사용자 승인 로컬 Claude Code 세션을 우선한다. 별도 과금되는
   API 또는 GitHub Claude Action으로 조용히 전환하지 않는다.

## 위험 분류

| 등급 | 예시 | Release |
|---|---|---|
| `WB-LOW` | 문구·스타일·레이아웃·탐색·가역적 UI, 비파괴 버그 수정 | Claude 자체 승인 후 자동 배포, 사후 시각 보고 |
| `WB-MEDIUM` | additive schema·API, 업무 계산 로직, 외부 읽기 API, 기존 사용자 흐름의 의미 변경 | 테스트와 변경 영역 Preview 후 지정 사용자 승인 |
| `WB-HIGH` | 인증·권한·비밀정보·결제, 실제 고객·처방·원가 데이터 쓰기, migration·삭제, 인프라·배포 권한 변경 | CEO 명시 승인과 보안 검토 전 실행 금지 |

분류가 불명확하면 한 단계 높은 등급을 적용한다. 하나의 작업에 여러 등급이 섞이면 가장
높은 등급을 적용한다.

## 불변 조건

- Workbench 작업 저장소와 운영 경로를 Company OS 또는 Hub 작업 경로와 섞지 않는다.
- Claude·Codex·Hermes가 같은 작업 branch를 공동 소유하지 않는다.
- 비밀정보, 실제 고객정보, 처방, 원가 데이터는 Slack·Preview·스크린샷에 노출하지 않는다.
- 자동 배포 전 build와 변경 범위 테스트를 통과해야 한다.
- 배포 후 smoke test가 실패하면 새 기능을 계속 노출하지 않고 정의된 rollback 또는 안전
  차단을 실행한다.
- `WB-MEDIUM`과 `WB-HIGH`를 속도를 이유로 `WB-LOW`로 낮추지 않는다.

## 종료·재검토 조건

다음 중 하나가 발생하면 Closed Beta Fast Lane의 범위와 자체 승인 권한을 재검토한다.

- 외부 고객에게 Workbench를 정식 공개할 때
- 결제, 생산, 고객 개인정보 또는 규제 판단을 직접 처리할 때
- 사용자가 늘어 변경 실패의 영향 범위가 커질 때
- 반복되는 rollback, 보안 사고 또는 데이터 무결성 문제가 발생할 때

## 관련 문서

- `DEC-0005_HERMES-SLACK-ORCHESTRATION.md`
- `DEC-0006_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `DEC-0012_AI-WORK-ALLOCATION.md`
- `../SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-005_WORKBENCH-DIRECT-DEVELOPMENT.md`
