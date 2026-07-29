# Commerce Control Rules 현재 상태

- 상태: ACTIVE
- 소유자: GP Company CEO / Marketing Owner
- 기준일: 2026-07-29
- 다음 검토일: 첫 규칙 instance 승인 시 또는 2026-08-05
- 적용 범위: 스마트스토어·쿠팡 및 대표가 활성화한 쇼핑몰의 상품·가격·프로모션
- 원본 근거: DEC-0013, SOP-014

## 확인된 현재 상태

- 활성 규칙 revision: `NONE`
- `externalWriteEnabled`: `false`
- 채널별 첫 `L1` 승인 기록: `NONE`
- 규칙 instance 원본 위치: `미지정`
- 마지막 검증 실행 ID: `NONE`

활성 규칙이 없으므로 조회·분석·dry-run과 구현·테스트는 수행할 수 있지만, `L1`의 실제
신규 등록과 `L2`·`L3` 외부 쓰기는 실행하지 않는다.

## 원본 경계

Company OS는 규칙의 필수 구조, 승인·활성화·중단 계약과 안전한 revision 참조를 보관한다.
실제 가격 산식의 원가 입력, credential, 채널 운영 원문과 비공개 비용 값은 권한이 분리된
Workbench 또는 운영 저장소가 원본이다. OS에는 해당 값을 복사하지 않고 다음 메타데이터만
남긴다.

- `CCR-ID`와 revision
- 상태와 적용 채널·SKU의 안전한 식별자
- 승인자·승인일
- 규칙 원본의 권한 저장소 참조
- 검증 실행 ID와 rollback 검증 결과
- 활성화·중단·대체 시각

## 활성화 전 미확인 항목

- 채널과 SKU 범위
- 가격 하한·상한 또는 승인 원가 기준 산식
- 최대 할인율
- 허용 프로모션 유형과 기간
- 일·총 예산 또는 비용 상한
- 중단 조건과 rollback 경로
- 제품별 기능성 상태·표현 Evidence
- 채널별 첫 `L1` 승인자와 승인 기록
- runtime 원본 위치와 Owner

## 관련 문서

- Decision: `../DECISIONS/DEC-0013_CHANNEL-LISTING-AUTOMATION.md`,
  `../DECISIONS/DEC-0015_UNATTENDED-EXECUTION-DECISION-DIGEST.md`
- SOP: `../SOP/SOP-014_COMMERCE-CONTROL-RULES.md`
- Template: `../../TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`
- Knowledge: `../KNOWLEDGE/COSMETIC-CLAIMS-GUIDE.md`
