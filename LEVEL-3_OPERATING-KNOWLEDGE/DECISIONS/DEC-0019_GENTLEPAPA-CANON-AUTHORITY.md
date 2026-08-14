# DEC-0019 GentlePapa Canon Authority

- 상태: REVIEW
- 결정일: 2026-08-14
- 적용일: 대표가 동일 revision을 승인하고 main에 반영한 시점
- 결정자/소유자: GP Company CEO
- 대체하는 Decision: 없음
- 대체된 Decision: 없음

## 배경

젠틀파파의 브랜드 세계관·콘텐츠·제품 역할·고객 VOC·리브랜딩 기준이 `gp-company-hub`의
`brands/gentlepapa` 아래에서 정본화되었고, SmartStore·Publisher·콘텐츠 실행기가 이를
소비하기 시작했다. 그러나 실행 세션이 서로 다른 시점의 Canon을 읽으면 같은 브랜드를
서로 다른 기준으로 해석할 수 있다.

2026-08-14 점검에서 SmartStore 운영 준비 PR은 이전 GentlePapa Canon revision을 근거로
기록한 반면, Hub의 현재 `main`은 더 최신 Canon과 `BOOT.md`를 포함하고 있었다. 실행 자체는
fail-closed로 막혀 있었지만, 브랜드 정본의 권위 위치와 revision 고정 규칙을 Company OS가
명시적으로 소유해야 한다는 필요가 확인되었다.

이 Decision은 젠틀파파 세계관 원문을 Company OS로 복제하지 않는다. Company OS는 브랜드
정본의 **권위 위치, 부팅 방법, revision 일치 규칙과 실행 차단 조건**만 소유한다.

## 결정

1. GentlePapa를 GP Company B2C의 공식 핵심 브랜드 도메인으로 등록한다.
2. GentlePapa Canon의 단일 원본은 다음으로 한다.
   - Authority repository: `ajseo-gp/gp-company-hub`
   - Canon root: `brands/gentlepapa`
   - Boot entrypoint: `brands/gentlepapa/BOOT.md`
   - Canon branch: `main`
3. `gp-company-os`에는 `WORLD-BIBLE.md`, `BRAND-CANON.md`, `CUSTOMER-VOICE.md` 등 브랜드
   원문을 복제하지 않는다. OS에는 Authority metadata와 소비 규칙만 둔다.
4. 기존 `LEVEL-3_OPERATING-KNOWLEDGE/KNOWLEDGE/GENTLEPAPA-BRAND.md`는 `ARCHIVED` historical
   pointer로만 유지하며 현재 브랜드 실행 정본 또는 별도 Canon으로 사용하지 않는다.
5. GentlePapa 관련 AI·Agent·Automation 작업은 시작 시 Hub `main`의 정확한 40자리 commit
   SHA를 `GentlePapa-Canon-Ref`로 해석하고, 해당 SHA의 `BOOT.md` 절차를 따른다.
6. 같은 Task 또는 Campaign에 참여하는 SmartStore, Publisher, Content, Founder Story 등 모든
   소비자는 동일한 `GentlePapa-Canon-Ref`를 사용한다.
7. 현재 Hub Canon을 확인할 수 없으면 `CANON_UNAVAILABLE`, 소비자가 고정한 Canon SHA와 현재
   Task의 `GentlePapa-Canon-Ref`가 다르면 `CANON_REVISION_MISMATCH`로 실패 폐쇄한다.
8. 제품·커머스 실행은 Canon 일치만으로 허용되지 않는다. 해당 상품의 현재 SKU·가용성·허용
   표현을 Canon과 연결한 승인된 Current Product Brief가 없으면
   `CANON_PRODUCT_BRIEF_REQUIRED`로 Campaign 발급과 외부 쓰기 전에 차단한다.
9. Brand Canon 변경의 내용 승인과 역사 관리는 Hub의 GentlePapa Canon 규칙을 따른다.
   Company OS는 Canon 원문을 재해석하거나 별도 세계관을 만들지 않는다.
10. Runtime 구현은 `gp-company-hub`, `gpcompany-lab` 등 실행 저장소의 책임이다. OS는 fail-closed
   계약과 Authority 경계만 정의한다.

### 활성화 검토 시점의 관측값

- 확인 시각: 2026-08-14 KST
- Hub `main` 관측 revision: `1660b69c9e69e0855da6061300a9dd2595fbcd77`
- 이 값은 영구 고정 Canon이 아니라 이 Decision 초안 작성 시점의 검증 Evidence다.
- 실제 실행은 매 Task 시작 시 Authority repository에서 현재 Canon revision을 다시 고정한다.

## 이유

- 세계관을 OS와 Hub에 복제하면 두 정본이 생기고, 세션 파편화가 파일 파편화로 바뀐다.
- Brand 원문은 빠르게 진화할 수 있으므로 Company OS revision을 매번 브랜드 내용 변경에 맞춰
  갱신하는 방식은 불필요한 결합을 만든다.
- 대신 OS가 Authority와 revision 일치 계약을 소유하면 모든 실행기가 같은 브랜드 정본을
  읽으면서도 Brand 팀은 Hub에서 독립적으로 정본을 관리할 수 있다.
- Current Product Brief를 별도 Gate로 두면 브랜드 세계관과 실제 판매 중 SKU의 사실·가용성·
  표현 근거를 혼동하지 않는다.

## 영향 범위

### 적용

- GentlePapa B2C 전략·콘텐츠·커머스·채널 자동화
- SmartStore Revenue Experiment와 Campaign 발급 전 사전점검
- Publisher/채널 자동화의 제목·설명·태그·CTA 생성
- Founder Story와 브랜드 콘텐츠 제작
- Agent/Automation의 브랜드 부팅 및 revision 검증
- GP Workbench CEO OFFICE의 GentlePapa 실행 준비 상태

### 비적용

- GentlePapa Canon 원문 자체의 내용 변경
- 제품 효능·성분·가격·재고·출시 상태의 신규 확정
- SmartStore·광고·가격·재고의 자동 변경 권한 부여
- Campaign-ID 자동 발급 또는 대표 승인 우회
- 다른 브랜드의 Canon Authority 자동 지정

## 결과와 Trade-off

- 장점: 모든 GentlePapa 실행이 한 Canon revision에 결속되고 세션 간 의미 드리프트를 줄인다.
- 장점: Company OS와 Brand Canon의 책임 경계가 명확해진다.
- 장점: 잘못된 SKU 또는 오래된 제품 사실을 Canon만 보고 실행하는 것을 Product Brief Gate로 막는다.
- 비용: GentlePapa 작업 시작 시 Hub Canon revision 확인이 추가된다.
- 비용: Hub 접근이 불가능한 환경에서는 브랜드 실행이 fail-closed되어 작업이 지연될 수 있다.
- 비용: 실행 저장소마다 `GentlePapa-Canon-Ref` 검증 구현이 필요하다.

## 전환과 검증

1. `OS-INDEX.yaml`에 GentlePapa Brand Authority metadata와 fail-closed 코드를 등록한다.
2. `SYSTEM_BOOT.md`에 Brand Task Boot 절차를 추가한다.
3. `LEVEL-2_BUSINESS/B2C.md`에서 GentlePapa의 Canon Authority 경계를 명시한다.
4. 기존 `GENTLEPAPA-BRAND.md`를 `ARCHIVED` historical pointer로 전환하고 Knowledge Register도 같은 상태로 맞춘다.
5. Hub/Workbench/Publisher/SmartStore 구현 저장소는 동일한 `GentlePapa-Canon-Ref` 계약을 소비한다.
6. 한 Task에서 서로 다른 Canon SHA를 주입했을 때 `CANON_REVISION_MISMATCH`로 외부 쓰기 전에
   차단되는 회귀 검증을 둔다.
7. Product Brief가 없을 때 `CANON_PRODUCT_BRIEF_REQUIRED`, 승인된 동일 Canon-ref Product
   Brief가 있을 때만 다음 승인 단계로 진행되는지 검증한다.
8. 첫 Revenue Loop에서 Content → Channel → SmartStore → Revenue Evidence가 동일
   `GentlePapa-Canon-Ref`와 Campaign-ID로 추적되는지 확인한다.

## 재검토 조건

- GentlePapa Canon Authority repository 또는 root path가 변경될 때
- 여러 브랜드를 같은 Brand Registry 계약으로 운영하게 될 때
- Hub 접근 장애가 반복되어 별도 안전 캐시 정책이 필요할 때
- Product Brief Authority를 별도 제품 데이터 시스템으로 이전할 때
- 브랜드 Canon과 법무·규제·제품 데이터의 권위 경계를 변경할 때

## 관련 문서

- Business: `LEVEL-2_BUSINESS/B2C.md`, `LEVEL-2_BUSINESS/HAIR-SCALP-BUSINESS.md`
- Decision: `DEC-0009`, `DEC-0017`, `DEC-0018`
- Workflow: `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-006_REVENUE-GROWTH-LOOP.md`, `LEVEL-4_AI-EXECUTION/WORKFLOW/WF-009_COMPANY-OS-POLICY-PROPAGATION.md`
- SOP: `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-011_MARKETING-EXPERIMENT.md`, `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-016_COMPANY-OS-POLICY-LIFECYCLE.md`
- Historical pointer: `LEVEL-3_OPERATING-KNOWLEDGE/KNOWLEDGE/GENTLEPAPA-BRAND.md`
- Brand Authority: `ajseo-gp/gp-company-hub/brands/gentlepapa/BOOT.md`
