# GP Company Agent Architecture

- 문서 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 작성일: 2026-07-23
- 다음 검토일: 2026-10-23

## Architecture Principle

Agent는 조직도를 복제하는 챗봇 목록이 아니다. 각 Agent는 검증된 Workflow와 SOP의
책임 단위를 실행하는 역할 계약이다.

```text
CEO
  ↓ 방향·예산·정책·예외 승인
CEO Co-Operator
  ↓ 우선순위·의사결정 준비
Hermes Primary
  ↓ 작업 분해·라우팅·증거 연결
Domain Agents
  ↓ Revenue Growth Team · OEM · Customer · R&D · Production · Finance
Steward Agents
  ↓ Knowledge · Automation
Workbench / GitHub / Secure Operational Systems
```

CEO Co-Operator는 대표를 대체하지 않고 판단 자료를 준비한다. Hermes는 오케스트레이터이며
도메인 정책을 만들지 않는다. Domain Agent는 승인된 업무를 수행하고, Steward Agent는
지식 품질과 자동화 안전성을 통제한다.

`DEC-0009`에 따라 Marketing은 현재 단계의 예외다. 단일 범용 Agent로 축소하지 않고
Customer Journey·채널·KPI가 명확한 전문 Agent 팀으로 구성한다. 단, 세분화 자체가 목적이
아니며 Revenue 기여와 인계가 없는 역할은 만들지 않는다.

## Runtime States

| 상태 | 의미 |
|---|---|
| PLANNED | 역할 후보이며 실행체가 없다 |
| PILOT | 사람의 밀착 검수 아래 제한적으로 사용한다 |
| ACTIVE | 구현, 권한, 로그, 실패 처리와 소유자가 검증되었다 |
| PAUSED | 운영 사용을 중지했다 |
| RETIRED | 신규 작업을 받지 않는 역사 역할이다 |

## Agent Register

| Agent | 책임 | Runtime | 명세 |
|---|---|---|---|
| CEO Co-Operator | 우선순위·충돌·승인안·경영 리뷰 준비 | PLANNED | `AGENT-CEO-COOPERATOR.md` |
| Hermes Primary | 요청 식별, OS-Ref 고정, 라우팅, 상태·증거 연결 | ACTIVE | `AGENT-HERMES.md` |
| OEM Intake | B2B/OEM 문의 구조화와 누락·위험 분류 | PLANNED | `AGENT-OEM-INTAKE.md` |
| Content | 승인된 브랜드·표현 기준의 콘텐츠 초안 | PLANNED | `AGENT-CONTENT.md` |
| Marketing Growth Team | Journey·채널별 고객·매출·기여이익 성장 | PLANNED | `AGENT-MARKETING-GROWTH-TEAM.md` |
| R&D | 연구 Brief·레시피 상태·검증 근거 관리 | PLANNED | `AGENT-RND.md` |
| Production | 확정 레시피·수주·LOT·생산문서 제어 | PLANNED | `AGENT-PRODUCTION.md` |
| Knowledge Steward | Evidence를 Context·Knowledge·SOP 후보로 분류·검증 | PLANNED | `AGENT-KNOWLEDGE-STEWARD.md` |
| Customer | 문의·불만·재구매 인계와 고객 Insight 후보 생성 | PLANNED | SOP 설계 후 생성 |
| Finance | 견적 원가 검증, 현금흐름·수익성 리포트 준비 | PLANNED | Finance SOP 승인 후 생성 |
| Automation Steward | 자동화 적합성·권한·실패·감사 계약 검수 | PLANNED | Automation 운영 SOP 승인 후 생성 |

명세 파일이 없는 PLANNED 역할은 권한도 실행 계약도 없다. 이름만으로 Agent를 생성하거나
라우팅하지 않는다.

## Planned Role Contracts

| 역할 | 입력 | 출력 | 필수 참조 | 승인·한계 | 관계 |
|---|---|---|---|---|---|
| Customer | 고객 요청, 주문·응대 이력의 안전한 참조 | 답변 초안, 다음 행동, INSIGHT 후보 | 고객 SOP, 브랜드 Knowledge | 외부 발송·보상·환불 승인 | OEM·Content·Knowledge로 인계 |
| Finance | 승인된 견적 입력, 비용·매출의 권한 있는 집계 | 마진 검토, 현금흐름 경보, KPI | Finance, 견적 SOP, Decision | 가격·결제·회계 확정 금지 | OEM·CEO Co-Operator에 검토 결과 |
| Automation Steward | Workflow·SOP·위험·시스템 계약 | 자동화 적합성, 활성화 Gate, 감사 결과 | AI Policy, Security, Automation register | 운영 활성화·권한 확대 승인 필요 | Hermes·Domain Agent·시스템 소유자와 검증 |

## Handoff Rules

1. 모든 작업은 `Task-ID`와 가능한 경우 40자리 `OS-Ref`를 가진다.
2. Agent 간 인계에는 입력 출처, 상태, 완료 조건, 금지 범위와 승인 상태를 포함한다.
3. 수신 Agent는 상위 Agent의 추론을 사실로 재사용하지 않고 원본 근거를 확인한다.
4. 외부 발송, 가격·계약, 생산 확정과 비가역 실행은 해당 승인 Gate를 통과한다.
5. 결과는 Workbench·GitHub 또는 승인된 운영 시스템의 감사 기록에 연결한다.
6. 새 학습은 Knowledge Steward가 Evidence와 적용 범위를 검토한 뒤 승격한다.

## Activation Gate

Runtime을 ACTIVE로 전환하려면 모두 충족해야 한다.

- 소유자와 대리 책임자
- 연결된 ACTIVE Workflow와 SOP
- 최소 권한과 Human 승인 지점
- 입력·출력 스키마와 민감정보 경계
- 실패, timeout, 재시도와 수동 인계
- 감사 로그와 KPI
- 합성 또는 비식별 데이터 기반 테스트
- CEO 또는 위임된 승인권자의 활성화 승인
