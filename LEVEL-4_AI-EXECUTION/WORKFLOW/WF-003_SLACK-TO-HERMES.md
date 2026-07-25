# WF-003 Slack to Hermes

- 상태: ACTIVE
- 버전: 1.1
- 소유자: GP Company CEO
- 변경일: 2026-07-26
- Learning-Ref: DEC-0011

## 목적

Slack 요청부터 OS 기준 확인, 실행, 검토 종료까지 하나의 `Task-ID`와 스레드로 추적한다.

## Trigger and Completion

- Trigger: GPcompany Slack의 권한 있는 채널에 신규 자연어 요청이 접수됨
- 완료: 결과·증거·예외가 보고되고 요청자가 Review를 닫거나 명시적으로 취소함

## 흐름

```mermaid
sequenceDiagram
    participant R as 요청자
    participant S as GPcompany Slack
    participant H as Hermes Primary
    participant O as gp-company-os
    participant W as Worker·Workbench·GitHub

    R->>S: 자연어 요청·첨부·제약
    S->>H: Primary에 단일 전달
    H->>H: Task-ID·OS-Ref·승인등급 자동 생성
    H->>S: 자연어 접수 또는 BLOCKED
    H->>O: 지정 SHA를 gh api로 읽기
    O-->>H: Decision · Context · SOP · Knowledge
    H->>W: Task-ID · OS-Ref · 권한 · 출력 계약 전달
    W-->>H: 결과 · 증거 · 예외
    H->>S: RESULT
    opt 사람이 사용하는 개발 결과
        H->>S: PREVIEW:READY
        R->>S: 자연어 승인 또는 수정 요청
        H->>H: 승인 의도와 revision 구조화
        S->>H: WF-004 자동 Release 또는 재작업
    end
    R->>S: REVIEW:CLOSED
```

## 상태 모델

| 상태 | Slack 표식 | 다음 상태 |
|---|---|---|
| `REQUESTED` | `[WORK_REQUEST]` | `ACKNOWLEDGED`, `BLOCKED` |
| `ACKNOWLEDGED` | `[ACK]` | `RUNNING`, `BLOCKED` |
| `RUNNING` | `[STATUS]` | `RESULT_REPORTED`, `BLOCKED` |
| `RESULT_REPORTED` | `[RESULT]` | `PREVIEW_READY`, `UNDER_REVIEW`, `CLOSED` |
| `PREVIEW_READY` | `[PREVIEW:READY]` | `UNDER_REVIEW`, `HUMAN_APPROVED` |
| `HUMAN_APPROVED` | `[HUMAN:APPROVED]` | WF-004 `RELEASE_VALIDATING` |
| `UNDER_REVIEW` | `[REVIEW]` | `RUNNING`, `RESULT_REPORTED`, `CLOSED` |
| `BLOCKED` | `[BLOCKED]` | `RUNNING`, `CLOSED` |
| `CLOSED` | `[REVIEW:CLOSED]` | 종료 |

## 불변 조건

- 하나의 `Task-ID`는 하나의 제어 스레드만 가진다.
- 하나의 작업에는 하나의 Hermes Primary만 응답한다.
- ACK 이후 RESULT까지 `OS-Ref`를 변경하지 않는다.
- Worker가 바뀌어도 `Task-ID`, `OS-Ref`, 승인등급과 안전 제약은 유지한다.
- Slack, Workbench, GitHub의 상태가 다르면 실행을 계속하기 전에 불일치를 기록·해소한다.
- `CLOSED` 작업은 새 `Task-ID` 또는 명시적 재개 승인 없이 다시 실행하지 않는다.
- 사람에게 Task-ID, OS-Ref, 상태 태그 또는 SHA 입력을 요구하지 않는다.
- `DEC-0007`의 Workbench Fast Lane은 `WF-005`를 사용하고 이 흐름에 중복 등록하지 않는다.

## 예외 흐름

- `OS-Ref` 오류: `BLOCKED` → 수정된 요청 검증 → `RUNNING`
- 추가 검증: `RESULT_REPORTED` → `UNDER_REVIEW` → `RUNNING` → 새 `RESULT`
- Primary 장애: 현재 실행과 부작용 확인 → 승인된 전환 → Standby가 같은 상태·증거를 인계
- Slack 장애: Workbench·GitHub에 상태 보존 → 연결 복구 → 원래 스레드에 동기화

## Knowledge Feedback

Hermes는 L1/L2 Task Envelope에 관련 ACTIVE Knowledge·최근 EXPERIMENT·FAILURE,
적용·비적용 이유와 Outcome 완료 조건을 넣는다. 결과는 `WF-008`의 학습 검토와 다음
Reuse Verification으로 인계한다.

반복되는 라우팅 오류, 승인 병목과 실패 조건은 FAILURE 또는 SOP 개선 후보로 전달한다.
Slack 원문과 비밀정보는 Knowledge에 복제하지 않는다.

## KPI

- ACK·첫 상태 보고 시간
- OS-Ref 누락·불일치율
- 중복 실행과 잘못된 라우팅률
- BLOCKED 해소시간과 증거 연결률

## 관련 문서

- `../../LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS/DEC-0005_HERMES-SLACK-ORCHESTRATION.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-007_HERMES-SLACK-ORCHESTRATION.md`
- `../AGENTS/AGENT-HERMES.md`
- `../../TEMPLATES/HERMES-WORK-REQUEST.md`
- `WF-004_PREVIEW-TO-RELEASE.md`
- `WF-005_WORKBENCH-DIRECT-DEVELOPMENT.md`
