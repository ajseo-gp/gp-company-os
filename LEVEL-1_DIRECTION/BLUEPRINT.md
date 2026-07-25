# GP Company OS Blueprint

**Status:** ACTIVE  
**Version:** 0.2

## System Flow

```text
Mission / Vision
      ↓
Hair & Scalp Business + AI & Company OS Business
      ↓
Customer Journey Revenue Engine
      ↓
Context + Decisions + Knowledge
      ↓
SOP + Prompt Library
      ↓
Workflow + Agents + Automation
      ↓
Dashboard + KPI
      ↓
Weekly Review + CEO Review
      ↓
New Decisions / Updated Context
```

두 수익 엔진의 실행 결과는 분리해 측정하고, 검증된 학습은 동일한 OS로 환류한다.
현재 실행 우선순위는 `DEC-0009`에 따라 Revenue Engine과 Marketing Runtime을 먼저
구축하는 것이다.

## Operational Traceability

```text
Business Outcome
      ↓
Workflow state and owner
      ↓
SOP execution and approval
      ↓
Agent / Human / Automation evidence
      ↓
KPI and Review
      ↓
Context / Knowledge / Decision update
```

Workflow는 회사 전체의 상태·역할 인계를, SOP는 한 반복 업무의 수행법을 정의한다.
Agent와 Automation은 정책을 새로 만들지 않고 승인된 Workflow·SOP를 실행한다.

## Design Rules

- 모든 Agent는 최소 1개의 SOP를 참조해야 한다.
- 모든 Automation은 입력, 출력, 승인 지점, 실패 처리 기준을 가져야 한다.
- 모든 KPI는 실제 의사결정과 연결되어야 한다.
- 모든 반복 이슈는 SOP 또는 Knowledge 갱신 후보가 된다.
- 중요한 변경은 Decision Record를 생성한다.
- 다른 저장소와 실행 시스템은 적용한 OS 버전과 관련 Decision을 추적해야 한다.
- 회사 운영은 대표 없이도 인수·실행·검증할 수 있도록 역할, 권한, 산출물과 기록을 남겨야 한다.
- AI·Company OS의 외부 상품화는 내부 검증 근거를 가져야 한다.
- Context와 Knowledge는 원본 근거, 적용 범위, 소유자와 검토일을 가져야 한다.
- Agent 명세의 승인 상태와 실제 Runtime 상태를 분리한다.
- 신규 브랜드·사업은 기존 유형 계약과 `scope`로 먼저 확장하고, 규제·권한·운영 차이가
  명확할 때만 구조를 분리한다.
- 운영 원문과 민감정보는 보안 저장소에 두고 OS에는 정책과 안전한 Evidence 참조만 둔다.
- 신규 설계는 고객 확보, 판매, 재구매, 대표의 마케팅 병목 또는 반복 가능한 성장에 대한
  기여 경로를 먼저 설명한다.
- 모든 마케팅 실행은 Journey 단계, Campaign-ID, 채널, 제품, 비용, Evidence와 결과 KPI를
  연결한다.
- 좋은 성과는 EXPERIMENT/PRACTICE, 실패는 FAILURE, 반복 고객 행동은 INSIGHT 후보로 남긴다.

## Initial Priority

1. Customer Journey Revenue Engine과 매출 기여 추적 구축
2. SmartStore·아이디어스·Content·CRM·Review·Analytics Marketing Agent 운영
3. B2B 문의·견적·후속관리 자동화
4. 연구·생산 업무와 Workbench 데이터 고도화
5. GP Workbench에 Campaign, 작업 큐, 승인함, 실행 로그와 KPI 연결
6. 원가·생산·매출·고객 데이터 연결
7. 내부 AI·OS 적용 효과 측정과 외부 상품 후보 검증
8. 대표 의존도와 자산 소유권을 포함한 양도가능성 관리
