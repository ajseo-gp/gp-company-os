# DEC-0016 운영 데이터 백업·복구와 암호화 키 관리

- 상태: ACTIVE
- 결정일: 2026-07-30
- 적용일: 2026-07-30
- 결정자/소유자: GP Company CEO
- 정책 Steward: Codex
- 적용 범위: GP Workbench와 운영 저장소의 고객·연구·원료·견적·생산·매출·접근 데이터
- 승인 근거: GitHub Issue `ajseo-gp/gp-company-os#12`의 2026-07-30 대표 지시
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

`gpcompany-lab`의 2026-07-30 점검에서 Workbench 백업 대상이 회사 정책이 아니라
`*.jsonl` 확장자 패턴으로 결정되고, 연구비 금액표·로그인 계정·업로드 자산·일부
인증자료가 기존 스냅샷에서 누락됐다고 보고됐다. 기존 사본은 대표 개인 Microsoft
계정의 한 동기화 그룹에 있어 삭제·계정 침해·랜섬웨어에 대한 독립 사본으로 볼 수 없고,
성공·실패·복원 가능성도 외부에서 관측되지 않는다.

대표는 Issue #12에서 백업 이중화와 보안을 기본 요건으로 확정하고, 두 번째 사본 위치,
Money Firewall의 암호문 예외 여부와 복구 권한·키 수명은 Codex가 OS 정책으로 정한 뒤
Claude Code가 별도 실행 저장소에서 구현하도록 지시했다.

## 결정

### 1. 백업 대상은 명시적 Data Protection Manifest가 정한다

1. 파일 확장자, 폴더 glob 또는 구현 편의가 백업 대상을 결정하지 않는다.
2. 각 운영 데이터 저장소는 최소한 다음을 가진다.
   - 안전한 Dataset ID와 Owner
   - 원본 위치의 비민감 참조
   - 데이터 등급
   - 백업 포함·제외와 이유
   - RPO·RTO
   - 보존기간
   - 복원 순서와 의존성
3. 신규 데이터 저장소는 Manifest 등록, 백업 dry-run과 복원 검증이 없으면 완료로
   판정하지 않는다.
4. Manifest와 실제 파일·데이터셋의 차이는 백업 성공이 아니라 `COVERAGE_FAILED`다.

### 2. 데이터 등급과 암호화 범위

| 등급 | 예시 | 백업 기준 |
|---|---|---|
| `RESTRICTED` | 고객 식별·연락·사업자정보, 처방·함량, 원료·연구비·원가·견적, 계정·권한 기록, 식별 가능한 접근 로그 | 원본 호스트를 떠나기 전에 인증된 암호화, 최소 권한, 별도 키 관리 필수 |
| `CONFIDENTIAL` | 비식별 매출·품질·운영 집계, 내부 산출물·미공개 미디어 | 운영 백업 아카이브에 포함되면 동일하게 암호화 |
| `REPRODUCIBLE` | 비밀 없는 코드·스키마·설정 템플릿·합성 테스트 데이터 | Git 또는 승인된 재현 경로 사용 가능; 운영 데이터 백업 사본 수에는 포함하지 않음 |

혼합 아카이브는 가장 높은 등급을 따른다. 운영 데이터 백업 아카이브는 등급과 무관하게
기본적으로 암호화한다.

토큰·API Key·인증서·복구코드와 원문 비밀번호는 일반 데이터 아카이브에 섞지 않고
회사 Secret Store에서 관리한다. 서비스 복구에 필요한 계정 메타데이터와 비밀번호
검증자는 별도 `RESTRICTED-AUTH` 백업 세트로 분리하고 일반 운영 데이터보다 좁은 권한을
적용한다.

### 3. 최소 사본과 실패 도메인

1. 최소 기준은 **원본 1부 + 백업 2부**다.
2. 백업 2부는 서로 독립된 실패 도메인에 두며 최소 1부는 불변 또는 오프라인이어야 한다.
3. 같은 동기화 그룹, 같은 계정의 폴더 복제와 여러 기기에 보이는 동일 동기화본은
   합쳐서 백업 1부로 계산한다.
4. 기본 배치는 다음과 같다.
   - 백업 A: 회사 도메인에 귀속된 Business Cloud 계정. 업로드 전 암호화, MFA,
     최소 권한, 열람·공유 감사와 버전 관리 필수
   - 백업 B: 별도 계정·Provider의 retention lock/object lock 등 자동 불변 저장소
5. 자동 불변 저장소를 즉시 사용할 수 없으면 암호화한 분리형 매체를 임시 대체로
   사용할 수 있다. 담당 Operator가 연결·복사·검증 후 분리하며 대표를 정기 실행
   주체로 두지 않는다.
6. 개인 계정은 전환 중 임시 원천으로만 인정하고 신규 정식 목적지로 사용하지 않는다.

### 4. 암호화 아카이브도 Git 저장소에는 두지 않는다

Money Firewall은 평문뿐 아니라 암호화된 운영 데이터 아카이브에도 적용한다.
공개·비공개를 불문하고 Git 저장소에 고객·처방·원가·계정 등 운영 데이터의 암호문을
커밋하지 않는다.

암호화가 기밀성을 낮추더라도 Git은 복제·fork·history·credential과 보존 수명이
백업 정책과 분리되어 있고, 키 유출 시 과거 전체 history가 노출될 수 있다. 따라서
암호문을 Money Firewall의 예외로 인정하지 않는다. Dataset ID, checksum, manifest
revision, 성공 시각과 비민감 Evidence만 Git 또는 OS에 기록할 수 있다.

### 5. 키 보관, 복구 권한과 교체

1. 복호화 키는 회사 소유 Business Password Manager 또는 Secret Manager에 보관하고
   백업 데이터의 Cloud 계정·폴더와 같은 위치에 두지 않는다.
2. 백업 실행 호스트는 최소 권한의 로컬 Keychain 또는 권한이 제한된 runtime secret을
   사용한다. 키를 저장소, 동기화 폴더, 로그, Slack, Issue, PR, Preview나 checkpoint에
   기록하지 않는다.
3. 최소 2명의 명시된 Recovery Custodian이 대표 부재 시에도 키를 복구할 수 있어야 한다.
   초기 역할은 `CEO`와 `지정 Recovery Custodian`이며 실제 인물은 보안 권한표에만
   기록하고 공개 OS에는 이름을 남기지 않는다.
4. `RESTRICTED` 실제 복원은 실행자 1명과 독립 Reviewer 1명의 이중 통제로 승인·기록한다.
5. 키는 12개월마다 또는 노출 의심, Custodian 변경·퇴사, 저장소·암호화 방식 변경 시
   즉시 교체한다.
6. 정상 교체 때 과거 아카이브를 일괄 재암호화하지 않는다. 이전 키는 해당 아카이브의
   마지막 보존기간과 복원 검증이 끝날 때까지 별도 보존한 뒤 폐기한다.
7. 키 노출이 의심되면 새 키 발급, 새 백업 생성, 영향 범위 격리와 아직 보존해야 하는
   과거 아카이브의 재암호화 또는 조기 폐기를 보안 검토로 결정한다.

### 6. 보존, 복구 목표와 검증

기본 운영 기준은 다음과 같다.

| 항목 | 기본값 |
|---|---|
| 중요 운영 데이터 RPO | 최대 1시간 |
| 중요 운영 데이터 RTO | 8시간 |
| 시간별 복원점 | 7일 |
| 일별 복원점 | 90일 |
| 월별 복원점 | 12개월 |
| 불변 복원점 | 일별 35일 + 월별 12개월 |
| 자동 무결성·복호화 표본 검사 | 월 1회 |
| 격리 환경 전체 복원 리허설 | 분기 1회 및 저장구조·암호화 방식의 중대한 변경 후 |

법률·세무·계약·품질 문서의 법정 보존기간은 이 기본값으로 단축하지 않는다. 해당 기간은
별도 법률·재무·품질 근거가 확인될 때까지 `미확인`으로 두며, 확인 전 자동 삭제하지 않는다.

### 7. 관측되지 않거나 복원되지 않은 백업은 성공이 아니다

각 실행은 `CREATED`, `UNCHANGED`, `FAILED`를 구분하고 다음 비민감 Evidence를 남긴다.

- Task/Run ID, Manifest revision과 실행 주체
- 시작·종료 시각과 원천 기준시각
- Dataset 수, 파일 수, 총 크기와 checksum 검증 결과
- 암호화 완료와 각 목적지의 수신 확인
- 독립 사본 수와 불변 사본 상태
- 마지막 복원 검증 시각·사용 사본·결과

중요 데이터의 두 연속 실행이 없거나, 최소 사본·불변 사본·Manifest coverage 중 하나가
기준 미달이면 `BACKUP_BLOCKED`로 보고한다. 데이터 무변경은 성공 실행의
`UNCHANGED`이며 실행 자체가 없거나 목적지 확인이 실패한 상태와 구분한다.

### 8. 전환과 즉시 보호

1. 연구비 금액표는 현재 사본 0개로 보고됐으므로 우선 보호 대상이다. 회사 소유 목적지,
   사전 암호화, 분리된 키와 checksum 검증이 준비되면 이 파일만 먼저 백업할 수 있다.
2. 첫 연구비 금액표 백업은 Issue #12의 대표 지시와 이 Decision 범위 안의 승인된
   전환 작업으로 본다. 고객·처방·인증 데이터로 범위를 자동 확대하지 않는다.
3. 기존 개인 OneDrive 평문 스냅샷은 새 암호화 사본과 복원 검증이 끝날 때까지 임의로
   삭제하지 않는다. 이후 삭제·계정 이관은 별도 목록·rollback 불가 영향·승인 기록을
   가진 전환 작업으로 수행한다.
4. 7일 안에 연구비 금액표와 Manifest 기반 암호화 백업 A를 검증하고, 14일 안에 불변
   백업 B와 첫 격리 복원 Evidence를 완료 목표로 한다.

## 이유

회사 운영 데이터는 매출·생산·고객 대응을 재개하기 위한 핵심 자산이다. 개인 계정과
대표의 수작업에 의존하는 백업은 대표가 바뀌어도 인수 가능한 회사라는 Mission Test를
통과하지 못한다. 암호화, 독립 실패 도메인, 불변 사본과 복원 검증을 함께 적용하면
단일 장비·계정·동기화 오류와 랜섬웨어가 동시에 원본과 사본을 무력화할 가능성을 줄인다.

암호문을 Git 예외로 인정하면 자동화는 쉬워지지만 Money Firewall의 단순하고 검증 가능한
경계가 깨지고 장기 history의 노출면이 커진다. 백업 수명·삭제·접근 통제를 제공하는
회사 소유 저장소를 사용해 정책과 구현을 분리하는 편이 안전하다.

## 영향 범위

### 적용

- GP Workbench와 `gpcompany-lab` 운영 데이터
- 백업 예약·암호화·복사·관측·복원 자동화
- 회사 Cloud·Secret Store·불변 저장소의 귀속과 권한
- 신규 운영 데이터 저장소의 완료 Gate
- Money Firewall의 백업·export 경로

### 비적용

- 이 Decision은 고객·처방·원가 원문을 OS나 Git에 저장할 권한을 주지 않는다.
- 운영 데이터의 분석·수정·삭제 권한을 새로 부여하지 않는다.
- 법정 보존기간을 확정하지 않는다.
- 백업 성공만으로 production migration·삭제·복원 실행을 자동 승인하지 않는다.
- `gp-company-os`가 실제 키, 계정명, 원본 경로 또는 민감 데이터를 보관하지 않는다.

## 전환과 검증

1. `SOP-015`의 Manifest·암호화·목적지·복원 Gate를 `gpcompany-lab` 구현에 반영한다.
2. 기존 `*.jsonl` glob과 실제 운영 데이터셋을 대조해 누락 목록을 비민감 ID로 만든다.
3. 합성 데이터로 아카이브 생성·키 분리·복호화·복원·오류 알림을 검증한다.
4. 연구비 금액표를 최소 범위로 먼저 보호하고 checksum·복호화 표본 Evidence를 남긴다.
5. 불변 사본과 격리 복원 통과 후에만 전체 `RESTRICTED` 데이터로 확대한다.
6. Claude Code는 `DEC-0012`에 따라 실행 저장소의 코드·설정·테스트를 소유하고,
   Codex는 이 Decision·SOP와 색인의 정합성을 검증한다. 같은 branch를 공동 소유하지 않는다.

성공 기준은 Manifest coverage 누락 0건, 최소 사본 미달 0건, 평문 Cloud 신규 업로드 0건,
Git 운영 데이터 암호문 0건, 정해진 복원 리허설 누락 0건과 첫 복원 성공이다.

## 재검토 조건

- 백업 또는 키에서 고객정보·처방·원가·인증정보 노출이 발생할 때
- 복원 실패, 원본과 백업 checksum 불일치 또는 불변 사본 삭제가 발생할 때
- 운영 저장소가 JSONL에서 DB·managed storage로 변경될 때
- Business Cloud·Secret Manager·불변 저장소 Provider가 변경될 때
- 데이터 규모가 현재 보존 주기·비용 상한을 크게 초과할 때
- 법률·세무·계약·품질 보존기간이 확인될 때

## Evidence와 관련 문서

- Issue Evidence: `https://github.com/ajseo-gp/gp-company-os/issues/12`
- Direction: `../../LEVEL-1_DIRECTION/MISSION.md`, `../../LEVEL-1_DIRECTION/VISION.md`
- Security: `../../SECURITY.md`
- Decision: `DEC-0007_WORKBENCH-CLOSED-BETA-FAST-LANE.md`,
  `DEC-0012_AI-WORK-ALLOCATION.md`
- SOP: `../SOP/SOP-015_OPERATIONAL-DATA-BACKUP-RESTORE.md`
- Context: `../CONTEXT/WORKBENCH-RESEARCH-PRODUCTION-ALIGNMENT.md`
- External Evidence:
  - CISA `#StopRansomware Guide`: offline·encrypted backup, regular restore testing,
    immutable storage and cloud-to-cloud separation
  - NIST SP 800-34 Rev. 1: contingency planning, recovery strategy, testing and maintenance
  - NIST SP 800-57 Part 1 Rev. 5: independent secure key backup, key recovery and compromise handling
