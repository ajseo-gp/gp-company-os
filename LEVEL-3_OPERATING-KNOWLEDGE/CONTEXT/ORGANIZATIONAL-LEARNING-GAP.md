# Organizational Learning Gap

- 상태: ACTIVE
- 소유자: GP Company CEO / OS Owner
- 기준일: 2026-07-26
- 다음 검토일: 2026-08-08
- 적용 범위: GP Company OS의 전사 학습 계약과 OS·Hub·Workbench 간 Runtime 경계
- 검토 기준: `82dd55618df7e92d8b66c1f6a8f868a098f1d97b`

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

## 저장소별 확인 범위

| 저장소·시스템 | 원본 책임 | 이번 검토에서 확인된 것 |
|---|---|---|
| `gp-company-os` | 정책·Decision·Context·Knowledge·SOP·실행 계약 | 위 공백을 문서 기준으로 확인 |
| `gp-company-hub` | Hermes 오케스트레이션·Pipeline·프로젝트 운영 스펙 | 실제 학습 소비·포착 구현 상태 `미확인` |
| `gpcompany-lab` / GP Workbench | 코드·작업 큐·실행 로그·KPI와 운영 기록 | Learning 상태·UI·데이터 구현 상태 `미확인` |
| 승인된 운영 저장소 | 채널·고객·연구·생산의 권한 있는 원본 Evidence | 원본별 보존·연결 상태 `미확인` |

다른 저장소의 상태는 이 OS에서 추정하지 않는다. 구현 감사에는 각 저장소의 정확한
revision과 접근 가능한 Evidence가 필요하다.

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
- GP Workbench의 Review 인스턴스 구현과 Hub의 Preflight 주입 구현은 `미확인`이다.
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
