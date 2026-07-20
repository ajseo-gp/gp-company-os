# GP Company OS

**Version:** 0.1.0  
**Status:** Initial Operating Baseline  
**Owner:** GP Company CEO  
**Purpose:** GP Company를 사람이 반복 업무에 매몰되지 않고, AI와 사람이 함께 운영하며, 회사 지식이 지속적으로 축적되는 AI Native Company로 전환한다.

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

## Primary Business Context

GP Company는 다음 영역을 동시에 운영한다.

- 소량 화장품 OEM/ODM
- 자체 브랜드 젠틀파파 운영
- 두피·헤어·바디케어 제품 기획 및 제조
- B2B 거래처 개발과 B2C 온라인 판매
- 콘텐츠 마케팅
- AI 기반 업무 자동화
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
- 가격, 원가, 거래처 개인정보 등 민감정보는 공개 저장소에 기록하지 않는다.
