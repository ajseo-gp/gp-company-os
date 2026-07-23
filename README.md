# GP Company OS

**Version:** 0.3.0
**Status:** ACTIVE
**Owner:** GP Company CEO  
**Purpose:** GP Company를 Hair·Scalp 사업과 AI·Company OS 사업이 함께 성장하고, 대표 개인이 아니라 양도 가능한 시스템으로 운영되는 AI Native Company로 전환한다.

## Corporate Direction

GP Company는 두 개의 수익 엔진을 운영한다.

1. **Hair & Scalp Business:** B2B 제조와 B2C 브랜드·커머스를 통해 고객 가치와 현금흐름을 만든다.
2. **AI & Company OS Business:** 내부에서 검증한 OS, Agent, Workflow와 Workbench를 제품과 서비스로 발전시킨다.

`gp-company-os`는 회사의 최상위 전략·정책·Decision 원본이다. 다른 저장소와 실행 시스템은 활성 OS 문서를 기준으로 변경한다.

## Operating Principle

모든 업무는 다음 순서로 판단한다.

1. Mission과 일치하는가?
2. 기존 Decision과 충돌하지 않는가?
3. Context와 맞는가?
4. 기존 SOP가 존재하는가?
5. 자동화 가능한가?
6. 문서화가 필요한가?
7. 새로운 Knowledge가 되는가?

## 5-Level Architecture

| Level | 영역 | 목적 |
|---|---|---|
| LEVEL 1 | Direction | 회사의 존재 이유와 장기 방향 정의 |
| LEVEL 2 | Business | 사업영역별 운영 기준 정의 |
| LEVEL 3 | Operating Knowledge | SOP, 지식, 프롬프트, 결정, 맥락 축적 |
| LEVEL 4 | AI Execution | AI, Agent, Automation, Workflow, Memory 실행 |
| LEVEL 5 | Management Control | Dashboard, KPI, Roadmap, 정기 리뷰를 통한 경영 통제 |

## Company Operating Structure — 회사 운영 구조

GP Company의 목표 운영 구조는 대표가 모든 실행을 직접 지휘하는 방식이 아니다.
대표는 목표·예산·정책과 예외를 승인하고, CEO Co-Operator와 Hermes가 OS를 기준으로
Operator와 전문 실행 Agent를 조율한다. GP Workbench Closed Beta 개발은 별도의 Fast
Lane에서 `gpwb_bot`과 로컬 Claude Code가 직접 처리한다.

```mermaid
flowchart TD
    CEO["CEO · 대표<br/>목표 · 예산 · 정책 승인"]
    OS[("GP Company OS<br/>Mission · Decision · Context · SOP · Knowledge")]
    CO["CEO Co-Operator<br/>OS 확인 · 우선순위 · 실행 기준"]
    H["Hermes<br/>영향 분석 · 업무 분해 · 라우팅"]
    B2C["B2C Growth Operator<br/>전략 · 캠페인 · 배정 · 검수 · 재작업"]
    OPS["담당 Operator<br/>B2B · 콘텐츠 · R&D · AI/OS"]
    EA["Execution Agents<br/>매출 분석 · 고객 인사이트 · 캠페인 · 콘텐츠<br/>커머스 실행 · 화장품 표현/브랜드 QA"]
    WB["GP Workbench<br/>작업 큐 · 진행 상태 · 승인함 · 실행 로그 · KPI"]
    GATE["대표 승인 게이트<br/>승인 · 수정 · 거절"]
    LOOP["운영 학습<br/>Context · Knowledge · SOP · Decision 후보"]

    CEO -->|"승인된 방향"| OS
    OS --> CO
    CO --> H
    H --> B2C
    H --> OPS
    B2C --> EA
    OPS --> EA
    EA -->|"결과 · 증거"| B2C
    EA -->|"결과 · 증거"| OPS
    B2C --> WB
    OPS --> WB
    WB -->|"승인 범위 초과 · 정책 예외 · 차단만"| GATE
    GATE --> CEO
    WB --> LOOP
    LOOP --> OS
```

대표에게는 목표·정책·예산 변경, 외부 공개, 계약, 법률·규정, 고위험·비가역 실행과
기존 기준의 예외처럼 실제 판단이 필요한 항목만 올라간다. 승인된 정책 안의 가역적
업무는 담당 Operator가 검수하고 실행 기록을 남긴다.

## Repository and System Architecture — 저장소·시스템 구조

```mermaid
flowchart TD
    CEO["대표·연구원<br/>자연어·이미지·사업 판단"] --> SLACK["GPcompany Slack"]

    SLACK -->|"회사 운영 요청"| HP["Hermes Primary<br/>Mac mini 2018"]
    OS["gp-company-os<br/>회사 SSOT"] --> HP
    CODEX["Codex<br/>OS · Hub 구현"] --> OS
    HP --> QUEUE["회사 운영 큐<br/>Task-ID · OS-Ref · 상태"]
    QUEUE --> OPS["B2C · B2B · OEM · Marketing Agents"]
    OPS -->|"결과·예외만"| SLACK

    SLACK -->|"Workbench 피드백"| BOT["gpwb_bot"]
    BOT --> CLAUDE["Local Claude Code Max<br/>Workbench 단일 구현자"]
    CLAUDE --> GH["gpcompany-lab<br/>branch · test · release"]
    GH --> WB["GP Workbench Closed Beta"]
    WB -->|"운영 URL·변경 영역 PC/모바일"| SLACK

    HS["MacBook Hermes<br/>비상 대기"] -.장애 시 전환.-> HP
```

| 구성요소 | 역할 |
|---|---|
| [`gp-company-os`](https://github.com/ajseo-gp/gp-company-os) | 회사의 최상위 전략·정책·Decision 원본 |
| [`gp-company-hub`](https://github.com/ajseo-gp/gp-company-hub) | OS를 Hermes·Agent·프로젝트 운영 스펙으로 변환하는 오케스트레이션 레이어 |
| [`gpcompany-lab`](https://github.com/ajseo-gp/gpcompany-lab) 및 프로젝트 저장소 | Workbench 코드와 프로젝트별 실행 산출물 관리 |
| GP Workbench | 작업 큐·상태·승인함·실행 로그·KPI를 연결하는 실행 제어면 |
| Slack | 사람과 Hermes·Agent 사이의 요청·알림·승인 인터페이스 |
| GitHub | Decision·작업 정의·코드·검수 증거를 추적하는 지속 기록 |

세부 역할은 [`LEVEL-2_BUSINESS/B2C.md`](./LEVEL-2_BUSINESS/B2C.md),
[`LEVEL-2_BUSINESS/RND.md`](./LEVEL-2_BUSINESS/RND.md),
[`LEVEL-2_BUSINESS/PRODUCTION.md`](./LEVEL-2_BUSINESS/PRODUCTION.md),
[`LEVEL-4_AI-EXECUTION/AGENTS`](./LEVEL-4_AI-EXECUTION/AGENTS),
[`LEVEL-4_AI-EXECUTION/WORKFLOW`](./LEVEL-4_AI-EXECUTION/WORKFLOW)와
[`LEVEL-5_MANAGEMENT-CONTROL`](./LEVEL-5_MANAGEMENT-CONTROL)을 따른다. 장비 배치와
Hermes 운영 토폴로지는 `gp-company-hub`에서 관리한다.

Hermes 작업은 [`SOP-007`](./LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md)에
따라 자연어 요청을 Task-ID와 40자리 commit SHA의 `OS-Ref`가 포함된 내부 작업으로
변환한다. 사람은 이 값을 입력하지 않는다. Hermes는 로컬 clone이나 현재 브랜치가 아니라
지정 SHA의 Company OS 문서를 읽고 B2C·B2B·OEM·마케팅 업무를 라우팅한다.

사람이 사용하는 기능은 코드 검토만으로 merge하지 않는다. Agent가 동일 revision의
Preview URL과 시각 증거를 제공하고 대표가 Slack에서 승인하면, 해당 revision은 추가
수동 확인 없이 자동 merge·배포·smoke test로 진행한다. 세부 기준은
[`SOP-008`](./LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-008_HUMAN-PREVIEW-AUTOMATIC-RELEASE.md)을
따른다. 단, GP Workbench Closed Beta는
[`DEC-0007`](./LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md)과
[`SOP-009`](./LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md)에
따라 `gpwb_bot`과 로컬 Claude Code가 직접 처리한다. 저위험 변경은 자체 승인·자동
배포 후 변경 영역 PC·모바일 이미지를 보고하고, 중위험·고위험 변경만 사전 Human
Preview를 요구한다.

## Primary Business Context

GP Company는 다음 영역을 동시에 운영한다.

- Hair·Scalp 중심 소량 OEM/ODM
- 자체 브랜드 젠틀파파 운영
- Hair·Scalp 제품 기획·제조·브랜드 운영
- 고객 문의→레시피 연구→견적→생산 LOT와 문서의 추적
- B2B 거래처 개발과 B2C 온라인 판매
- 콘텐츠 마케팅
- AI·Company OS 제품과 서비스 개발
- GP Workbench와 Agent 기반 업무 자동화
- GitHub 기반 회사 지식 관리

## Source of Truth Priority

1. `LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS`
2. `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT`
3. `LEVEL-3_OPERATING-KNOWLEDGE/SOP`
4. `LEVEL-3_OPERATING-KNOWLEDGE/KNOWLEDGE`
5. `LEVEL-3_OPERATING-KNOWLEDGE/PROMPT-LIBRARY`
6. 일반적 AI 지식 또는 외부 정보

외부 정보가 기존 Decision과 충돌하면 대표 승인 전에는 기존 Decision을 유지한다.

## Document Status

각 문서는 다음 상태 중 하나를 사용한다.

- `DRAFT`: 초안, 검토 필요
- `ACTIVE`: 현재 운영 기준
- `REVIEW`: 수정 검토 중
- `ARCHIVED`: 더 이상 사용하지 않음

## Repository Rules

- 임의 추측을 사실처럼 기록하지 않는다.
- 대표가 확정한 사항은 Decision Record로 남긴다.
- 반복 업무는 SOP로 전환한다.
- AI 자동화는 반드시 해당 SOP와 연결한다.
- 다른 저장소와 실행 시스템은 적용한 OS 버전과 관련 Decision을 추적한다.
- 회사의 핵심 코드, 브랜드, 문서, 데이터와 계약의 소유권을 추적 가능하게 관리한다.
- 가격, 원가, 거래처 개인정보 등 민감정보는 공개 저장소에 기록하지 않는다.
