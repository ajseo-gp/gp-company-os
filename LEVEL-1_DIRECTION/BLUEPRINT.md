# GP Company OS Blueprint

**Status:** ACTIVE  
**Version:** 0.1

## System Flow

```text
Mission / Vision
      ↓
Business Strategy
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

## Design Rules

- 모든 Agent는 최소 1개의 SOP를 참조해야 한다.
- 모든 Automation은 입력, 출력, 승인 지점, 실패 처리 기준을 가져야 한다.
- 모든 KPI는 실제 의사결정과 연결되어야 한다.
- 모든 반복 이슈는 SOP 또는 Knowledge 갱신 후보가 된다.
- 중요한 변경은 Decision Record를 생성한다.

## Initial Priority

1. 전체 문서 체계 구축
2. OEM 문의·견적 업무 표준화
3. B2C 콘텐츠 생산 체계화
4. 주간 리뷰와 CEO 리뷰 정착
5. 원가·생산·매출 데이터 연결
6. 자동화 Agent 도입
