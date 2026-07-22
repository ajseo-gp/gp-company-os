# DEC-0006 Human Preview 승인 후 자동 Release

- 상태: ACTIVE
- 결정일: 2026-07-22
- 결정자: GP Company CEO

## 배경

사람이 사용하는 화면과 업무 흐름은 코드만 검토해서 품질과 사용성을 판단하기 어렵다.
개발 완료와 운영 반영 사이에 실제로 보고 클릭할 수 있는 Preview 검수가 필요하다.

반대로 Preview 승인 후 merge와 배포를 다시 수동 요청하면 대기와 전달 오류가 생긴다.
사람은 경험과 결과를 승인하고, 승인된 revision의 기계적 반영은 자동화한다.

## 결정

1. 사람에게 보이는 기능과 업무 흐름은 코드 작성만으로 완료 처리하지 않는다.
2. Agent는 merge 전에 정확한 revision으로 실행한 Preview와 시각 증거를 제공한다.
3. 승인권자는 같은 `Task-ID`의 Slack 스레드에서 정확한 Preview revision을
   `[HUMAN:APPROVED]`로 승인한다.
4. 유효한 승인과 필수 CI 통과가 확인되면 별도 merge 요청 없이 자동으로 merge하고
   지정 환경에 배포한다.
5. 배포 후 smoke test를 통과하고 접근 가능한 운영 링크와 증거가 보고되어야
   `[RELEASED]`로 종료한다.
6. 승인 후 revision이 변경되면 기존 승인은 즉시 무효다. 새 Preview와 새 승인을 받는다.
7. Preview 링크·이미지·동작 증거를 제공할 수 없으면 코드만으로 merge하지 않고
   `[BLOCKED:PREVIEW]`로 보고한다.

## Human Preview Gate

승인 요청에는 최소한 다음이 포함되어야 한다.

- `Task-ID`
- 대상 저장소, base branch와 정확한 40자리 revision SHA
- 사람이 직접 열 수 있는 Preview URL
- 핵심 화면의 데스크톱·모바일 이미지 또는 짧은 동작 영상
- 변경 전·후 차이와 검수 시나리오
- 테스트·CI 결과와 알려진 제한사항
- 승인 시 자동 merge될 branch와 자동 배포될 환경

시각 인터페이스가 없는 backend·infrastructure 변경은 Preview URL 대신 재현 가능한
API 결과, 테스트 보고서, 로그·대시보드 또는 안전한 sandbox 실행 증거를 제공한다.

## 승인 계약

유효한 승인은 다음 형식으로 남긴다.

```text
[HUMAN:APPROVED] <Task-ID> revision <40자리-SHA>
```

이 승인은 다음 항목만 허가한다.

- 표시된 revision을 저장소 정책에 따라 target branch에 merge
- 요청과 Preview에 표시된 target environment로 배포
- 배포 검증과 실패 시 사전에 정의된 rollback 수행

다른 revision, 다른 저장소·branch·환경 또는 추가 변경에는 승인이 적용되지 않는다.

## 자동 Release 전제조건

- 승인자가 GP Company CEO 또는 명시적으로 지정된 승인권자다.
- 승인 `Task-ID`와 revision이 최신 `[PREVIEW:READY]` 기록과 정확히 일치한다.
- 승인 이후 새 commit이 없다.
- 필수 CI, 보안·정책 검사와 repository protection이 통과한다.
- merge conflict가 없고 target branch 조건을 만족한다.
- 배포 환경, health check와 실패 처리가 사전에 정의되어 있다.

하나라도 충족되지 않으면 merge하지 않고 `[RELEASE:BLOCKED]`로 보고한다.

## 전환 조건

`AUT-006_PREVIEW-APPROVAL-RELEASE.md`가 현재 `PLANNED`인 동안에는 승인 이벤트를
받아도 수동 merge로 우회하지 않는다. Hermes는 `[RELEASE:BLOCKED]`와 자동화 미활성
상태를 보고한다.

승인 identity, revision 고정, idempotency, merge·deploy·rollback 테스트를 통과하고
AUT-006 상태가 `ACTIVE`가 된 이후부터 `[HUMAN:APPROVED]`가 자동 Release를 트리거한다.

## 결과 계약

자동 Release는 같은 Slack 스레드에 다음을 보고한다.

- merge 결과와 merge commit SHA
- deployment ID, 대상 환경과 운영 URL
- 배포 시각과 실행 주체
- smoke test 결과
- rollback 실행 여부
- 최종 상태: `[RELEASED]`, `[RELEASE:BLOCKED]`, `[DEPLOY:FAILED]`, `[ROLLED_BACK]`

## 재검토 조건

- 승인권자 또는 승인 인터페이스 변경
- merge 정책, protected branch 또는 CI 조건 변경
- preview·deployment provider 변경
- 자동 rollback 정책 변경
- 고객정보·결제·생산시스템 등 고위험 환경에 적용 범위 확대

## 관련 문서

- `DEC-0005_HERMES-SLACK-ORCHESTRATION.md`
- `../SOP/SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-004_PREVIEW-TO-RELEASE.md`
- `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-006_PREVIEW-APPROVAL-RELEASE.md`
