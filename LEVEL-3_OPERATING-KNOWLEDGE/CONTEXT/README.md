# Context

현재 회사 상태, 진행 프로젝트, 제약조건, 우선순위를 기록한다. Context는 변경될 수 있으므로 날짜와 검토 주기를 표시한다.

## Context와 다른 문서의 경계

- **Context:** 현재 사실, 제약, 우선순위, 진행 상태와 아직 검증 중인 가정
- **Decision:** 대표가 승인한 선택과 그 이유
- **Knowledge:** 반복 사용 가능한 수준으로 근거와 범위가 검증된 사실·교훈
- **Memory Policy:** AI와 시스템이 무엇을 장기 보존할지 정하는 규칙

Context는 정책을 새로 만들지 않는다. 현재 상태가 기존 Decision과 충돌하면 Decision을
조용히 덮어쓰지 말고 충돌을 표시해 재결정을 요청한다.

## Required Fields

- 상태, 소유자
- 기준일(`as_of`)과 다음 검토일
- 적용 범위
- 확인된 사실
- 미확인 가정 또는 제약
- 원본 근거 또는 안전한 참조 ID
- 관련 Decision·Workflow·SOP

## Context Map

| 영역 | 현재 원본 |
|---|---|
| 회사 정체성·핵심 제약 | `COMPANY-CONTEXT.md` |
| 현재 우선순위 | `CURRENT-PRIORITIES.md` |
| 프로젝트 상태 | `PROJECT-REGISTER.md` |
| 브랜드 철학 | `../KNOWLEDGE/GENTLEPAPA-BRAND.md` |
| 제품·Hair/Scalp 전략 | `../../LEVEL-2_BUSINESS/HAIR-SCALP-BUSINESS.md` |
| OEM·B2B 정책 | `../../LEVEL-2_BUSINESS/OEM.md` |
| B2C 운영 | `../../LEVEL-2_BUSINESS/B2C.md` |
| 마케팅 방향 | `../../LEVEL-2_BUSINESS/MARKETING.md` |
| 연구·생산 현재 정합성 | `WORKBENCH-RESEARCH-PRODUCTION-ALIGNMENT.md` |
| 대표 의사결정 원칙 | `../../LEVEL-1_DIRECTION/MANIFEST.md`, `../../LEVEL-4_AI-EXECUTION/AI.md` |

위 표는 중복 Context 파일을 만들기보다 해당 주제의 현재 원본을 찾기 위한 지도다.
