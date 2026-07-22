# Hermes 작업 요청 템플릿

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 변경일: 2026-07-22

아래 블록을 Slack에 복사하고 모든 `<...>` 항목을 채운다.

```text
@Hermes [WORK_REQUEST] <GP-YYYYMMDD-NNN> · <업무영역> · 승인등급 <등급>

목적
<달성할 결과와 완료 조건>

OS-Ref
ajseo-gp/gp-company-os@<40자리-commit-SHA>

입력·참조
• <입력 위치 또는 참조 ID>

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
• 사람이 사용하는 기능이면 Preview URL, 데스크톱·모바일 이미지와 검수 시나리오
• 승인 revision, target branch와 자동 배포 환경

먼저 같은 스레드에 [ACK]를 남기고, 진행 상태와 최종 [RESULT]를 같은 Task-ID로
보고하세요. 승인 범위가 불명확하거나 필수 입력이 없으면 실행하지 말고 [BLOCKED]와
차단 사유만 보고하세요. 개발 결과는 Preview 승인 전 merge하지 말고, 정확한 revision에
[HUMAN:APPROVED]가 남으면 별도 확인 없이 자동 merge·배포·smoke test를 진행하세요.
```

## 작성 확인

- [ ] `Task-ID`가 새롭고 고유하다.
- [ ] `OS-Ref`가 저장소명과 40자리 commit SHA를 포함한다.
- [ ] 목적과 완료 조건이 검증 가능하다.
- [ ] 승인등급이 현재 권한표에 존재한다.
- [ ] 허용 범위와 금지 범위를 모두 적었다.
- [ ] 결과를 확인할 증거와 검토자를 정했다.
- [ ] 개발 작업이면 Preview 방식, target branch와 자동 배포 환경을 적었다.
- [ ] 승인 후 자동 merge·배포되는 범위를 확인했다.

## 관련 문서

- `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`
- `../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
- `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-003_SLACK-TO-HERMES.md`
- `../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-004_PREVIEW-TO-RELEASE.md`
