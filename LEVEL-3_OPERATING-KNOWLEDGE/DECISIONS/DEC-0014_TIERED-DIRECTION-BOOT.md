# DEC-0014 작업 위험도별 Direction Boot

- 상태: ACTIVE
- 결정일: 2026-07-29
- 적용일: 2026-07-29
- 결정자/소유자: GP Company CEO
- 적용 범위: Company OS·Hub·Workbench·프로젝트 저장소의 AI 작업 시작
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

코드 작업마다 Mission·Vision 전체를 읽으면 토큰·시간 비용이 커지고 단순 수정이 느려진다.
반대로 코드 저장소만 읽으면 매출·대표 병목·양도 가능한 회사라는 방향과 동떨어진 기능을
빠르게 만들 수 있다. 코드 저장소의 로컬 경로도 기기마다 달라 권위 원본으로 사용할 수 없다.

## 결정

1. 모든 AI 작업은 정확한 40자리 `OS-Ref`의 `DIRECTION-SNAPSHOT.md`를 작업당 한 번 읽는다.
   같은 세션·같은 OS-Ref에서는 Snapshot과 원문을 반복 주입하지 않고 검증된 checkpoint를
   재사용한다.
2. 작업을 다음 Direction Profile로 분류한다.

| Profile | 대상 | 필수 방향 문서 |
|---|---|---|
| `D0` | 버그·테스트·리팩터링·문구·승인된 UI/API 구현처럼 사업 의미를 바꾸지 않는 변경 | Direction Snapshot |
| `D1` | 고객 여정·매출 기능·채널·Agent·자동화·데이터/KPI에 영향을 주는 기능 | Snapshot + DEC-0009 + 관련 Business·Decision·Context·SOP |
| `D2` | 가격·프로모션·외부 쓰기·신규 채널/사업·권한·정책·보안·규제·Architecture 변경 | Snapshot + Mission + Vision + D1 문서 |

3. 더 높은 Profile 조건이 하나라도 포함되면 높은 Profile을 적용한다. 불명확하면 한 단계
   높여 분류한다.
4. 권위 원본은 `ajseo-gp/gp-company-os@<OS-Ref>`다. `~/projects/gp-company-os` 등 로컬
   clone은 편의상 사용할 수 있지만 branch·최신 여부를 검증하지 않고 원본으로 간주하지 않는다.
5. 코드 저장소에 OS 문서가 없으면 Claude Code·Hermes가 `gh api`와 명시적 `?ref=<OS-Ref>`로
   필요한 Snapshot·Mission·Vision만 읽는다. 사람에게 경로·SHA 복사를 요구하지 않는다.
6. `D0`에서 방향 문서를 읽을 수 없으면 로컬 진단·초안은 가능하지만 merge·배포하지 않는다.
   `D1`·`D2`는 필수 방향 문서를 확인하기 전 구현·외부 실행을 시작하지 않는다.
7. 결과에는 `Direction-Profile`, `OS-Ref`, 읽은 방향 문서와 적용한 방향을 한 줄로 남긴다.
8. Claude Code는 `gp-company-hub`와 `gpcompany-lab`의 작업 Boot에 이 Profile 선택과 원격
   읽기 규칙을 구현한다. Codex는 OS 정책과 Snapshot만 관리한다.

## 이유

짧은 Snapshot은 모든 작업이 회사 방향을 놓치지 않게 하고, 원문은 실제 사업·권한 판단이
필요한 작업에만 읽어 비용을 통제한다. 고정 OS-Ref와 session checkpoint를 사용하면 오래된
로컬 clone과 반복 주입을 동시에 방지할 수 있다.

## 영향 범위

### 적용

- AI Task Boot, Hermes·Claude Code 작업 envelope와 Repository AGENTS 지침
- 코드·데이터·API·상거래 자동화·OS 정책 작업의 읽기 범위
- 토큰·시간 비용, OS-Ref와 작업 결과 기록

### 비적용

- D0라는 이유로 관련 Decision·SOP·테스트·보안 검사를 생략하지 않는다.
- Snapshot이 Mission·Vision 원문을 변경하거나 대체하지 않는다.
- 외부 쓰기·가격·프로모션을 D0·D1으로 낮춰 승인 Gate를 우회하지 않는다.

## 결과와 Trade-off

- 단순 코드 작업은 Mission·Vision 전체를 반복해서 읽지 않아 빠르게 시작한다.
- 모든 작업은 짧은 방향 기준을 공유해 구현 드리프트를 줄인다.
- Profile 분류가 한 단계 추가되지만 Hermes·Claude Code가 자동 생성하므로 사람이 선택하지 않는다.

## 전환과 검증

1. `SYSTEM_BOOT.md`, `OS-INDEX.yaml`, `SOP-012`와 Repository 지침에 Profile을 반영한다.
2. Claude Code가 Hub·Workbench Boot에서 Snapshot 원격 조회·cache·Profile 기록을 구현한다.
3. D0·D1·D2 각 1건을 실행해 읽은 문서, 소요 시간·토큰과 방향 누락을 비교한다.
4. 성공 기준은 Direction-Profile 누락 0건, D2 Mission·Vision 누락 0건, 같은 OS-Ref의
   중복 원문 읽기 0건이다.

## 재검토 조건

- Snapshot이 오래되거나 원문과 반복적으로 충돌할 때
- Profile 분류가 코드 작업을 과도하게 지연시킬 때
- D0·D1에서 중대한 방향·권한 영향을 반복적으로 놓칠 때
- OS 문서 전달 방식이 GitHub API 외 방식으로 변경될 때

## 관련 문서

- Direction: `LEVEL-1_DIRECTION/DIRECTION-SNAPSHOT.md`, `MISSION.md`, `VISION.md`
- Decision: `DEC-0009_REVENUE-FIRST.md`, `DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`, `DEC-0012_AI-WORK-ALLOCATION.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-012_TARGETED-KNOWLEDGE-REFRESH.md`
- Agent: `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
