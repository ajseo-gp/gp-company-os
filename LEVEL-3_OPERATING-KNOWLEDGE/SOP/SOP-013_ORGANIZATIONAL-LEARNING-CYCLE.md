# SOP-013 Organizational Learning Cycle

- 상태: ACTIVE
- 버전: 1.0
- 소유자: Knowledge Steward / GP Company CEO
- 적용 Workflow: WF-008 Organizational Learning Loop
- 적용 Decision: DEC-0011
- 작성일: 2026-07-25
- 다음 검토일: 2026-08-26
- 적용 범위: 전사 반복 Task와 L1/L2 학습 기록
- Learning-Ref: DEC-0011

## 목적

과거 학습을 실행 전에 소비하고, 실제 결과에서 새 학습을 검증하며, 다음 실행 계약과
재사용 확인까지 닫는 표준 수행법을 정의한다.

## 적용 범위

- L1 반복 업무
- L2 Revenue·고객·품질·비용·규제·생산·고위험 업무
- 반복 실패와 대표의 반복 지시
- Marketing·B2B/OEM·R&D·Production·Workbench·AI/OS 개선

저위험 일회성 L0 Task는 결과·예외만 기록할 수 있다. 단, 위험·반복성을 낮춰 분류한
근거를 숨기지 않는다.

## 입력 정보

- Task-ID, 가능한 경우 Campaign-ID와 40자리 OS-Ref
- 목적, 완료 조건, Domain·Customer Journey와 L0/L1/L2 등급
- 예상 Revenue·고객·품질·비용·대표 병목 기여
- 관련 ACTIVE Decision·Context·SOP·Knowledge
- 비교 가능한 최근 EXPERIMENT·FAILURE·INSIGHT
- 기준선·가설·Guardrail·측정일·Owner·원천
- 승인 범위와 금지 범위
- 원본 Evidence 저장소와 안전한 참조 방식

필수 입력이 없으면 추정해 채우지 않고 `LEARNING_SCOPE_BLOCKED` 또는
`BASELINE_PARTIAL`로 표시한다.

## 실행 단계

### 1. 학습 등급과 비교 단위 결정

Task의 반복성, Revenue·고객·규제·생산 영향, 실패 비용과 대표 병목을 검토해 L0/L1/L2를
정한다. L2는 비교할 채널·제품·고객 Segment·업무 유형과 기간을 고정한다.

### 2. Learning Preflight

실행 전에 관련 ACTIVE Knowledge와 최근 비교 가능한 EXPERIMENT·FAILURE를 읽는다.

- 이번 Task에 적용할 항목
- 적용하지 않을 항목과 이유
- 충돌·만료·미확인
- 예상되는 개선과 반증 조건

검색 결과가 없으면 `NO_APPLICABLE_KNOWLEDGE`로 남기고 임의의 회사 사실을 만들지 않는다.

### 3. 실행 계약 고정

목표·기준선·가설·변수·Guardrail·승인·실제 결과 측정일과 Evidence 원천을 고정한다.
여러 변수를 동시에 바꾸면 원인 분리가 불가능함을 표시한다.

### 4. 승인 범위에서 실행

Domain SOP와 승인 Gate를 따라 실행하고 실제 revision, 시각, 비용, 예외, 중단과 고객
영향을 원본 시스템에 남긴다.

### 5. Outcome 포착

예상과 실제, 성공·실패·무효·부작용과 데이터 품질을 분리한다. 직접 관측, attribution,
상관관계와 해석을 구분한다. 결과가 나중에 발생하면 다음을 필수로 남긴다.

- 상태: `RESULT_PENDING`
- 측정 Owner와 대리자
- 측정일·원천·완료 조건
- 그 전까지 금지되는 성과 주장과 확대

### 6. 학습 분류

- 단일 실행과 결과: EXPERIMENT
- 반복 재현된 방법: PRACTICE 후보
- 실패 조건·영향·재발 방지: FAILURE
- 반복 고객 행동·요구: INSIGHT
- 반복 업무에서 얻은 일반 교훈: LESSON

새로운 재사용 가치가 없으면 근거와 함께 `NO_NEW_LEARNING`을 기록한다.

### 7. Evidence 검증

원본 권위, 기준시각, 적용 범위, 제외 범위, 검증자, 다른 설명과 민감정보를 확인한다.
근거가 부족하면 `EVIDENCE_BLOCKED`; 결과가 상충하면 `CONFLICT_REVIEW`로 둔다.

### 8. Enforcement Point 지정

검증된 학습을 저장할 위치와 함께 다음 소비 계약을 지정한다.

- 어떤 Domain·Task·Agent가 읽는가
- 어떤 SOP·Prompt·Agent·Workflow·Automation field가 강제하는가
- 소비 파일의 정확한 경로, 학습 ID 역참조 또는 필수 조회 marker
- 적용 시작 revision과 적용 제외 조건
- Owner, 승인자와 다음 검토일

소비자가 없거나 대상 파일에 역참조가 실제로 반영되지 않은 Knowledge는 완료가 아니라
`UNBOUND_KNOWLEDGE`다. 승인 revision의 CI는 대상 파일 존재, 학습 ID·marker와 상태를
검사한다.

### 9. 운영 계약 변경

기존 문서를 우선 갱신한다. 정책은 Decision, 현재 상태는 Context, 검증된 재사용 지식은
Knowledge, 반복 수행법은 SOP, AI 입력은 Prompt, 역할·인계는 Agent·Workflow 후보로
분류한다. ACTIVE 의미 변경은 정확한 revision으로 승인받는다.

### 10. Reuse Verification

비교 가능한 다음 Task에서 다음을 확인한다.

- Preflight에서 학습을 실제 읽고 적용했는가
- 적용하지 않았다면 승인된 예외가 있는가
- 같은 정의와 범위에서 결과가 어떻게 달라졌는가
- 학습을 유지·축소·승격·보관할 것인가

재사용 전에는 `REUSE_UNVERIFIED`로 두며, 적용 여부만으로 성공을 확정하지 않는다.

### 11. Review와 종료

Weekly Review 또는 Domain Review에 Revenue·운영 성과, 실패 재발, 미측정·미재사용 항목과
다음 행동을 제출한다. 필요한 필드가 없으면 Task를 학습 완료로 닫지 않는다.

## 승인 필요 지점

- L2를 L0/L1으로 하향 분류
- ACTIVE Decision·SOP·Prompt·Agent·Workflow·Automation 의미 변경
- 가격·예산·할인·Claim·외부 발행·고객 발송·생산·법률·규정 판단
- 민감정보와 권한 저장소 접근
- PRACTICE 승격, 적용 범위 확대와 기존 Knowledge 보관
- 학습 자동화의 PILOT·ACTIVE 전환

## 출력물

- Learning Record와 L0/L1/L2 등급
- Learning Preflight
- Outcome 또는 `RESULT_PENDING` 계약
- EXPERIMENT·PRACTICE·FAILURE·INSIGHT·LESSON 후보 또는 `NO_NEW_LEARNING`
- Evidence 검증 상태와 적용·제외 범위
- Enforcement Point와 변경 후보
- Reuse Verification과 유지·축소·승격·보관 판단
- `NO_NEW_LEARNING` 여부와 분모가 되는 전체 검토 Task 수
- 미확인·차단·승인 필요사항

## 실패·예외 처리

- 관련 학습 검색 실패: `NO_APPLICABLE_KNOWLEDGE`, 검색 범위 기록
- 기준선 없음: `BASELINE_PARTIAL`, 개선률 확정 금지
- 결과 원천 없음: `RESULT_BLOCKED`, Owner와 확보 계획 지정
- 결과 지연: `RESULT_PENDING`, 측정일 전 완료·확대 금지
- Evidence 충돌: `CONFLICT_REVIEW`, 낮은 신뢰로 유지
- 소비 계약 없음: `UNBOUND_KNOWLEDGE`, Knowledge 완료 금지
- 다음 실행 없음: `REUSE_UNVERIFIED`, 검증 가능한 시점 지정
- 학습 적용 후 악화: 안전 상태 복귀, 적용 중지와 범위 축소 후보
- 민감정보 발견: 수집·출력 중지, 보안 Owner 인계

## Repository Boundary

- OS: 정책·검증된 Knowledge·SOP·소비 계약
- Hub: Task 등급·Preflight 조회·Context 주입·후보 라우팅
- Workbench: 상태·Owner·측정일·Evidence link·KPI와 재사용 기록
- 운영 저장소: 원본 결과·고객·채널·연구·생산·비용 Evidence

다른 Repository의 구현 여부는 정확한 revision을 확인하기 전까지 추정하지 않는다.

## 관련 문서

- `../DECISIONS/DEC-0011_ORGANIZATIONAL-LEARNING.md`
- `../DECISIONS/DEC-0009_REVENUE-FIRST.md`
- `../DECISIONS/DEC-0010_TARGETED-KNOWLEDGE-REFRESH.md`
- `../../LEVEL-4_AI-EXECUTION/WORKFLOW/WF-008_ORGANIZATIONAL-LEARNING-LOOP.md`
- `../../LEVEL-4_AI-EXECUTION/AGENTS/AGENT-KNOWLEDGE-STEWARD.md`
- `../../TEMPLATES/LEARNING-RECORD-TEMPLATE.md`
