# Workbench Research–Production Alignment

**Status:** REVIEW

**기준일:** 2026-07-23

**코드 검토 Workbench revision:** `60acb0a` (`main`, production 배포 여부 미확인)

## Purpose

GP Workbench의 현재 연구·견적·생산 구현과 Company OS·Hub·보안 저장소의 역할을
대조하고, 확인된 실행 사실과 미확정 정책을 분리한다.

## Confirmed Implementation

현재 `ajseo-gp/gpcompany-lab`의 Workbench에는 다음 실행 흐름이 구현되어 있다.

```text
웹 문의·메일
→ 리드
→ 연구 조건
→ 원료 마스터·레시피
→ 연구중 / 확정
→ 정밀 견적
→ 수주 확정
→ 연구·샘플·생산·출고 스케쥴
→ 생산 LOT
→ 생산 문서
```

### Module and Record Map

| 영역 | 주요 기록 | 연결 기준 | 역할 |
|---|---|---|---|
| 문의 | Lead | `leadId` | 고객 요구의 최초 입력 |
| 원료 | Ingredient | 원료명 | 패킹·단가·특성·INCI 마스터 |
| 연구 | Recipe, Research Brief | `recipeId`, `leadId` | 연구 조건, 처방, 상태와 연구 산출물 |
| 견적 | Quote, Client | `recipeId`, `customerId` | 확정 레시피 기반 원가·견적 |
| 일정 | Schedule | `recipeId`, `quoteId`, `leadId` | 연구→샘플→생산→출고 상태 |
| 생산 | Lot | `recipeId`, `lotNo` | 발주·제조·출고 단위 |
| 변경증거 | Recipe Audit | `recipeId`, 사용자, 시각 | 확정·확정 취소·수주 확정 기록 |

실제 운영 레코드는 `data/*.jsonl`에 저장되고 Git 추적에서 제외된다. Mac 2018 Hermes의
1차 읽기 전용 점검에서는 운영 파일·연결 무결성과 백업 상태를 확인하지 못했다. 따라서
이 문서의 데이터 흐름은 코드 구조로 확인된 구현이며 실제 운영 데이터의 연결 완료를 뜻하지 않는다.

## Authority Boundary

| 시스템 | 원본으로 관리할 내용 |
|---|---|
| `gp-company-os` | 전략, 정책, Decision, 상태 전환, 승인·보안 원칙 |
| `gp-company-hub` | B2B 리드·수주 파이프라인, 견적 프로세스, Agent 운영 스펙과 원본 경로 인덱스 |
| GP Workbench | 문의·원료·레시피·견적·스케쥴·LOT의 실행 기록과 감사 로그 |
| 보안 저장소·OneDrive | 고객별 발행 견적서, 계약서, 생산단가표, 시험성적서와 원본 파일 |
| GitHub 코드 저장소 | 스키마, 계산 로직, 화면, 테스트와 배포 증거 |

Workbench는 정책을 새로 결정하지 않는다. 구현과 OS가 충돌하면 OS Decision을 우선하고,
기존 운영 데이터에 미치는 영향을 검토한 뒤 별도 변경으로 동기화한다.

## Confirmed State Rules

- 신규 레시피의 기본 상태는 연구중이다.
- 연구중 레시피는 정밀 견적의 확정 레시피 목록에서 제외된다.
- 레시피 확정 시 생산 스케쥴 카드 한 건을 생성하고 연구 단계를 완료 처리한다.
- 같은 레시피의 중복 확정 요청은 스케쥴을 중복 생성하지 않아야 한다.
- 정밀 견적에서 수주를 확정하면 기존 레시피 스케쥴을 우선 갱신한다.
- 수주 또는 생산 LOT가 연결된 레시피의 확정 취소를 차단한다.
- 생산 문서는 LOT와 레시피·원료 정보를 결합해 산출한다.

## Alignment Gaps

1. Workbench의 `.gp-company-os.yaml`은 `ea6113979c21880d8e1764e740579841c4a8f672`
   및 `DEC-0001`, `DEC-0002`, `DEC-0004`만 적용한 것으로 기록되어 최신 OS와 차이가 있다.
   Hermes 운영 기록은 별도로 OS `3e40190b1138eaaae00d4d84b88a417ec41168d3`,
   Hub `82d461d88809cb3d9fd2a43117a5695b48979058`를 참조해 적용 revision 기록도 일치하지 않는다.
2. Hub는 화장품 R&D 저장소와 R&D Agent를 `예정`으로 설명하지만 Workbench에는 이미
   사람용 레시피 연구와 로컬 저장 구조가 운영되고 있다.
3. Workbench README가 언급한 Hub의 `projects/gp-workbench/` 기획 경로가 현재 존재하지 않는다.
4. Hub 표준 결제조건은 원칙적으로 `50% 선금 / 출고 전 50% 잔금`이지만 Workbench 견적
   출력에는 `선금 100%` 문구가 포함된 부분이 있어 CEO Decision이 필요하다.
5. Workbench의 수량 구간과 Hub의 MOQ 제안 기준은 구현되어 있지만 Company OS의 공식
   제형별 MOQ·최소 마진은 아직 REVIEW다.
6. 생산문서 템플릿에 특정 샴푸의 KCL 시험성적서, 일반화된 불검출·적합 결과, 기능성 대상
   여부, 사용기한과 부자재 공급조건 등이 고정 문구로 포함되어 있다. 제품별 근거 확인 없이
   다른 LOT에 발행하면 사실·품질·규제 문서 오류가 될 수 있어 대외 발행 guard가 필요하다.
7. 레시피·원료·스케쥴·LOT 삭제 API가 연결 참조를 서버에서 일관되게 차단하지 않아,
   하드 삭제 시 고아 참조가 생길 수 있다. 운영 데이터 삭제 정책과 참조 무결성 guard가 필요하다.
8. Hermes 1차 점검에서 production 배포 revision·실행 경로, 운영 JSONL의 파일·레코드·
   연결 무결성, OneDrive 원본 종류와 최근 백업 성공 여부를 확인하지 못했다.

## Hermes Read-only Validation

2026-07-23 Mac 2018 Hermes에 읽기 전용 점검을 요청했으며 다음 범위만 확인됐다.

- Workbench 운영은 `gpwb_bot + local Claude Code` Fast Lane을 중심으로 한다.
- Hermes는 Workbench의 필수 구현·배포 게이트가 아니라 조율·기록·릴리스 보조 역할이다.
- `WB-LOW`와 `WB-MEDIUM/HIGH`의 승인 경계는 `DEC-0007`과 일치한다.
- 위에 기록한 OS·Hub 참조 SHA가 운영 기록에 남아 있으나 Workbench 설정과 서로 다르다.

다음 항목은 확인되지 않았다.

- 실제 production revision과 실행 경로
- `data/*.jsonl` 파일, 레코드 수, 변경시각과 필드 구조
- 문의→연구→견적→스케쥴→LOT의 실제 운영 데이터 연결
- 고아·중복 참조
- OneDrive 원본자료 종류, 백업 위치와 최근 성공 여부

미확인 항목은 실제 값이나 상태를 추정하지 않고 후속 읽기 전용 점검 대상으로 유지한다.

## Safe Alignment Work

CEO의 추가 숫자 결정 없이 진행할 수 있는 작업은 다음과 같다.

- OS에 연구→생산 상태 흐름과 데이터 경계를 문서화
- Hub에 Workbench 기획 경로와 현재 R&D 실행 위치를 기록
- Workbench의 적용 OS revision과 관련 Decision 추적을 최신화할 준비
- 충돌하는 결제·MOQ·시험 근거 문구를 확인 필요 항목으로 표시
- 생산문서의 시험결과·기능성 여부·사용기한·공급조건을 제품별 근거 없이는 자동 확정하지 않기
- 실제 데이터 값을 노출하지 않는 무결성 점검과 백업 확인
- 연결된 레시피·원료·스케쥴·LOT의 하드 삭제를 차단하거나 보존형 상태 변경으로 대체
- Workbench 설정·Hermes 운영 기록·실제 production의 적용 OS·Hub revision을 하나의
  배포 증거로 일치시키기

가격, 결제, MOQ, 마진, 법률·규제와 시험 근거 범위는 CEO와 책임자의 Decision 없이
자동 변경하지 않는다.

## Change Risk Classification

| 항목 | 등급 | 이유 | 현재 처리 |
|---|---|---|---|
| OS·Hub의 R&D·Workbench 설명 정리 | 낮음 | 실행 데이터와 계산을 바꾸지 않는 문서 정합화 | 초안 작성 가능 |
| Workbench 적용 OS revision 갱신 | 중간 | 하위 저장소의 적용 정책 범위가 변함 | OS merge 후 별도 검증 |
| 결제·MOQ·샘플비 기본값 변경 | 중간 | 견적 의미와 고객 조건이 변함 | CEO Decision 대기 |
| 연결 데이터 삭제 guard | 높음 | 실제 처방·견적·생산 데이터 삭제와 무결성에 영향 | 원본 수정 없이 설계·검증 |
| 생산문서 시험·규제·품질 자동입력 guard | 높음 | 외부 품질 문서와 법적 사실에 영향 | 제품별 책임자 승인 전 발행 금지 |

등급이 중간·높음인 Workbench 변경은 `DEC-0007`의 Preview·승인 절차와 실제 데이터
백업·rollback 검증을 거친다.
