# GP Company OS v1.0 Architecture Review

- 상태: ACTIVE
- 검토 기준일: 2026-07-23
- 검토 대상: `gp-company-os` branch `codex/research-production-alignment`
- 목적: 현재 구조의 v1.0 준비도와 GP Company OS v2.0 확장 경로를 평가한다.

## Executive Verdict

현재 저장소는 Mission → Business → Operating Knowledge → AI Execution → Management
Control의 방향이 명확하고, 일반적인 회사 위키보다 훨씬 강한 운영 뼈대를 갖고 있다.
특히 Decision 우선, SOP 우선 자동화, OS-Ref, Human Preview와 연구–생산 추적 원칙은
AI Native Company의 핵심 통제에 적합하다.

다만 검토 시점의 기준선은 아직 `v0.3.0`이며 v1.0 운영 준비 완료로 선언하기에는 이르다.
가장 큰 이유는 폴더 구조가 아니라 문서 유형별 필수 계약의 불균일, Context·Knowledge의
얇은 검증 메타데이터, Agent 명세와 실제 Runtime의 혼동, 저장소 간 적용 revision drift,
그리고 기준선에 문서 정합성을 자동 검증하는 체계가 없었다는 점이다.

이번 개선은 폴더를 대규모 재배치하지 않고 다음 기반을 추가했다.

- 단일 AI 진입점 `SYSTEM_BOOT.md`
- 저장소 전체 AI 작업 규칙 `AGENTS.md`
- README의 Mission·Vision·Repository Map·AI Onboarding·OS 철학
- `OS-INDEX.yaml`의 Boot sequence·유형별 계약·레지스트리
- Context·Decision·Knowledge·Workflow·SOP·Prompt·Automation 경계
- Agent Architecture, Runtime 상태와 표준 Agent 명세
- 신규 Agent·Workflow·Automation·Knowledge 템플릿

### Revenue First Addendum — 2026-07-23

CEO의 `DEC-0009`에 따라 Architecture 일관성은 Guardrail로 유지하되 실행 우선순위는
Revenue Engine → Marketing Agent → B2B Automation → R&D/Production → Company OS
외부 상품화로 변경한다. Marketing은 단일 범용 Agent로 제한하지 않고 Customer Journey,
채널, KPI와 인계가 명확한 전문 Agent 팀으로 설계한다.

## 1. Current Repository Architecture Assessment

| 영역 | 기준선 평가 | 이번 개선 후 | 남은 핵심 과제 |
|---|---|---|---|
| Direction | 강함 | 유지 | 연 1회 Mission/Vision 검토 |
| Business | 양호 | 유지 | 신규 브랜드·사업 scope metadata |
| Context | 부분 충족 | 경계·Map 추가 | 기준일·근거·검토일 마이그레이션 |
| Decisions | 양호 | 계약·Register 강화 | DEC-0001~0008 메타데이터 보완 |
| Knowledge | 취약 | 유형·근거 계약 추가 | 실제 Lesson/Failure/Experiment 축적 |
| Workflow | 양호 | 상태·SOP·Agent 계약 강화 | 기존 5개 표준 필드 마이그레이션 |
| SOP | 혼재 | Workflow 경계 명시 | 초기 SOP 001~006 필드 보완 |
| Prompt | 부분 충족 | 비권위·평가 원칙 추가 | Prompt version과 평가 기록 |
| Agents | 취약 | Architecture·Runtime 분리 | 계획 Agent의 SOP·권한 검증 |
| Automation | 양호한 설계 | 활성화 조건 강화 | 구현 증거·운영 책임자 연결 |
| Management | 양호한 골격 | Review 문서 추가 | 실제 데이터·목표값·결정 연결 |
| AI Onboarding | 취약 | Boot·Index·AGENTS·CI 추가 | 기존 문서 metadata 마이그레이션 |

## 2. Structural Problems

### P0 — Authority and Execution Risk

1. `ACTIVE` Workflow와 `PLANNED` Automation이 나란히 있어 AI가 실제 실행 가능성을
   오인할 수 있었다.
2. Agent 문서에 역할·입력·출력·참조·권한·관계가 일관되게 존재하지 않았다.
3. Context와 Knowledge에 출처, 기준일, 적용 범위와 만료 조건이 부족했다.
4. `REVIEW` 상태인 연구·생산 Decision을 실행 기준처럼 사용할 위험이 있다.
5. OS·Hub·Workbench가 서로 다른 OS revision을 적용할 수 있지만 drift를 중앙에서
   자동 차단하지 않는다.

### P1 — Maintainability

1. 문서별 상태·소유자·버전·검토일 표기가 불균일하다.
2. Workflow와 SOP의 상세 단계가 중복될 가능성이 있다.
3. Decision 초기 문서가 현재 템플릿의 영향·전환·재검토 필드를 모두 갖지 않는다.
4. `FILE-MANIFEST.txt`는 수동 생성 파일이라 실제 트리와 쉽게 달라진다.
5. `START-HERE.md`와 README가 AI 진입 순서를 중복 정의했다.

### P2 — Learning and Scale

1. Lessons Learned, Failure, Experiment, Customer Insight가 명시적 지식 유형으로 축적되지
   않았다.
2. 브랜드·사업·지역이 늘어날 때 적용 범위를 표현하는 공통 metadata가 없다.
3. 기준선에는 문서 링크, ID 중복, 상태·필드 계약을 검증하는 CI가 없었다.
4. KPI가 정의되어 있지만 목표값·원천 데이터·결정 Owner와의 연결이 약하다.

## 3. Improvement Proposal

### Adopt Now

- `SYSTEM_BOOT.md`를 유일한 의미적 AI 진입점으로 사용한다.
- `OS-INDEX.yaml`을 기계 탐색용 계약으로 사용하고 README는 사람·AI 공통 지도로 유지한다.
- 기존 5-Level Architecture는 유지한다. 현재 규모에서 최상위 폴더를 Business,
  Knowledge 등으로 다시 평면화하면 오히려 권위와 실행 레이어가 흐려진다.
- 모든 문서에 `scope`, `owner`, `status`, `review_date`와 관련 ID를 점진적으로 추가한다.
- Agent의 문서 상태와 Runtime 상태를 분리한다.
- Knowledge는 원본 파일이 아니라 검증된 주장·근거·적용 범위를 저장한다.

### Complete Before v1.0

- 기존 Decision·Context·SOP metadata 마이그레이션 후 CI 필수 계약 범위 확대
- 하위 저장소가 소비 중인 40자리 `OS-Ref`와 관련 Decision을 보고하는 compatibility manifest
- Context·Knowledge review date 만료 알림
- Workflow ↔ SOP ↔ Agent ↔ Automation ↔ KPI traceability report
- secure Evidence Register: 이메일·OneDrive·Workbench 원본의 안전한 ID, 유형, 검증자,
  제품/LOT scope, 보존·접근 등급만 OS와 연결

## 4. Documents to Add

### Added in This Review

- `SYSTEM_BOOT.md`
- `AGENTS.md`
- `LEVEL-4_AI-EXECUTION/AGENTS/AGENT-ARCHITECTURE.md`
- R&D·Production·Knowledge Steward Agent 명세
- Agent·Workflow·Automation·Knowledge templates
- Boot 경로·링크·ID·실행 문서 계약·File Manifest 검증 CI
- 이 Architecture Review

### Required Before v1.0

- `EVIDENCE-REGISTER.md`: 보안 원본의 metadata와 검증 상태
- `TRACEABILITY-REPORT.md`: 핵심 Workflow의 양방향 연결 검사 결과
- `COMPATIBILITY-MATRIX.yaml`: OS·Hub·Workbench 적용 revision과 Decision
- `DOCUMENT-LIFECYCLE.md`: review, deprecation, archive와 retention 운영 절차
- `SOP-DATA-GOVERNANCE.md`: 운영 데이터 정정·보존·접근·삭제 금지 절차

실제 생산 이메일과 처방 원문은 위 문서에 복사하지 않는다.

## 5. Documents to Delete or Integrate

| 문서 | 권고 | 이유 |
|---|---|---|
| `START-HERE.md` | 당장은 유지, v1.0에서 README Human Quick Start로 통합 검토 | 기존 링크를 보존하면서 AI Boot 중복 제거 |
| `FILE-MANIFEST.txt` | CI 생성 artifact로 전환 후 수동 원본 삭제 | 실제 파일 트리와 drift 가능 |
| `AI.md`와 `MEMORY.md` | 유지 | AI 행동정책과 기억 lifecycle은 책임이 다름 |
| Context의 브랜드·사업별 신규 파일 | 무분별한 추가 금지 | Level 1·2·Knowledge 원본을 Map으로 참조 |
| 개별 Agent 파일 | Runtime 또는 설계 Gate가 생길 때만 추가 | 이름뿐인 Agent 증식 방지 |

즉시 삭제는 하지 않았다. 참조와 하위 저장소 영향 확인 없이 문서를 제거하면 AI
온보딩과 고정 SHA 재현성을 깨뜨릴 수 있기 때문이다.

## 6. Problems from an AI Perspective

- 최초 진입점이 README와 START-HERE로 나뉘어 있었다.
- 상태가 없는 문서를 AI가 ACTIVE 사실로 해석할 수 있다.
- 디렉터리 이름만으로 Workflow와 SOP의 상세 수준을 구분하기 어렵다.
- Agent 명세와 실제 실행체 존재 여부가 분리되지 않았다.
- Knowledge에 근거·신뢰·scope가 없으면 특정 제품·기간의 사실을 과도하게 일반화한다.
- 다른 저장소의 현재 상태를 로컬 문서만 보고 최신이라고 추정할 위험이 있다.
- Prompt가 정책보다 우선하는 것처럼 재사용될 수 있다.

`SYSTEM_BOOT.md`, `AGENTS.md`, 유형 계약과 Runtime 상태 분리는 위 오해를 줄이지만,
CI 기반 구조 검증과 Evidence 연결이 있어야 지속적으로 유지된다.

## 7. Long-term Operating Risks

- 대표 승인 대기열이 병목이 될 수 있으므로 정책 내 가역 실행과 예외 승인 범위를 수치로
  정의해야 한다.
- 문서가 늘수록 Owner와 review date 없는 ACTIVE 문서가 오래된 정책으로 남을 수 있다.
- 신규 브랜드별로 구조를 복제하면 SOP·Knowledge가 분기되어 학습이 단절된다.
- Agent 수를 조직도처럼 늘리면 라우팅 비용과 책임 공백이 커진다.
- 내부 검증 없이 AI/OS를 외부 상품화하면 두 번째 수익 엔진의 신뢰를 훼손한다.
- 보안 원문과 공개 정책 저장소의 경계가 무너지면 처방·원가·고객정보가 노출될 수 있다.

## 8. Recommended Repository Tree

```text
gp-company-os/
├── SYSTEM_BOOT.md
├── AGENTS.md
├── README.md
├── OS-INDEX.yaml
├── SECURITY.md
├── LEVEL-1_DIRECTION/
│   ├── MISSION.md
│   ├── VISION.md
│   ├── MANIFEST.md
│   └── BLUEPRINT.md
├── LEVEL-2_BUSINESS/
│   ├── BUSINESS.md
│   ├── HAIR-SCALP-BUSINESS.md
│   ├── AI-COMPANY-OS-BUSINESS.md
│   └── <domain policies>
├── LEVEL-3_OPERATING-KNOWLEDGE/
│   ├── CONTEXT/
│   ├── DECISIONS/
│   ├── KNOWLEDGE/
│   ├── SOP/
│   └── PROMPT-LIBRARY/
├── LEVEL-4_AI-EXECUTION/
│   ├── AI.md
│   ├── MEMORY.md
│   ├── AGENTS/
│   ├── WORKFLOW/
│   └── AUTOMATION/
├── LEVEL-5_MANAGEMENT-CONTROL/
│   ├── KPI.md
│   ├── DASHBOARD.md
│   ├── ROADMAP.md
│   ├── ARCHITECTURE-REVIEW-v1.0.md
│   ├── WEEKLY-REVIEW/
│   └── CEO-REVIEW/
├── TEMPLATES/
└── .github/
```

브랜드·사업이 늘어도 우선 `scope` metadata와 Business 문서를 추가한다. 동일한 SOP와
Knowledge를 공유할 수 없는 명확한 규제·권한·운영 차이가 생길 때만 하위 domain 폴더를
분리한다.

## 9. Recommended Agent Architecture

권장 구조는 `CEO → CEO Co-Operator → Hermes → Domain/Steward Agents`다.

- **CEO:** Mission, 예산, 정책, 예외와 비가역 결정
- **CEO Co-Operator:** 결정 준비·우선순위·경영 리뷰
- **Hermes:** OS-Ref 고정, 라우팅, 상태와 증거 연결
- **Marketing Growth Team:** SmartStore·아이디어스·Content·CRM·Review·Revenue Analytics로
  Customer Journey와 매출·기여이익 실행
- **OEM/Customer/R&D/Production/Finance:** 도메인 SOP 실행
- **Knowledge Steward:** Evidence 검증과 회사 기억 lifecycle
- **Automation Steward:** 자동화 활성화·권한·실패·감사 Gate

상세 입력·출력·참조·권한·관계와 Runtime은
`../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-ARCHITECTURE.md`에서 정의한다.

## 10. GP Company OS v2.0 Roadmap

### Phase 0 — v1.0 Authority Baseline

- CEO Validation P1 결정 확정
- REVIEW Decision·SOP의 승인 또는 명시적 보류
- 기존 문서 필수 metadata 마이그레이션
- 링크·YAML·ID·필수 필드 CI
- OS release tag와 compatibility manifest

**Exit:** 어떤 AI도 동일 OS-Ref에서 같은 권위 문서와 승인 Gate를 찾는다.

### Phase 1 — Revenue Engine

- Acquisition→Activation→Conversion→Retention→Referral Journey
- Campaign-ID·채널·제품·비용·주문·매출 Evidence
- SmartStore·아이디어스 별도 Revenue view
- 직접 매출·기여 매출·기여이익과 CEO Weekly Revenue Review

**Exit:** 모든 Marketing Campaign이 Journey·비용·매출·결과 Decision에 연결된다.

### Phase 2 — Marketing Agent Runtime

- Growth Orchestrator, SmartStore, Idus, Content, CRM, Review, Revenue Analytics Agent
- KPI 원천·산식·기준선·목표·Owner·승인 Gate
- Revenue Snapshot·Readout·Campaign Brief 자동화
- 한 Campaign의 수동 병행 PILOT과 Knowledge 환류

**Exit:** Marketing Agent가 매출 루프를 실행하고 대표의 마케팅 병목시간을 줄인다.

### Phase 3 — B2B Automation

- Inquiry→Qualification→Quotation→Follow-up Pipeline
- 문의 자동분류, 후속 연락과 계약 매출 연결
- 최소 마진·결제·승인 기준
- Workflow↔SOP↔Agent↔KPI traceability

**Exit:** B2B 문의부터 계약·후속까지 상태·매출·Owner와 Evidence가 연결된다.

### Phase 4 — R&D and Production

- cs@gentlepapa.com 생산 자료 read-only inventory와 secure Evidence ID
- Inquiry→R&D→Quotation→Order→Production→Delivery 상태
- Recipe Research Dossier와 recipe revision·sample·LOT
- R&D·Production Agent PILOT과 Workbench 정합성

**Exit:** 수주 매출을 안전하게 생산·납품·재발주로 전환하며 추적성을 유지한다.

### Phase 5 — External AI & Company OS Product

- 내부 적용 전후 시간·오류·매출·대표 의존도 근거
- 고객별 설정과 GP Company 핵심 IP 분리
- 보안·권한·감사·데이터 처리 제품 기준
- 반복 가능한 도입·교육·운영·지원 패키지

**Exit:** 내부에서 매출·시간·오류 효과가 검증된 시스템만 외부 제품·서비스로 판매된다.

## v1.0 Release Gate

다음을 모두 충족하기 전에는 저장소 이름과 무관하게 운영상 v1.0 완료로 선언하지 않는다.

- P0 충돌과 CEO Validation P1 처리
- SYSTEM_BOOT와 OS-INDEX 정합성 검사 통과
- ACTIVE Decision·Workflow·SOP·Agent의 Owner와 review date
- 핵심 Workflow 양방향 traceability
- 민감정보 scan과 secure Evidence 경계
- 하위 저장소 compatibility manifest
- Weekly Review에서 최소 2회 실제 사용·개선 증거
