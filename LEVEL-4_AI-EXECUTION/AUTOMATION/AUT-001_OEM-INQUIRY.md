# AUT-001 OEM 문의 자동 분류

- 상태: PLANNED
- 우선순위: P1
- 소유자: OEM Owner
- 구현 위치: 미정
- 버전: 0.2

## Purpose

신규 OEM 문의의 필수 정보를 구조화하고 누락·유형·위험을 수동 검토 큐에 일관되게 전달한다.

## Related Workflow and SOP

- `../WORKFLOW/WF-001_INQUIRY-TO-ORDER.md`
- `../../LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-001_OEM-INQUIRY.md`
- `../AGENTS/AGENT-OEM-INTAKE.md`

## Trigger

승인된 Form 또는 이메일 연동에서 고유 메시지 ID를 가진 신규 문의를 수신할 때

## Inputs and Validation

- 원문의 권한 있는 참조와 채널 메시지 ID
- 고객 메타데이터의 허용된 최소 범위
- 수신 시각과 동의·보존 정책

원문 접근권한, 중복 메시지 ID와 필수 입력 스키마를 먼저 검증한다.

## Processing

정보 추출 → 누락 확인 → 유형·가능성·위험 분류 → 답변 초안 → 수동 검토 큐

## Outputs

구조화 Inquiry, 누락정보, 분류 confidence, 위험, 답변 초안과 안전한 원문 참조 ID

## Authority and Approval

자동 외부 발송, 가격·납기·생산 가능성 확정은 금지한다. 승인된 담당자가 검토한 뒤에만
고객에게 발송한다.

## Idempotency, Retry and Timeout

채널과 원본 메시지 ID 조합으로 중복 생성을 방지한다. 재시도 전 기존 Inquiry와 처리
상태를 조회한다. timeout은 수동 검토 큐로 보낸다.

## Failure, Rollback and Manual Handoff

원문을 변경하지 않고 실패 사유와 부분 추출 결과를 수동 검토 큐에 등록한다. 잘못 생성된
구조화 기록은 감사 이력을 보존한 정정 절차로 처리한다.

## Audit, Security and Retention

처리시각, 사용 OS·문서 version, 분류 결과·confidence, 승인자와 최종 답변 참조를 기록한다.
고객 원문과 PII를 공개 GitHub·Slack 로그에 복제하지 않는다.

## Activation Criteria

구현 위치, 접근권한, 보존기간, 중복 방지, 분류 평가셋, 수동 인계와 운영 책임자가
검증되기 전에는 ACTIVE로 전환하지 않는다.

## Operating KPI

필수정보 추출 정확도, 잘못된 위험 분류율, 중복 Inquiry 생성률, 수동 수정률과 처리시간
