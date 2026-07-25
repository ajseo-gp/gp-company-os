# AUT-013 Targeted Knowledge Refresh

- 상태: PLANNED
- 소유자: Knowledge Steward / Automation Owner
- 구현 위치: `gp-company-hub` 후보, 미확정
- 버전: 0.1
- 검토일: 2026-08-25

## Purpose

`WF-007`과 `SOP-012`의 범위·checkpoint·Delta 수집·변경 후보 생성을 지원해 반복적인
전체 원문 재독을 줄인다. Knowledge나 운영 기준을 스스로 승인·적용하지 않는다.

## Related Workflow and SOP

- Workflow: `WF-007 Targeted Knowledge Refresh` (`ACTIVE`)
- SOP: `SOP-012 Targeted Knowledge Refresh` (`ACTIVE`)
- Decision: `DEC-0010 Targeted Knowledge Refresh` (`ACTIVE`)
- 관련 Review: `SOP-006 Weekly Review`

## Trigger

- Owner가 승인한 작업별 Refresh 요청
- 승인된 주간·월간 schedule
- 법규·플랫폼·보안·API 변경 감지 후 긴급 후보 생성

schedule, 감시 대상과 구현 위치가 확정되기 전에는 실행하지 않는다.

## Inputs and Validation

- Refresh-ID와 유형
- 질문·Domain·Journey·Revenue 또는 운영 기여
- Repository·경로·공식 원천 allowlist와 제외 범위
- baseline checkpoint·commit SHA·source version
- 토큰·시간·원천·실행비용 예산
- 관련 ACTIVE Decision·Context·SOP
- Owner·승인자·완료 조건

필수 입력이 없으면 `SCOPE_BLOCKED` 또는 `BASELINE_PARTIAL`로 종료하고 전사 조사로
확대하지 않는다.

## Processing

1. OS Index에서 관련 문서 경로를 해석한다.
2. 허용된 Repository와 원천만 접근한다.
3. checkpoint 이후 diff·commit·Issue·CI·검토일·source version 변경을 수집한다.
4. 변경되지 않은 원문은 기존 검증 요약과 revision을 참조한다.
5. 출처·시점·적용 범위·충돌과 민감정보를 검사한다.
6. 변경을 Context·Knowledge·SOP·Prompt·Decision 후보로 분류한다.
7. 영향 범위, 미확인, 사용량과 다음 checkpoint 초안을 생성한다.
8. 승인 전에는 문서 의미 변경·merge·외부 실행을 수행하지 않는다.

## Outputs

- Refresh Report와 상태
- Scope Manifest·제외 범위·예산 사용
- baseline과 최신 source revision
- Delta Evidence와 `NO_CHANGE`
- 충돌·미확인·접근 차단
- 문서별 변경 후보와 영향 분석
- 승인 요청과 다음 checkpoint·검토일 초안

## Authority and Approval

자동 허용: allowlist 내 읽기, diff·검토일·source version 비교, 비민감 변경 후보 생성.

승인 필요: 범위·예산 확대, 민감정보 접근, ACTIVE 문서 의미 변경, commit·PR·merge,
외부 게시·발송·운영 시스템 변경과 PILOT·ACTIVE 전환.

## Idempotency, Retry and Timeout

- idempotency key: `Refresh-ID + baseline + scope hash`
- 같은 key의 성공 결과가 있으면 원문을 다시 읽지 않고 기존 결과를 반환한다.
- source별 제한된 재시도 후 `SOURCE_BLOCKED`로 수동 인계한다.
- 예산·timeout 도달 시 완료 범위를 보존하고 `BUDGET_BLOCKED`로 종료한다.
- checkpoint는 승인된 Refresh 결과가 확정된 뒤에만 갱신한다.

## Failure, Rollback and Manual Handoff

- 잘못된 scope: 실행 중지, Scope Manifest 수정 요청
- baseline drift: 최신 revision을 잠그고 재검토 요청
- source schema 변경: adapter 변경 후보와 영향 보고
- 민감정보 발견: 저장·출력 중지, 보안 Owner 인계
- 잘못된 후보: 후보 폐기, checkpoint는 이전 값 유지
- 자동 적용 시도: 실행 차단, 감사 로그와 Owner escalation

## Audit, Security and Retention

- Refresh-ID, trigger, Owner, scope hash와 승인자
- 접근 Repository·경로·source revision
- 예산·사용량·재시도·차단 상태
- 후보·승인·거절과 checkpoint
- 고객 PII, 처방·함량, 원가·계약·credential 원문은 저장하지 않는다.

## Activation Criteria

### PILOT

- 주간·월간 수동 Refresh를 각 1회 이상 완료
- Scope Manifest와 checkpoint 형식 승인
- allowlist·budget stop·민감정보 차단 테스트 통과
- `NO_CHANGE`, `SOURCE_BLOCKED`, `BUDGET_BLOCKED` 테스트 통과
- Owner·schedule·구현 저장소와 로그 위치 확정

### ACTIVE

- 중요한 변경 누락과 무단 범위 확대가 없음
- 토큰·시간 비용 감소가 측정됨
- 승인 없는 문서·외부 상태 변경이 없음
- 실패·수동 인계와 감사 로그가 운영 검증됨
- CEO가 정확한 automation revision을 승인함

## Operating KPI

- 전체 재독 대비 Delta 검토 비율과 checkpoint 재사용률
- Refresh당 토큰·시간·실행비용
- 변경 탐지 적시성·오탐·누락
- 개선 후보 채택률
- 범위·예산·승인 위반 건수
- `SOURCE_BLOCKED`, `BUDGET_BLOCKED` 복구시간
