# Knowledge Base

회사의 검증된 사실, 제조 노하우, 고객 지식, 브랜드 표현 기준을 저장한다.

추측 또는 임시 의견은 Knowledge가 아니라 Context의 검토 항목으로 저장한다.

## Knowledge Contract

Knowledge에는 지식 ID와 유형, 상태, 소유자, 검토일, 주장, 근거, 신뢰 수준, 적용 범위,
적용 제외 범위와 관련 운영 문서가 있어야 한다.

검증 근거가 없는 의견은 Knowledge로 승격하지 않는다. 특정 제품·LOT·시험성적서의 결과를
근거 없이 다른 제품이나 기간에 일반화하지 않는다.

## Knowledge Types

| 유형 | 목적 | 파일 접두어 |
|---|---|---|
| FACT | 검증된 회사·제품·제조 사실 | `FACT-` |
| LESSON | 반복 업무에서 얻은 교훈 | `LESSON-` |
| PRACTICE | 재현성이 확인된 Best Practice | `PRACTICE-` |
| FAILURE | 실패 조건, 영향과 재발 방지 | `FAILURE-` |
| EXPERIMENT | 마케팅·제품·운영 실험과 결과 | `EXPERIMENT-` |
| INSIGHT | 반복 고객 요구와 행동 패턴 | `INSIGHT-` |

현재의 설명형 파일은 그대로 유지한다. 신규 지식부터 위 ID 체계를 적용하고, 기존 파일은
근거가 확인될 때 점진적으로 등록한다.

## Current Register

| 문서 | 유형 | 상태 | 보완 필요 |
|---|---|---|---|
| `COMPANY-PROFILE.md` | FACT | ACTIVE | 근거·검토일 |
| `GENTLEPAPA-BRAND.md` | HISTORICAL POINTER | ARCHIVED | 현재 Canon은 `gp-company-hub/brands/gentlepapa` 및 DEC-0019 참조 |
| `CUSTOMER-SEGMENTS.md` | INSIGHT | 미표시 | 근거·상태 |
| `COSMETIC-CLAIMS-GUIDE.md` | PRACTICE | ACTIVE | 법규 검토일·출처 |
| `MANUFACTURING-CAPABILITY.md` | FACT | REVIEW | 생산 근거·책임자 |
| `PRACTICE-0001_SMARTSTORE-OPERATING-GUIDE.md` | PRACTICE | REVIEW | 첫 Campaign 성과·CEO 승인 |

신규 문서는 `../../TEMPLATES/KNOWLEDGE-TEMPLATE.md`를 사용한다.

## Revenue Knowledge Loop

모든 Revenue Campaign은 Evidence와 `SCALE`, `ITERATE`, `STOP` 결과를 남긴다.

- 단일 Campaign: `EXPERIMENT`
- 반복 재현된 성공: `PRACTICE` 후보
- 실패 조건·비용·재발 방지: `FAILURE`
- 반복 고객 행동·요구: `INSIGHT`

매출이 증가했다는 사실만으로 원인을 확정하지 않는다. Campaign-ID, 기간, 채널, 제품,
대상, 비용, attribution 기준, 적용 범위와 제외 범위를 함께 보존한다.
