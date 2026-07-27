# Organizational Learning Gap

- 상태: ACTIVE
- 소유자: GP Company CEO / OS Owner
- 기준일: 2026-07-27
- 다음 검토일: 2026-08-08
- 적용 범위: GP Company OS의 전사 학습 계약과 OS·Hub·Workbench 간 Runtime 경계
- OS 활성화 기준: `0ae256ee97b397aac497ad437fabf90c88ea117a`
- Hub 감사 기준: `origin/main@48f4ca1`, 변경 후보
  `c052496e36db72cc72d58256f8d0f60906350c09`
- Workbench 감사 기준: `origin/main@2d0fec1`, 변경 후보
  `7005efadbc160a16ed55b88e57ac5443e0f97ccf`

## 확인된 현재 상태

GP Company OS에는 학습과 지식 갱신을 위한 부분 계약이 이미 존재한다.

- `DEC-0009`, `WF-006`, `SOP-011`은 Marketing Campaign의 Evidence를
  EXPERIMENT·PRACTICE·FAILURE·INSIGHT 후보와 다음 Campaign으로 환류한다.
- `SOP-006`은 주간 Review에서 Knowledge·SOP·Decision 후보를 만든다.
- `DEC-0010`, `WF-007`, `SOP-012`는 Repository·운영 Evidence·공식 외부 원천의
  변경분을 조사해 지식과 실행 기준의 최신성을 유지한다.
- `KNOWLEDGE/README.md`는 검증된 학습 유형과 승격 기준을 정의한다.

따라서 현재 문제는 “학습 문서가 전혀 없음”이 아니라 학습 계약이 Marketing과 Refresh에
부분적으로 존재하고, 모든 반복 실행의 시작과 종료에 강제되지 않는다는 것이다.

## 2026-07-25 감사에서 확인된 공백

1. 전사 공통으로 실행 전에 관련 PRACTICE·FAILURE·EXPERIMENT를 읽고 무엇을 적용했는지
   남기는 `Learning Preflight`가 없다.
2. 일반 Task의 완료 조건에 실제 결과, 예상과의 차이, 새 학습 또는 `NO_NEW_LEARNING`
   사유가 필수로 포함되지 않는다.
3. Knowledge를 만든 뒤 어떤 SOP·Prompt·Agent·Automation이 이를 반드시 소비해야 하는지
   지정하는 `Enforcement Point` 계약이 없다.
4. 다음 유사 실행에서 학습이 실제로 사용됐고 결과가 개선됐는지 확인하는
   `Reuse Verification` 상태가 없다.
5. `Knowledge Steward`는 문서 상태 `REVIEW`, Runtime 상태 `PLANNED`이므로 전사 학습
   승격과 재사용 검증이 실제 운영되고 있다고 볼 수 없다.
6. `AUT-013`도 `PLANNED`이므로 Targeted Knowledge Refresh의 자동 실행은 검증되지 않았다.
7. Agent 공통 템플릿과 Hermes ACTIVE 명세에는 학습의 사전 소비와 사후 산출물을
   필수 인계 필드로 요구하지 않는다.
8. `SYSTEM_BOOT.md`의 전체 Boot Sequence와 Source of Truth에는 Knowledge가 존재하지만,
   AI Task Boot의 필수 충돌 확인과 최소 결과 계약에는 Knowledge 조회·적용 기록이 빠져
   있어 생성과 소비가 비대칭이다.
9. `SOP-006`은 출력물로 Weekly Review 템플릿 자체를 가리키며 기준기간별 인스턴스의
   원본 위치·파일명·ID 규칙을 정의하지 않는다. OS에는 인스턴스가 없지만 Workbench 등
   다른 실행 원본의 실제 Review 수행 여부는 `미확인`이다.

## 위험

- 지식 파일이 생성되어도 다음 Agent가 읽지 않아 같은 실패와 대표의 수작업이 반복될 수 있다.
- AI가 최초 지침과 고정된 Prompt만 실행하면 시장·고객·Runtime 변화에 맞춰 행동이
  개선되지 않는다.
- 일회성 성과를 일반 규칙으로 과대 승격하거나, 반대로 검증된 학습이 운영 계약에
  반영되지 않을 수 있다.
- 학습 문서 수는 늘지만 매출, 재작업, 오류와 대표 의존도가 개선되지 않는
  `Documentation Theater`가 발생할 수 있다.

## 2026-07-26 저장소별 Runtime 감사

감사는 각 저장소의 로컬 clone 이름이 아니라 `origin/main` revision을 기준으로 했다.
같은 저장소의 여러 clone이 서로 다른 revision을 가리키고 있었으므로 특정 홈 경로를
운영 원본으로 추정하지 않았다.

| 저장소·시스템 | 감사 revision | 확인 결과 |
|---|---|---|
| `gp-company-os` | `0ae256e…` | `DEC-0011`·`WF-008`·`SOP-013` ACTIVE, Boot·템플릿·CI Enforcement 반영 |
| `gp-company-hub` authority main | `48f4ca1` | `.gp-company-os.yaml`이 과거 OS를 `current`로 표시했고, 공통 Learning Preflight·L2 수동 역할 Gate가 없었음 |
| `gp-company-hub` 변경 후보 | `c052496…` | 승인 Gate와 공통 Learning Preflight·L2 역할/측정 Gate, OS drift·임의 clone·게시 승인 오인 CI, PII-safe LangGraph 관제탑 이벤트·스냅샷 내보내기 포함. Runtime 테스트 94건 통과. authority main 미반영, 운영 활성화 미승인 |
| `gpcompany-lab` authority main | `2d0fec1` | B2C Workbench는 설계 문서만 있고 조직학습 UI·API·상태 저장 구현이 없었으며 과거 OS를 `current`로 표시 |
| `gpcompany-lab` 변경 후보 | `7005efa…` | 설정 안 대표 전용 한국어 관제탑, GitHub 열린 PR×변경 파일 충돌·경과일 실시간 조회, GitHub default branch 정본과 로컬 clone revision·역할 비교, PII-safe LangGraph 흐름 반영. Revenue 영역은 별도 PR과 겹치지 않게 제거. 계약 검증·production build·PC/모바일 시각 검수 통과 |
| 승인된 운영 저장소 | 미확인 | 채널·고객·연구·생산 원본 Evidence의 보존·연결 상태는 이번 감사 범위 밖 |

두 변경 후보는 로컬 작업 브랜치 revision이며 push·Draft PR·merge·배포되지 않았다.
따라서 Hub Agent/Automation과 Workbench Runtime이 PILOT·ACTIVE라고 보고하지 않는다.
외부 게시·Campaign 실행·고객 발송·가격/광고 변경 승인도 이 감사와 변경 후보에서
생성되지 않았다.

## 2026-07-27 Workbench 열린 PR 중복 감사

- Draft PR `#6`은 `/admin/b2c` Agent Task Queue이므로 관제탑 자체와 목적이 다르다.
  다만 `README.md`, `src/app/admin/b2c/layout.tsx`,
  `src/app/admin/quote/layout.tsx` 등에서 다른 Draft와 변경 파일이 겹친다.
- Draft PR `#19`는 Revenue Snapshot Preview이며 관제탑의 우선 범위가 아니다.
  GitHub 감사 시 `mergeStateStatus=DIRTY`였고 `#6`과 위 세 파일이 겹쳤다.
- 관제탑 변경 후보는 매출·방문 UI를 제거하고 열린 PR·변경 파일·정본·승인 체류를
  우선한다. PR 본문·patch·토큰은 Workbench 응답에 포함하지 않는다.
- 열린 PR 수와 충돌 파일은 빠르게 바뀌므로 OS 문서에 고정값으로 운영하지 않고,
  Workbench가 GitHub 원본을 읽어 새로고침 시점 기준으로 계산한다.

## 2026-07-26 승인 조치

- `DEC-0011 Evidence-to-Improvement Organizational Learning`: ACTIVE
- `WF-008 Organizational Learning Loop`: ACTIVE 수동 운영 기준
- `SOP-013 Organizational Learning Cycle`: ACTIVE
- `SYSTEM_BOOT.md`: Knowledge 사전 소비와 적용·비적용 결과 계약 반영
- `OS-INDEX.yaml`과 CI: 핵심 소비 파일의 `Learning-Ref` Enforcement 검사
- `SOP-006`: GP Workbench Weekly Review 인스턴스 원본 계약 반영
- `Knowledge Steward`: 문서 계약 ACTIVE, Agent Runtime PLANNED

## 남은 실행 공백

- 첫 L2 PILOT의 실행 Owner, 수동 Reviewer·대리자와 측정일은 아직 `미확인`이다.
- Hub 학습 Gate 후보는 authority main 반영·운영 Runtime 배포·Agent/Automation 활성화
  전까지 실행 기준이 아니다.
- GP Workbench의 한국어 관제탑 UI·API와 Hub LangGraph 실행 스냅샷 연결은 로컬 변경
  후보에 구현됐지만, 서버 전용 GitHub 권한·clone registry·역할 marker, Weekly Review
  인스턴스와 운영 상태 저장·배포·실제 데이터 연결은 아직 `PLANNED`다.
- OS revision `0ae256e…`와 Hub·Workbench 변경 후보는 authority repository에 push되어
  검증되기 전까지 각 저장소의 sync 상태를 `current`로 올리지 않는다.
- EXPERIMENT·FAILURE·INSIGHT·LESSON Knowledge는 첫 PILOT Evidence 전에는 생성하지 않는다.
- Agent·Automation Runtime 전환과 외부 실행은 별도 승인 대상이다.

## 관련 문서

- `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- `../DECISIONS/DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`
- `../SOP/SOP-006_WEEKLY-REVIEW.md`
- `../SOP/SOP-011_MARKETING-EXPERIMENT.md`
- `../SOP/SOP-012_TARGETED-KNOWLEDGE-REFRESH.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-KNOWLEDGE-STEWARD.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-HERMES.md`
