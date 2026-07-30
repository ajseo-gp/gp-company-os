# SOP-015 운영 데이터 백업·복원

- 상태: ACTIVE
- 버전: 1.0
- 소유자: GP Company CEO
- 담당: Workbench Operator, Claude Code, Recovery Custodian
- 변경일: 2026-07-30
- 적용 범위: `DEC-0016`이 적용되는 GP Workbench와 운영 저장소의 백업·복원

## 목적

운영 데이터의 누락 없는 암호화 백업, 독립 사본, 불변 보관, 관측과 실제 복원 검증을
반복 가능한 절차로 수행한다.

## 입력 정보

- 정확한 40자리 `OS-Ref`와 `DEC-0016`
- Data Protection Manifest revision
- Dataset ID·Owner·등급·원본의 비민감 참조
- RPO·RTO와 보존기간
- 회사 소유 백업 A와 불변·오프라인 백업 B의 목적지 참조 ID
- Secret Manager의 key reference와 Recovery Custodian 역할
- 실행 Task/Run ID, 허용 범위와 금지 범위

실제 키, 고객정보, 처방·함량, 원가·단가와 credential은 작업 요청·로그·Issue·PR에
입력하지 않는다.

## 실행 단계

### 1. Preflight

1. `OS-Ref`, Manifest revision, 실행 저장소 revision과 승인 범위를 고정한다.
2. 기존 실행의 중복 여부와 마지막 성공·실패·복원 Evidence를 확인한다.
3. 원본을 읽기 전용으로 inventory하고 Manifest와 대조한다.
4. 미등록 데이터셋, 등급 미확정, 원본 접근권한 불명은 `COVERAGE_FAILED`로 중단한다.
5. 목적지의 회사 귀속, MFA, 최소 권한, 감사·버전·불변 설정을 확인한다.
6. key reference와 최소 2명의 Recovery Custodian 등록 상태를 값 노출 없이 확인한다.

### 2. 안전한 Snapshot 생성

1. 애플리케이션이 제공하는 일관된 snapshot 방법을 우선한다.
2. 파일 복사 방식이면 쓰기 중 상태와 부분 파일을 피하도록 원자적 snapshot 또는
   검증된 quiesce 방법을 사용한다.
3. Dataset별 파일 수·크기·checksum과 전체 Manifest revision을 기록한다.
4. 인증자료는 일반 운영 데이터와 분리된 `RESTRICTED-AUTH` 세트로 만든다.
5. Secret Store에서 재조달할 수 있는 token·API Key·인증서·복구코드는 일반 snapshot에
   포함하지 않는다.

### 3. 암호화와 무결성

1. 검증된 도구의 authenticated encryption을 사용하고 자체 암호 알고리즘을 만들지 않는다.
2. 원본 호스트를 떠나기 전에 암호화와 인증 tag 생성을 완료한다.
3. 평문 임시 파일은 최소화하고 성공·실패 후 안전하게 제거한다.
4. 암호화 결과의 checksum과 최소 1건의 복호화 표본을 검증한다.
5. 키, nonce 재사용 위험, 임시 평문 또는 민감한 파일명이 로그에 남지 않게 한다.

### 4. 독립 사본 전송

1. 백업 A를 회사 Business Cloud 계정으로 전송하고 수신 checksum·버전·감사 이벤트를
   확인한다.
2. 백업 B를 별도 실패 도메인의 불변 저장소로 전송하고 retention lock/object lock의
   만료 시각을 확인한다.
3. 임시 오프라인 매체를 사용하면 Operator가 연결·복사·checksum 확인 후 분리하고
   보관 위치 참조와 다음 갱신일을 기록한다.
4. 같은 동기화 그룹의 여러 복제본을 중복 사본으로 계산하지 않는다.
5. 각 목적지의 positive acknowledgement 전에는 실행을 `COMPLETED`로 표시하지 않는다.

### 5. 보존과 정리

1. 시간별 7일, 일별 90일, 월별 12개월과 불변 일별 35일·월별 12개월을 적용한다.
2. 법정 보존기간 미확정 문서와 restore 검증에 사용 중인 snapshot은 자동 삭제하지 않는다.
3. 보존기간 만료 정리는 Dataset ID·snapshot ID·목적지·예상 삭제량의 dry-run을 먼저
   만들고 승인 범위 안에서만 실행한다.
4. 개인 계정 평문 사본 정리는 암호화 사본과 격리 복원 통과 후 별도 승인 작업으로 한다.

### 6. 관측과 알림

실행 결과를 `CREATED`, `UNCHANGED`, `FAILED`, `COVERAGE_FAILED`,
`BACKUP_BLOCKED`로 구분한다.

비민감 실행 기록에는 다음을 남긴다.

- Task/Run ID, OS-Ref, Manifest와 실행 revision
- 시작·종료 시각, Dataset·파일 수·크기와 checksum 판정
- 암호화·백업 A·백업 B·불변 보관의 PASS/FAIL
- 마지막 성공과 복원 검증 시각
- 실패 단계, 영향받은 Dataset ID와 안전한 재개 조건

중요 데이터의 2회 연속 실행 누락, 사본 수 미달, 불변 사본 실패, coverage 차이 또는
checksum 불일치는 같은 운영 경로에 즉시 알린다. `UNCHANGED`는 정상 실행으로 기록하되
전송할 새 snapshot이 없다는 점을 분리한다.

### 7. 복원 검증

1. 월 1회 무결성·복호화·표본 복원을 자동 또는 수동 검증한다.
2. 분기 1회와 저장구조·암호화 방식의 중대한 변경 후에는 격리 환경 전체 복원을 수행한다.
3. 실제 production을 덮어쓰지 않고 합성 또는 격리된 경로로 복원한다.
4. 원본 application의 읽기·record count·참조 무결성과 필요한 인증 재조달 절차를 확인한다.
5. 사용한 사본, key reference, 실행자·Reviewer, 소요시간, RPO·RTO 충족과 오류를 기록한다.
6. 복원 검증에 실패한 사본은 성공 백업 수에서 제외하고 `BACKUP_BLOCKED`로 처리한다.

## 승인 필요 지점

- 신규 Cloud·불변 저장소·Secret Manager 또는 계정 귀속 변경
- 암호화 방식, 키 Custodian, 보존기간과 RPO·RTO 변경
- 실제 고객·처방·원가·인증 데이터로 최초 범위 확대
- production 원본을 덮어쓰는 복원
- 기존 평문 사본·계정·키의 삭제 또는 폐기
- 기준 밖 비용, 계약 또는 법률·규정 판단

Issue #12와 `DEC-0016`은 회사 소유 목적지·사전 암호화·키 분리·checksum Gate 안의
연구비 금액표 첫 백업을 승인한다. 다른 `RESTRICTED` 데이터로의 자동 확대는 승인하지 않는다.

## 출력물

- 버전 관리되는 Data Protection Manifest와 schema
- 비민감 backup run·coverage·destination acknowledgement 기록
- 월별 표본 복원과 분기별 전체 복원 Evidence
- 실패·누락·사본 미달 알림과 재개 조건
- 키 rotation·Custodian 변경의 비밀값 없는 감사 기록
- Task-ID, OS-Ref, 구현 revision, 테스트·rollback과 보호 영역 영향 기록

## 실패·예외 처리

| 조건 | 처리 |
|---|---|
| Manifest 미등록 데이터 발견 | `COVERAGE_FAILED`, 해당 Dataset 확대 중단 |
| 암호화 또는 checksum 실패 | 외부 전송 금지, 임시 평문 격리·정리 후 실패 보고 |
| 백업 A만 성공 | 완료 아님, B 재시도와 최소 사본 미달 알림 |
| 불변 설정 확인 실패 | 완료 아님, 일반 Cloud 복제본으로 대체 계산 금지 |
| 목적지 인증·용량 실패 | credential 노출 없이 목적지·시각·오류 유형과 재개 조건 기록 |
| 키 접근 실패 | 별도 키 생성으로 우회 금지, Recovery Custodian 경로로 복구 |
| 두 Custodian 모두 접근 불가 | `BACKUP_BLOCKED`, CEO Co-Operator에 복구 권한 재설정 요청 |
| 복원 검증 실패 | 해당 사본을 유효 사본 수에서 제외하고 새 snapshot 생성·원인 분석 |
| 개인 Cloud 평문 발견 | 범위 확대 중단, 새 암호화 사본 검증 전 삭제 금지 |
| Git에 운영 데이터 암호문 발견 | 추가 push 중단, 노출 범위·history·key 영향 평가 후 별도 정리 |

## 보안과 감사

- 실제 원본 값, 키, 계정 ID, 전체 경로와 credential을 OS·GitHub·Slack에 기록하지 않는다.
- 운영 데이터 처리 테스트는 합성 또는 비식별 fixture를 기본으로 한다.
- 백업 실행 권한과 복원 권한을 분리하고 최소 권한을 사용한다.
- 모든 Evidence는 Dataset ID와 checksum 판정만 남기며 원문을 첨부하지 않는다.

## 관련 문서와 근거

- Decision: `../DECISIONS/DEC-0016_OPERATIONAL-DATA-BACKUP-RECOVERY.md`
- Decision: `../DECISIONS/DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`
- Decision: `../DECISIONS/DEC-0012_AI-WORK-ALLOCATION.md`
- Security: `../../SECURITY.md`
- Context: `../CONTEXT/WORKBENCH-RESEARCH-PRODUCTION-ALIGNMENT.md`
- Workflow: Workbench 운영 데이터 보호 반복 업무. 전사 상태 흐름 확장 시 별도 Workflow로 등록
- Evidence: `https://github.com/ajseo-gp/gp-company-os/issues/12`
