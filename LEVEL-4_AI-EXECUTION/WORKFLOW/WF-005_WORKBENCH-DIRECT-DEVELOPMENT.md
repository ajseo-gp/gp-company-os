# WF-005 Workbench Direct Development

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 변경일: 2026-07-22

## 목적

Workbench Closed Beta 피드백을 Hermes의 일반 업무 큐와 분리해 로컬 Claude Code가 빠르게
구현하고, 위험에 따라 자체 Release 또는 사람 승인을 수행한다.

## 흐름

```mermaid
sequenceDiagram
    participant U as 대표·연구원
    participant S as Workbench Slack
    participant B as gpwb_bot
    participant C as Local Claude Code
    participant G as GitHub·Deploy
    participant P as Workbench Production

    U->>S: 자연어 피드백·이미지
    S->>B: 요청 이벤트
    B->>B: Task-ID·OS-Ref·위험등급 생성
    B->>C: 요청 맥락·완료 조건 전달
    C->>G: branch 구현·검증
    alt WB-LOW
        C->>G: 자체 승인·merge·deploy
    else WB-MEDIUM 또는 WB-HIGH
        C->>S: 변경 영역 Preview·영향·승인 요청
        U->>S: 자연어 승인 또는 수정 요청
        B->>C: 구조화된 승인 또는 재작업
        C->>G: 승인 범위 merge·deploy
    end
    G->>P: Production 반영
    C->>P: smoke test
    B->>S: 운영 URL·PC/모바일 변경 영역·검증 결과
```

## 불변 조건

- Hermes는 이 흐름의 필수 중계자나 Release gate가 아니다.
- 사람에게 기계 태그, Task-ID, OS-Ref 또는 SHA 입력을 요구하지 않는다.
- 로컬 Claude Code 인증이 없으면 별도 과금 API로 자동 전환하지 않는다.
- `WB-LOW`만 자체 승인한다. 중위험·고위험을 편의상 낮춰 분류하지 않는다.
- 실패한 배포는 성공으로 보고하지 않으며 rollback 또는 안전 차단 상태를 함께 알린다.

## 관련 문서

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-009_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
