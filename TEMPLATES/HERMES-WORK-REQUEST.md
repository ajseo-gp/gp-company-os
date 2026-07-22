# Hermes 내부 작업 Envelope

- 상태: ACTIVE
- 버전: 2.0
- 소유자: GP Company CEO
- 변경일: 2026-07-22

사람은 Slack에 자연어로 요청한다. 이 양식은 Hermes가 요청을 접수한 뒤 자동으로 생성하는
내부 실행 계약이며, 대표나 직원에게 복사·작성하도록 요구하지 않는다.

## 사람이 보내는 예시

```text
지난주 젠틀파파 자사몰 매출이 왜 떨어졌는지 확인하고 이번 주 실행안을 만들어줘.
고객 발송이나 할인율 변경 전에는 나에게 알려줘.
```

## Hermes 생성 Envelope

```text
[WORK_REQUEST] <GP-YYYYMMDD-NNN> · <업무영역> · 승인등급 <등급>

요청자
<Slack user ID · channel · thread>

목적
<자연어 요청에서 추출한 결과와 완료 조건>

OS-Ref
ajseo-gp/gp-company-os@<활성 40자리-commit-SHA>

입력·참조
• <원문·첨부·입력 위치 또는 참조 ID>

실행 범위
• <허용된 조회·분석·변경>

필수 점검·산출물
• <점검 항목 또는 산출물>

개발·변경 작업
• 대상 저장소와 target branch: <repo> / <branch>
• Preview 방식: <비공개 URL, branch preview 또는 검증 artifact>
• 자동 배포 환경: <staging 또는 production 환경>
• smoke test와 rollback: <검증·복구 기준>

안전 제약
• <금지된 변경·외부 전송·데이터 범위>
• 비밀정보와 개인정보는 출력하지 않음
• 확인 불가능한 항목은 추정하지 않고 확인 불가로 표시

결과 계약
• 종합 상태: PASS | WARN | BLOCKED | COMPLETED
• 사용한 OS-Ref와 관련 문서 경로
• 수행 범위와 항목별 증거
• 발견된 위험·예외와 부분 실패
• 실제 변경 사항
• 대표 승인 또는 후속 작업이 필요한 항목
```

## 생성 확인

- [ ] 새 Task-ID를 발급했거나 기존 열린 작업에 연결했다.
- [ ] 운영 설정의 활성 OS-Ref가 정확한 저장소명과 40자리 commit SHA를 포함한다.
- [ ] 자연어 요청에서 목적과 완료 조건을 검증 가능하게 정리했다.
- [ ] 승인등급과 위험을 현재 권한표로 분류했다.
- [ ] 허용 범위와 금지 범위를 분리했다.
- [ ] 결과를 확인할 증거와 검토자를 정했다.
- [ ] 사람에게 내부 태그·ID·SHA 입력을 요구하지 않았다.
- [ ] Workbench Fast Lane 요청이면 Hermes 큐에 중복 등록하지 않고 `SOP-009`로 안내했다.

## 관련 문서

- `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`
- `../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`
- `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
