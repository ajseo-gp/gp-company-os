# WF-002 Content Engine

- 상태: ACTIVE
- 소유자: Marketing Owner
- 적용 사업: Hair & Scalp B2C / GP Company
- 버전: 0.3
- 변경일: 2026-07-26
- Learning-Ref: DEC-0011

## Purpose

검증된 고객 질문과 사업 목표를 브랜드·표현 기준에 맞는 콘텐츠로 만들고 성과를 다음
실험과 Knowledge에 환류한다.

## Trigger and Completion

- Trigger: WF-006에서 승인된 Campaign Brief 또는 예외 승인된 우선 콘텐츠 요청
- 완료: 게시·성과 기준일·학습 후보가 기록되거나 취소 사유가 기록됨

## Flow

```text
고객 질문·리뷰 수집
→ 주제 후보 생성
→ 월간 우선순위 선정
→ 채널별 콘텐츠 초안
→ 브랜드·표현 검수
→ 게시 승인
→ 게시
→ 성과 수집
→ Prompt와 Knowledge 개선 후보
```

## Roles and Systems

| 구간 | 책임 | 관련 문서 |
|---|---|---|
| 목표·우선순위 | Marketing Owner | `../../LEVEL-2_BUSINESS/MARKETING.md` |
| 초안 제작 | Content Agent | `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-005_CONTENT-PRODUCTION.md` |
| 브랜드·표현 검수 | Content Agent / 승인자 | Brand·Claims Knowledge |
| 게시 승인·실행 | 채널 Owner | 채널 권한 정책 |
| 성과·학습 | Marketing / Knowledge Steward | KPI·Knowledge Contract |

## Approval and Exceptions

외부 게시, 광고비 사용, 신규 Claim, 비교·의학적 표현과 위기 대응은 승인받는다. 근거가
불명확한 표현은 제외하며 마감 때문에 임의로 확정하지 않는다.

## Related SOP

- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-005_CONTENT-PRODUCTION.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`
- `WF-006_REVENUE-GROWTH-LOOP.md`

## Knowledge Feedback

L1/L2 Task는 실행 전에 관련 ACTIVE Knowledge·최근 EXPERIMENT·FAILURE를 읽고
Learning Preflight를 남긴다. Outcome 이후 `WF-008`로 학습 후보·Enforcement Point와
다음 Reuse Verification을 연결한다.

실험의 가설·기간·채널·결과를 연결한다. 단일 콘텐츠 성과를 보편적 Best Practice로
승격하지 않는다.

## KPI

- Brief→초안 리드타임
- 승인 전 수정률과 표현 오류율
- 채널별 목표 행동
- Experiment 완료율과 재사용 가능한 학습 수
