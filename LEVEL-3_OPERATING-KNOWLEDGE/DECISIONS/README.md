# Decision Log

대표가 확정한 운영 원칙과 중요한 변경을 저장한다. Decision은 다른 문서보다 우선한다.

`ACTIVE` Decision만 운영 권한을 가진다. `REVIEW`와 `DRAFT`는 제안 또는 검토 근거이며,
실행 기준으로 단정하지 않는다. 새 Decision은 `../../TEMPLATES/DECISION-TEMPLATE.md`를
사용한다.

## Required Fields

- ID, 상태, 결정일, 결정자/소유자
- 배경과 해결할 문제
- 결정 내용과 선택 이유
- 영향 범위와 명시적 비적용 범위
- 전환·검증 방법
- 재검토 조건
- 대체하거나 대체되는 Decision
- 관련 Business·Context·Workflow·SOP·Agent·KPI

## Register

| ID | 제목 | 상태 | 주요 영향 |
|---|---|---|---|
| DEC-0001 | GP Company OS 5-Level Architecture | ACTIVE | 전체 저장소 |
| DEC-0002 | 회사 문서 우선 원칙 | ACTIVE | AI·문서 권위 |
| DEC-0003 | 소량 OEM 운영 방향 | REVIEW | OEM |
| DEC-0004 | GP Company 이중 수익 엔진 전략 | ACTIVE | 사업·KPI |
| DEC-0005 | Hermes–Slack 오케스트레이션과 OS-Ref 고정 | ACTIVE | Hermes·Workflow |
| DEC-0006 | Human Preview 승인 후 자동 Release | ACTIVE | Release |
| DEC-0007 | GP Workbench Closed Beta Fast Lane | ACTIVE | Workbench |
| DEC-0008 | 연구·견적·생산 제어 경계 | REVIEW | R&D·생산 |
| DEC-0009 | Revenue First 운영 우선순위 | ACTIVE | Revenue Engine·Marketing·KPI |
| DEC-0010 | Targeted Knowledge Refresh | ACTIVE | AI 조사범위·주간/월간 지식 갱신·토큰 비용 |
| DEC-0011 | Evidence-to-Improvement Organizational Learning | ACTIVE | 전사 사전 학습·결과 포착·운영계약 반영·재사용 검증 |
| DEC-0012 | Codex–Claude Code 역할 분리 | ACTIVE | Codex 정책·문서, Claude Code 개발·데이터·API 구현 |

초기 Decision 중 필수 메타데이터가 없는 문서는 내용을 추정해 채우지 않고, 다음 재검토
때 신규 템플릿으로 마이그레이션한다.
