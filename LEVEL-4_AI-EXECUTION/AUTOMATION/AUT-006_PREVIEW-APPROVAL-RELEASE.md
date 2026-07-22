# AUT-006 Preview Approval Release

- 상태: PLANNED
- 우선순위: P0
- 소유자: GP Company CEO
- 실행 책임: Hermes Primary, `gp-company-hub`, GitHub·Deployment Pipeline
- 작성일: 2026-07-22

## 목적

Slack의 유효한 Human Preview 승인을 검증하고, 승인된 revision을 자동 merge·배포·검증한다.

현재 상태는 `PLANNED`다. 아래 구현 완료 조건을 충족해 `ACTIVE`로 전환되기 전에는
승인 후 수동 merge·배포로 우회하지 않는다.

## 구현 진행

| Phase | 구현 위치 | 상태 |
|---|---|---|
| Preview build·desktop/mobile artifact | [`gpcompany-lab` PR #8](https://github.com/ajseo-gp/gpcompany-lab/pull/8) | READY_FOR_REVIEW |
| Hermes manifest 검증·Slack 전달 계약 | [`gp-company-hub` PR #8](https://github.com/ajseo-gp/gp-company-hub/pull/8) | READY_FOR_REVIEW |
| 승인 envelope·identity·revision validator | [`gpcompany-lab` PR #8](https://github.com/ajseo-gp/gpcompany-lab/pull/8) | READY_FOR_REVIEW |
| Hermes Slack 승인 handler·repository dispatch | [`gp-company-hub` PR #8](https://github.com/ajseo-gp/gp-company-hub/pull/8) | 계약 완료, handler PLANNED |
| exact SHA merge·deploy 관찰·smoke test | [`gpcompany-lab` PR #8](https://github.com/ajseo-gp/gpcompany-lab/pull/8) | READY_FOR_REVIEW, 비활성 |
| 자동 rollback | `gp-company-hub`·실행 저장소 | PLANNED |

## Trigger

같은 작업 스레드에서 승인권자가 남긴 다음 이벤트:

```text
[HUMAN:APPROVED] <Task-ID> revision <40자리-SHA>
```

## 입력

- Slack workspace, channel, thread와 승인자 ID
- `Task-ID`, `OS-Ref`
- 저장소, source branch, target branch, revision SHA
- 최신 `[PREVIEW:READY]` 기록과 Preview URL
- required checks와 merge policy
- deployment pipeline, target environment, health check, rollback policy

## 처리

1. 승인자와 스레드 권한 검증
2. 승인 이벤트와 최신 Preview metadata 일치 검증
3. source branch HEAD와 승인 revision 일치 검증
4. CI, branch protection, conflict 상태 검증
5. idempotency key로 중복 Release 방지
6. repository policy에 따른 merge 실행
7. deployment pipeline 실행·관찰
8. 운영 환경 smoke test
9. 성공·실패·rollback 결과를 원래 Slack 스레드와 작업 기록에 보고

## Idempotency

다음 조합을 하나의 Release key로 사용한다.

```text
<Task-ID>:<repository>:<target-branch>:<approved-revision>:<environment>
```

동일 key가 `MERGING`, `DEPLOYING`, `RELEASED` 상태이면 새 merge·deployment를 만들지
않고 기존 실행 상태를 반환한다.

## 출력

- merge commit SHA와 merge 실행 ID
- deployment ID, environment, 운영 URL
- health·smoke test 결과
- Slack 상태 이벤트
- 실패 사유와 rollback 결과

## 승인

정확한 revision의 `[HUMAN:APPROVED]`가 merge와 지정 환경 배포를 함께 승인한다.
Automation 실행을 위한 별도 승인은 요구하지 않는다.

## 실패 처리

- 검증 실패: merge 전 `[RELEASE:BLOCKED]`
- merge API 실패: 재시도 전 merge 여부 조회, 중복 merge 금지
- deploy 실패: `[DEPLOY:FAILED]`, 정의된 rollback 실행
- smoke test 실패: 실패 deployment 표시, 정의된 rollback 실행
- rollback 미정의·실패: 자동 추가 변경 금지, 대표 escalation

## 보안과 감사

- 승인자 Slack ID와 GitHub 실행 주체를 기록한다.
- 토큰과 credential은 로그·Slack에 출력하지 않는다.
- public Preview는 인증·만료 정책을 적용하고 실제 고객정보를 사용하지 않는다.
- branch protection을 우회하거나 force merge하지 않는다.
- 모든 상태 변경은 `Task-ID`, approved revision, deployment ID에 연결한다.

## 구현 완료 조건

- 승인 identity 검증 테스트 통과
- revision 변경 시 승인 무효화 테스트 통과
- 중복 승인·재시도 idempotency 테스트 통과
- CI 실패·merge conflict 차단 테스트 통과
- 성공 deployment와 smoke test 보고 통과
- deploy 실패 rollback 또는 안전 차단 테스트 통과

## 관련 문서

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0006_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../WORKFLOW/WF-004_PREVIEW-TO-RELEASE.md`
