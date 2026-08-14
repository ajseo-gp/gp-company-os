# GP Company OS — System Boot

- 상태: ACTIVE
- 문서 버전: 1.2
- 적용 OS 버전: 0.3.x
- 소유자: GP Company CEO
- 목적: 사람과 AI가 같은 기준·순서·권한으로 GP Company OS를 해석하도록 한다.
- Learning-Ref: DEC-0011
- Direction-Ref: DEC-0014

## 1. 이 저장소의 역할

`gp-company-os`는 GP Company의 Mission, 정책, Decision, 운영 Context, SOP와 AI 실행
계약의 최상위 원본이다. 이 저장소는 고객·처방·원가 같은 운영 원문 데이터베이스가
아니며, 실행 코드 저장소도 아니다.

AI는 모델의 기억이나 일반 지식보다 이 저장소의 고정된 문서를 우선한다. 확인되지 않은
회사의 사실을 보완하거나 추정하지 않는다.

## 2. Boot Sequence

도구가 루트 `AGENTS.md`를 자동으로 먼저 읽을 수 있다. 그것은 저장소 작업 안전규칙이고,
회사의 의미 체계를 이해하기 위한 정식 읽기 순서는 다음과 같다.

1. `SYSTEM_BOOT.md`
2. `README.md`
3. `LEVEL-1_DIRECTION/DIRECTION-SNAPSHOT.md`
4. `LEVEL-1_DIRECTION/MANIFEST.md`
5. `LEVEL-1_DIRECTION/BLUEPRINT.md`
6. 관련 `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT`
7. 관련 `LEVEL-3_OPERATING-KNOWLEDGE/DECISIONS`
8. `AGENTS.md`와 관련 Agent 명세
9. 관련 `LEVEL-4_AI-EXECUTION/WORKFLOW`
10. 관련 `LEVEL-3_OPERATING-KNOWLEDGE/SOP`
11. 관련 `LEVEL-4_AI-EXECUTION/AUTOMATION`
12. 필요한 Knowledge와 Prompt
13. 관련 KPI·Dashboard·Review

모든 작업은 `DEC-0014`에 따라 `D0`·`D1`·`D2` Direction Profile을 자동 분류한다.
`D0`는 Snapshot, `D1`은 Snapshot·`DEC-0009`·관련 운영 문서, `D2`는 여기에 `MISSION.md`와
`VISION.md` 원문을 추가로 읽는다. 같은 세션·같은 OS-Ref에서는 검증된 읽기 checkpoint를
재사용한다. 모든 문서를 무조건 읽지 말고 `OS-INDEX.yaml`에서 필요한 최소 범위를 찾는다.

## 3. Source of Truth

충돌 시 우선순위는 다음과 같다.

1. 대표가 승인한 ACTIVE Decision
2. 적용 시점이 명시된 ACTIVE Context
3. ACTIVE SOP
4. 검증 범위가 명시된 ACTIVE Knowledge
5. Prompt
6. 일반 AI 지식과 외부 정보

상위 문서라도 `DRAFT`, `REVIEW`, `ARCHIVED` 상태이면 확정 운영 기준으로 사용하지 않는다.
같은 우선순위에서는 더 구체적인 적용 범위와 더 최신의 승인 문서를 사용한다. 충돌을
해결할 수 없으면 실행을 확대하지 말고 대표의 Decision이 필요한 항목으로 보고한다.

## 4. 문서 유형 경계

| 유형 | 답하는 질문 | 포함하지 않는 것 |
|---|---|---|
| Business | 무엇으로 고객가치와 수익을 만드는가 | 세부 실행 순서 |
| Context | 지금 회사의 상태·제약·우선순위는 무엇인가 | 영구적 사실로 단정한 미검증 정보 |
| Decision | 무엇을 왜 선택했고 무엇에 영향을 주는가 | 반복 실행 단계 |
| Knowledge | 어떤 사실·교훈이 어떤 근거와 범위에서 검증되었는가 | 임시 상태·개인 의견 |
| Workflow | 여러 역할과 시스템이 어떤 상태를 거쳐 결과를 만드는가 | 한 역할의 상세 작업법 |
| SOP | 한 반복 업무를 어떤 품질·승인 기준으로 수행하는가 | 조직 전체 상태 흐름 |
| Prompt | 승인된 업무를 AI에 어떤 형식으로 요청하는가 | 정책·권한의 신규 정의 |
| Agent | 누가 어떤 입력·권한·출력 계약으로 수행하는가 | 근거 없는 자율 권한 |
| Automation | 어떤 Trigger가 검증된 SOP 단계를 기계 실행하는가 | SOP 없는 업무 정책 |
| Dashboard/KPI | 운영 결과를 무엇으로 측정하고 어떤 결정에 쓰는가 | 원본 운영 데이터 |

## 5. AI Task Boot

AI는 작업을 시작할 때 다음을 수행한다.

1. 가능하면 정확한 40자리 commit SHA를 `OS-Ref`로 고정한다.
2. `DEC-0009`에 따라 신규 고객, 판매, 재구매, 대표의 마케팅 병목 또는 반복 가능한
   성장에 대한 기여 경로를 확인한다.
3. 요청의 사업영역, Customer Journey, Workflow, 위험도와 완료 조건을 식별한다.
4. `DEC-0014`의 Direction Profile을 정하고 필수 방향 문서를 읽는다.
5. 관련 ACTIVE Decision·Context·SOP·Knowledge와 비교 가능한 최근
   EXPERIMENT·FAILURE를 읽고 충돌·만료·적용 범위를 확인한다.
6. `DEC-0011`에 따라 적용한 Knowledge, 적용하지 않은 Knowledge와 이유, 관련 지식이
   없으면 검색 범위를 `Learning Preflight`에 남긴다.
7. 민감정보와 외부 발송·금전·계약·법률·생산 승인 여부를 확인한다.
8. 승인 범위 안에서만 실행하고, 결과에 사용 문서·Evidence와 예상 대비 실제 결과를 남긴다.
9. 반복 문제나 새로 검증된 사실을 Context·Knowledge·SOP·Decision 후보로 분류하고,
   다음 소비 파일과 검증 시점을 지정한다.

L1·L2 Task는 `SOP-013`을 따른다. 결과가 나중에 발생하면 Owner·측정일·원천을 가진
`RESULT_PENDING`으로 두며, Knowledge를 생성했더라도 소비 파일의 Enforcement Point와
다음 비교 실행의 Reuse Verification이 없으면 학습 완료로 보고하지 않는다.

`OS-Ref`를 고정할 수 없는 대화형 검토에서는 현재 브랜치와 미확정 상태를 명시하고,
실행 시스템의 확정 기준인 것처럼 보고하지 않는다.

### GentlePapa Brand Task Boot

`DEC-0019`가 ACTIVE인 경우 GentlePapa 관련 콘텐츠·커머스·Publisher·Founder Story·제품
작업은 일반 AI Task Boot 뒤에 다음 절차를 추가한다.

1. `OS-INDEX.yaml`의 `brand_authority.gentlepapa`를 확인한다.
2. `ajseo-gp/gp-company-hub`의 Canon branch `main`에서 정확한 40자리 HEAD SHA를
   `GentlePapa-Canon-Ref`로 고정한다.
3. 같은 SHA의 `brands/gentlepapa/BOOT.md`를 진입점으로 해당 Task에 필요한 Canon 문서를 읽는다.
4. Canon을 확인할 수 없으면 `CANON_UNAVAILABLE`로 실행을 확대하지 않는다.
5. 같은 Task/Campaign의 다른 소비자가 다른 Canon SHA를 사용하면
   `CANON_REVISION_MISMATCH`로 외부 게시·Campaign 발급·SmartStore 쓰기 전에 차단한다.
6. 제품·커머스 작업은 현재 상품 사실과 허용 표현을 동일 `GentlePapa-Canon-Ref`에 결속한
   승인 Current Product Brief가 없으면 `CANON_PRODUCT_BRIEF_REQUIRED`로 차단한다.
7. Company OS에는 GentlePapa 세계관 원문을 복사하지 않는다. Brand Canon 원문은 Hub의
   Authority path에서만 읽는다.

`DEC-0019`가 `REVIEW` 또는 `DRAFT`이면 위 절차는 검토 기준일 뿐 운영 권한으로 사용하지 않는다.

## 6. Stop and Escalate

다음은 승인 또는 추가 근거 없이 확정·실행하지 않는다.

- 가격, 마진, 납기, 계약, 결제와 법률·규정 판단
- 레시피 확정, 생산 가능성, 시험결과·기능성·사용기한 확정
- 고객 또는 외부 대상 발송·게시
- 데이터 삭제·덮어쓰기와 비가역적 변경
- ACTIVE Decision과 충돌하는 변경
- 권한·책임자·근거 문서가 불명확한 고위험 실행

## 7. 최소 결과 계약

중요한 AI 결과에는 가능한 범위에서 다음을 포함한다.

- 적용한 `OS-Ref` 또는 검토한 브랜치
- GentlePapa Task인 경우 적용한 `GentlePapa-Canon-Ref` 또는 Canon 차단 사유
- `Direction-Profile`, 읽은 방향 문서와 실제 적용한 방향
- 참조한 Decision·Context·SOP·Knowledge
- 적용한 Knowledge, 적용하지 않은 Knowledge와 이유 또는 `NO_APPLICABLE_KNOWLEDGE` 검색 범위
- 확인된 사실과 아직 확인되지 않은 가정
- 예상 대비 실행 결과, 검증 Evidence와 결과 측정일
- 필요한 승인 또는 차단 사유
- Context·Knowledge·SOP·Decision 갱신 후보와 Enforcement Point
- 다음 비교 실행의 Reuse Verification 또는 `RESULT_PENDING` Owner·일자

## 8. 보안

실제 고객정보, 이메일 원문, 처방·함량, 원가·단가, 계약 비밀과 인증정보는 이 저장소에
커밋하지 않는다. 이 저장소에는 정책, 비식별 메타데이터, 안전한 참조 ID와 검증 범위만
남긴다. 자세한 기준은 `SECURITY.md`를 따른다.
