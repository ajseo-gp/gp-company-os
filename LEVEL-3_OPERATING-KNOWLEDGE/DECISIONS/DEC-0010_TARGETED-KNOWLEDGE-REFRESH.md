# DEC-0010 Targeted Knowledge Refresh

- 상태: ACTIVE
- 결정일: 2026-07-25
- 적용일: 2026-07-25
- 결정자/소유자: GP Company CEO
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

AI가 작업할 때마다 전사 Repository와 외부 자료 전체를 다시 읽으면 토큰·시간 비용이
커지고, 현재 의사결정에 필요한 Evidence가 불필요한 정보에 묻힌다. 반대로 한 번 만든
Knowledge와 Prompt를 갱신하지 않으면 플랫폼 정책, 법규, 제품·고객·성과 데이터와 Runtime
변화를 놓치게 된다.

GP Company OS는 모든 정보를 매번 주입하는 방식이 아니라 현재 과제에 필요한 지식만
선택하고 변경분을 축적하는 방식으로 운영해야 한다.

## 결정

1. 회사 지식 조사와 AI Context 구성의 기본 방식을 `Targeted Knowledge Refresh`로 한다.
2. 작업 시작 시 전사 전체가 아니라 현재 과제, 관련 Domain·Customer Journey, 권위
   Repository·문서, 필요한 운영 Evidence와 공식 외부 원천의 최소 범위를 선택한다.
3. 마지막 검증 checkpoint 이후의 commit, 문서 version, 데이터 기준일과 공식 원천
   변경분을 우선 읽는다.
4. 주간에는 활성 우선과제의 변경분·실패·데이터 품질·Runtime drift를 점검한다.
5. 월간에는 검토일이 도래한 Knowledge·Prompt·Context, 공식 정책과 Repository 간 연결
   정합성을 심층 점검한다.
6. 법규·플랫폼 정책·보안·API·중대한 데이터 정의 변경은 주기를 기다리지 않고 긴급
   Refresh 후보로 올린다.
7. 모든 Refresh는 질문, 대상 Repository·경로·원천, 기준 checkpoint, 토큰·시간 예산과
   완료 조건을 가진다.
8. 예산 또는 범위를 넘겨야 하면 자동으로 전사 조사로 확대하지 않고 추가 범위와 기대
   가치를 보고한다.
9. 결과는 회사 사실, 외부 기준, 관측 Evidence, 해석·가설과 미확인을 분리한다.
10. 자동화는 변경 후보와 영향 분석까지만 수행한다. ACTIVE 기준 변경, 외부 실행과
    민감정보 접근은 기존 승인 Gate를 따른다.

## 이유

관련 범위와 변경분을 우선하면 동일 문서를 반복 주입하는 비용을 줄이면서도 최신
Evidence와 운영 학습을 정기적으로 반영할 수 있다. Checkpoint와 출처 revision을 남기면
무엇을 이미 검토했고 무엇이 바뀌었는지 재현할 수 있다.

## 영향 범위

### 적용

- AI Task Boot와 Repository 읽기 범위
- Knowledge·Prompt·Context·SOP의 주간·월간 검토
- 공식 플랫폼·법규·기술 문서 조사
- OS·Hub·Workbench·운영 Repository 간 Runtime drift
- 토큰·시간 예산과 checkpoint 기록
- Knowledge Steward와 Hermes의 조사·라우팅 방식

### 비적용

- 보안 사고, 법규 변경과 운영 장애의 긴급 대응을 정기 주기로 미루지 않는다.
- CEO가 명시적으로 승인한 전사 Architecture Review·감사·실사를 금지하지 않는다.
- 변경이 없다는 이유로 필요한 사람 검토와 제품·운영 검증을 생략하지 않는다.
- 원본 고객·처방·원가·credential을 OS에 복사하지 않는다.

## 결과와 Trade-off

- 반복 읽기와 불필요한 외부 검색 비용이 감소한다.
- 각 작업의 근거와 checkpoint가 명확해진다.
- 범위를 지나치게 좁히면 간접 영향이나 새로운 위험을 놓칠 수 있다.
- 월간 심층 점검, 긴급 Trigger와 영향 범위 확장 요청으로 이를 보완한다.
- 자동화 전에는 Owner가 checkpoint와 검토일을 수동으로 관리한다.

## 전환과 검증

1. `WF-007`과 `SOP-012`를 운영 기준으로 등록한다.
2. 주간 Refresh 1회와 월간 Refresh 1회를 수동 수행해 토큰·시간, 발견 변경, 채택 개선안과
   누락을 기록한다.
3. checkpoint·source revision·검토일 누락률과 동일 자료 재독률을 측정한다.
4. 수동 절차 검증 후 `AUT-013`을 PILOT으로 전환한다.
5. 자동화가 범위를 임의 확대하지 않고 변경 후보만 생성하는지 확인한다.

## 재검토 조건

- 중요한 변경을 반복적으로 놓칠 때
- 조사 비용이 절감되지 않거나 checkpoint 관리비용이 더 커질 때
- Repository·Agent·사업영역 증가로 Domain별 주기가 필요할 때
- 법규·플랫폼 변경 감시를 더 짧은 주기로 운영해야 할 때
- Context retrieval 또는 semantic indexing 방식이 변경될 때

## 관련 문서

- Business: `../../LEVEL-2_BUSINESS/BUSINESS.md`
- Context: `../CONTEXT/CURRENT-PRIORITIES.md`
- Workflow: `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-007_TARGETED-KNOWLEDGE-REFRESH.md`
- SOP: `../SOP/SOP-012_TARGETED-KNOWLEDGE-REFRESH.md`
- Agent/Automation: `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-KNOWLEDGE-STEWARD.md`,
  `../../LEVEL-4_AI-EXECUTION/AUTOMATION/AUT-013_TARGETED-KNOWLEDGE-REFRESH.md`
- KPI: checkpoint 완전성, 재독 감소, 변경 탐지, 개선안 채택과 Refresh 비용
