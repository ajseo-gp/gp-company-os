# 화장품 표현 안전 가이드

- ID: CLAIMS-0001
- 상태: ACTIVE
- 소유자: GP Company CEO / Marketing Owner
- 검증 범위: 국내 화장품 상품정보·상세페이지·광고 문구의 사전 자동 Gate
- 신뢰도: 중간 — 일반 금지·주의 범위는 공식 근거 확인, 제품별 기능성·시험 상태는 별도 원본 필요
- 기준일: 2026-07-29
- 다음 검토일: 2026-08-29 또는 관련 법령·제품 기능성 상태 변경 시

## Evidence

- 국가법령정보센터, 「화장품법」 제13조와 시행규칙 표시·광고 기준:
  기능성화장품이 아닌 제품을 기능성으로 오인시키는 광고와 심사·보고 내용과 다른 광고 금지
  - https://www.law.go.kr/LSW/cgmExpcInfoP.do?cgmExpcDatSeq=2284307
- 식품의약품안전처, 화장품 정책 개요:
  `탈모 증상 완화에 도움`은 기능성화장품 범위
  - https://www.mfds.go.kr/wpge/m_639/de050601l001.do
- 국가법령정보센터, 「화장품 표시·광고 실증에 관한 규정」:
  사실 주장에는 광고 내용과 관련된 과학적·객관적 실증자료 필요
  - https://law.go.kr/LSW/admRulInfoP.do?admRulSeq=2100000192523

## 제품 상태 선행 조건

다음 제품별 원본을 확인하지 못하면 기능성·시험·안전성 주장을 자동 통과시키지 않는다.

- 기능성화장품 심사·보고 여부와 효능·효과 범위
- 광고 문구와 직접 연결되는 완제품 시험자료 ID
- 제품 유형·사용방법·주의사항
- 최신 카탈로그·표시사항 revision

젠틀파파 각 SKU의 기능성화장품 신고·보고 여부는 현재 Company OS에서 `미확인`이다.
Claude Code 전달문만으로 제품 사실을 확정하지 않는다. 권한 원본에서 확인될 때까지
`탈모`, `탈모케어`, `탈모 증상 완화`, `기능성화장품` 표현은 `HUMAN_REVIEW`이며 외부
쓰기를 보류한다.

## 판정 등급

### `AUTO_ALLOW`

아래 문구가 실제 제품 유형·사용방법과 일치하고 다른 기능성·시험 주장을 결합하지 않은
경우 자동 통과 후보로 분류한다.

- 두피와 모발의 청결 관리
- 과도한 유분과 노폐물 세정
- 산뜻한 사용감
- 풍성하고 부드러운 거품
- 일상적인 두피·헤어 관리
- 향기로운 사용 경험

`두피 보습`은 완제품 또는 표시사항 근거가 연결된 경우에만 `AUTO_ALLOW`로 한다.

### `AUTO_BLOCK`

다음 의미를 포함하면 제품 상태와 무관하게 자동 차단한다.

- 질병·증상의 치료 또는 예방을 단정
- 지루성 두피염 등 질환을 치료한다는 표현
- 발모·모발 성장·모공 치료·세포 재생 단정
- 의학적 진단·처방·의약품을 대체한다는 표현
- 근거 없는 `100% 안전`, `절대 안전`, 부작용 없음과 같은 절대 표현
- 원료의 일반 효능을 완제품의 확정 효능으로 전환한 표현

### `HUMAN_REVIEW`

다음은 정확한 제품 상태·시험 Evidence와 허용 범위를 사람이 확인하기 전 외부 쓰기를
보류한다.

- `탈모`, `탈모케어`, `탈모 증상 완화`, `기능성화장품`
- `저자극`, `무자극`, `민감성`, `임상`, `시험 완료`, 수치·기간이 있는 효능
- 기능성 심사·보고 효능과 연결되는 표현
- 비교·최고·유일·추천·인증 주장
- 새 표현 또는 자동 규칙이 해석하지 못한 표현

## 기계 판독 계약

```yaml
claims_rules_revision: CLAIMS-0001
product_status_source_required: true
decision_order: [AUTO_BLOCK, HUMAN_REVIEW, AUTO_ALLOW]
unknown_default: HUMAN_REVIEW
external_write_on:
  AUTO_ALLOW: allowed_if_all_other_gates_pass
  AUTO_BLOCK: forbidden
  HUMAN_REVIEW: forbidden_until_approved
```

정확한 문자열만 피하는 변형 문구를 허용하지 않도록 정규화·형태소·동의어 검사를 함께
사용한다. 자동 Gate는 법률 자문을 대체하지 않으며 `HUMAN_REVIEW`를 임의로
`AUTO_ALLOW`로 낮추지 않는다.

## Enforcement

- 소비 파일: Commerce channel adapter의 외부 쓰기 preflight
- 실패 동작: 해당 SKU 외부 쓰기 중단, Task-ID·문구·규칙 revision·제품 상태 원본 참조 기록
- 금지 로그: 고객정보, 원가, credential, 전체 시험자료 원문

## Reuse Verification

첫 스마트스토어·쿠팡 dry-run에서 `AUTO_ALLOW`, `AUTO_BLOCK`, `HUMAN_REVIEW` 예시를 각각
검증하고 오탐·누락·사람 검토 결과를 기록한다. 법령 또는 제품 상태가 바뀌면 새 revision으로
대체한다.

## 관련 문서

- Decision: `../DECISIONS/DEC-0013_CHANNEL-LISTING-AUTOMATION.md`
- SOP: `../SOP/SOP-014_COMMERCE-CONTROL-RULES.md`
- Context: `../CONTEXT/COMMERCE-CONTROL-RULES.md`
