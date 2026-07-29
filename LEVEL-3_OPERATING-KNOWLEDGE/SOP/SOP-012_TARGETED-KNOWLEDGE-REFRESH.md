# SOP-012 Targeted Knowledge Refresh

- 상태: ACTIVE
- 버전: 1.1
- 소유자: Knowledge Steward / GP Company CEO
- 적용 Workflow: WF-007 Targeted Knowledge Refresh
- 적용 Decision: DEC-0010, DEC-0014
- 작성일: 2026-07-25
- 다음 검토일: 2026-08-25

## 목적

필요한 Repository·문서·운영 Evidence·공식 원천만 변경분 중심으로 조사해 토큰·시간
비용을 통제하고 최신 지식과 실행 기준의 개선 후보를 추적 가능하게 만든다.

## 적용 범위

- 작업별 필요한 지식의 빠른 조사와 Prompt·Knowledge 고도화
- 활성 우선과제의 주간 Delta Refresh
- 공식 기준·Knowledge·Prompt·Context의 월간 심층 Refresh
- 법규·플랫폼·보안·API·데이터 정의 변경의 긴급 Refresh

CEO가 별도 승인한 전사 Architecture Review·감사·실사는 범위를 확대할 수 있지만,
범위와 예산을 먼저 기록해야 한다.

## 입력 정보

- Refresh-ID, 유형과 Owner
- 답할 질문과 Revenue 또는 운영 기여
- 대상 Domain·Customer Journey
- 허용 Repository·브랜치·경로·외부 원천과 제외 범위
- 이전 checkpoint, commit SHA, source version·검토일
- 토큰·시간·원천 수 또는 실행비용 예산
- 완료 조건과 필요한 정확도
- 관련 ACTIVE Decision·Context·SOP

checkpoint가 없으면 관련 범위의 최초 baseline만 만들며 전사 전체로 확대하지 않는다.

## 실행 단계

### 0. Direction Profile 선택

`DEC-0014`에 따라 `D0`·`D1`·`D2`를 분류하고 정확한 OS-Ref의 Direction Snapshot을 읽는다.
`D1`은 `DEC-0009`와 관련 운영 문서, `D2`는 Mission·Vision 원문까지 범위에 포함한다.
같은 세션·OS-Ref에서 검증한 문서는 다시 전체 주입하지 않고 checkpoint를 재사용한다.

### 1. 질문과 범위 고정

결정하거나 고도화할 질문을 한 문장으로 정의한다. `OS-INDEX.yaml`과 ACTIVE Decision에서
최소 Repository·문서·원천을 선택한다.

### 2. 예산과 Stop 조건 고정

Owner가 제공한 토큰·시간·원천 예산을 기록한다. 숫자 예산이 없으면 조사 범위와 완료
조건을 먼저 제안하고 새로운 Domain·Repository로 확대하기 전에 중지한다.

### 3. Baseline 잠금

마지막 checkpoint의 commit SHA, source version, 데이터 기준일과 문서 검토일을 확인한다.
불명확하면 `BASELINE_PARTIAL`로 표시한다.

### 4. Delta 수집

- Repository: checkpoint 이후 commit·diff·Issue·CI·Runtime 변경
- 운영 데이터: 같은 정의와 기준시각의 최신 기간·오류·누락
- 공식 외부 원천: 게시·개정일, version, 변경 공지
- Knowledge·Prompt: 검토일 도래, 미연결·충돌·REVIEW 상태

변경되지 않은 원문은 다시 전체 주입하지 않고 기존 검증 요약과 revision을 재사용한다.

### 5. 검증과 분류

출처 권위, 적용 시점, 범위, 회사 적용 가능성과 충돌을 확인한다. 회사 사실, 공식 외부
기준, 관측 Evidence, 해석·가설, 미확인·접근 차단으로 분리한다.

### 6. 영향 분석

Business, Decision, Context, Knowledge, SOP, Prompt, Agent, Workflow, Automation과 KPI
영향을 확인한다. 원래 범위를 넘으면 자동 조사하지 않고 확장 후보로 남긴다.

### 7. 개선 후보 작성

기존 문서를 우선 갱신한다. 정책은 Decision, 현재 상태는 Context, 검증된 지식은
Knowledge, 반복 절차는 SOP, 실행 입력 형식은 Prompt 후보로 분류한다.

### 8. 승인과 적용

ACTIVE 의미·권한·승인 Gate를 바꾸는 변경은 정확한 revision으로 승인받는다. 자동화는
초안을 만들 수 있지만 승인·merge·외부 실행을 대신하지 않는다.

### 9. Checkpoint 기록

범위, source revision, 변경 여부, 결과, 사용량, 미완료 항목과 다음 검토일을 기록한다.
`NO_CHANGE`도 checkpoint로 남긴다.

## Cadence

### 작업별

현재 질문에 직접 필요한 Domain과 Repository만 조사한다. 답이 확보되면 관련성이 낮은
전사 영역을 계속 탐색하지 않는다.

### 주간

- 활성 우선과제와 관련 Repository의 checkpoint 이후 변경
- 실패·차단·데이터 품질·CI·Runtime drift
- 이번 주 의사결정에 필요한 공식 원천 변경 신호
- 다음 주 실행에 영향을 주는 Knowledge·Prompt 후보

### 월간

- 검토일이 지난 ACTIVE·REVIEW Context·Knowledge·Prompt
- 공식 플랫폼·법규·API version과 출처 유효성
- OS·Hub·Workbench·운영 원본 간 적용 revision drift
- 중복·미연결·사용되지 않는 지식과 반복 실패
- 주간 Refresh의 누락과 비용 대비 채택률

### 긴급

법규, 플랫폼 제재·정책, 보안, credential, API 중단, 핵심 KPI 정의 변경은 다음 주기를
기다리지 않는다.

## 승인 필요 지점

- 전사 전체 또는 새로운 Domain·Repository로 범위 확대
- 처음 승인한 토큰·시간·비용 예산 확대
- 민감정보·고객·처방·원가·credential 접근
- ACTIVE 문서 의미 변경
- 자동 merge, 외부 게시·발송·채널·상품정보 변경
- `AUT-013`의 PILOT·ACTIVE 전환

## 출력물

- Scope Manifest와 제외 범위
- Delta Evidence와 source revision
- `NO_CHANGE`, `CHANGE_PROPOSED`, `SOURCE_BLOCKED` 또는 `BUDGET_BLOCKED`
- 영향 문서와 개선 후보
- 확인·가설·미확인·승인 필요사항
- 사용량·checkpoint·다음 검토일

## 실패·예외 처리

- 범위 불명확: `SCOPE_BLOCKED`
- checkpoint 없음: bounded baseline 생성, `BASELINE_PARTIAL`
- source 접근 실패: `SOURCE_BLOCKED`
- 예산 도달: `BUDGET_BLOCKED`, 완료 범위와 추가 가치 보고
- 충돌 해결 불가: Source of Truth와 CEO Decision 요청
- 민감정보 발견: 수집 중지, 출력 제외와 보안 Owner 인계
- 변경 자동 적용 시도: 중지하고 승인 Gate 위반 기록

## 관련 문서

- `../DECISIONS/DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`
- `../DECISIONS/DEC-0014_TIERED-DIRECTION-BOOT.md`
- `../../LEVEL-1_DIRECTION/DIRECTION-SNAPSHOT.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-007_TARGETED-KNOWLEDGE-REFRESH.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-KNOWLEDGE-STEWARD.md`
- `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-013_TARGETED-KNOWLEDGE-REFRESH.md`
- `../../OS-INDEX.yaml`
