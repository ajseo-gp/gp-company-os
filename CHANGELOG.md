# Changelog

## Unreleased

- 네이버 SmartStore 공식 상품명·브랜드·태그·검색 메타데이터·정가·첫구매 혜택 기준과
  식약처 화장품 표시광고 지침을 조사해 Evidence 기반 상품 운영 가이드 추가
- SmartStore 상품 수정 전에 현재 revision·제품 Evidence·Revenue 기준선·변경 이력·
  KPI·원복 조건을 요구하는 전용 Dry-run Prompt 추가
- Commerce 제안에서 상품명 키워드 단순 결합·제품 추정·원인 단정·승인 없는 실제 변경을
  금지하고 SmartStore Growth Agent 참조 계약 강화
- SmartStore 최신 주문조회 export의 업무 열·개인정보 경계·상품주문 중복·판매 집계
  reconciliation을 검증하고 단순 변심 취소 Context와 남은 결제·환불 매핑 차단요인 반영
- SmartStore 판매·방문 집계 export의 실제 구조, 계층 중복·귀속 범위·제품 상세 불일치와
  개인정보 없는 `PARTIAL` 수동 Revenue 기준선 사용 범위 확인
- `AUT-007 Revenue Snapshot`의 원천·기준시각·검증·revision·보안·PILOT 활성화 계약 추가
- B2C 순매출·기여이익·재구매 매출 비중 중심의 CEO Weekly Scorecard와 표준 산식 정의
- Revenue 숫자에 `READY/PARTIAL/BLOCKED/NOT_AVAILABLE` 데이터 품질 상태를 의무화
- Weekly Review를 Snapshot 잠금→품질 Gate→병목→Campaign→Knowledge 환류 절차로 고도화
- CEO `DEC-0009 Revenue First` 운영 우선순위와 Customer Journey Revenue Engine 반영
- Marketing Growth Team을 SmartStore·Idus·Content·CRM·Review·Revenue Analytics 역할로 설계
- `WF-006 Revenue Growth Loop`와 `SOP-011 Marketing Revenue Experiment` 추가
- Marketing Agent별 매출·기여이익·Journey KPI와 PILOT Gate 정의
- SmartStore와 아이디어스의 채널 책임·데이터·KPI·학습을 분리
- Campaign-ID·비용·주문·직접/기여 매출·attribution Evidence 계약 추가
- Revenue Snapshot·Readout·Campaign Brief 등 대표 마케팅 병목 자동화 후보 우선순위화
- Dashboard·Weekly Review·Roadmap을 Revenue Engine → Marketing → B2B → R&D/Production 순서로 변경
- GP Company OS v1.0 readiness Architecture Review와 v2.0 Roadmap 추가
- `SYSTEM_BOOT.md`를 AI 단일 진입점으로 추가하고 루트 `AGENTS.md` 작업 규칙 정의
- README에 Project, Mission, Vision, Repository Map, AI Onboarding과 OS 학습 순환 추가
- `OS-INDEX.yaml`에 Boot sequence, 디렉터리·문서 계약과 레지스트리 추가
- Boot 경로·링크·ID·실행 문서 계약·File Manifest를 검사하는 GitHub CI 추가
- PR·Decision·Process Improvement 템플릿에 traceability·근거·검증·KPI Gate 강화
- Context·Decision·Knowledge·Workflow·SOP·Prompt·Automation 책임 경계와 표준 강화
- Agent Architecture와 명세 상태·Runtime 상태를 분리하고 R&D·Production·Knowledge Agent 설계 추가
- Agent·Workflow·Automation·Knowledge·Decision 신규 문서 템플릿 강화
- Workbench의 문의→연구 조건→레시피→견적→스케쥴→LOT 실행 흐름을 Company OS에 반영
- R&D 사업 문서, 연구→생산 SOP와 시스템별 원본 경계 정합성 Context 추가
- Inquiry-to-Order Workflow에 연구중·확정·수주·LOT 상태 제어 추가
- Workbench 운영 데이터와 외부 생산문서의 보안·발행 guard 추가
- 연구·견적·생산 제어 경계 Decision 후보와 CEO 검증 항목 추가
- OS·Hub·Workbench의 R&D 상태, 결제조건, MOQ와 시험 근거 충돌을 REVIEW 항목으로 분리
- Hermes 1차 점검 결과와 서로 다른 OS·Hub 적용 revision, 미확인 production·데이터·백업 상태 기록
- GP Workbench Closed Beta를 `gpwb_bot`·로컬 Claude Code 직접 개발 Fast Lane으로 분리
- Workbench 저위험 변경의 자체 승인·자동 배포·사후 PC/모바일 시각 보고 정의
- 중위험·고위험 Workbench 변경의 사전 Human Preview와 승인 유지
- 사람 대신 Hermes가 Task-ID·OS-Ref·승인등급을 생성하도록 자연어 접수 계약 변경
- Hermes의 우선 역할을 B2C·B2B·OEM·마케팅 Agent 라우팅으로 명확화
- Hermes Primary와 GPmarketing Slack bridge의 책임 경계 정의
- Hermes 작업마다 40자리 commit SHA의 `OS-Ref`를 고정하는 원칙 추가
- 지정 SHA를 `gh api`로 읽는 SOP와 Slack 작업 상태 흐름 추가
- Hermes Primary Agent 정의와 표준 작업 요청 템플릿 추가
- 코드 검토 대신 실제 Preview를 승인하는 Human Experience Gate 추가
- 승인 revision의 자동 merge·배포·smoke test 원칙과 자동화 명세 추가

## 0.2.0 - 2026-07-21

- Hair와 Scalp를 회사의 핵심 시장 축으로 확정
- Hair·Scalp 사업과 AI·Company OS 사업의 이중 수익 엔진 확정
- `gp-company-os`를 최상위 전략·정책·Decision 원본으로 명시
- Mission, Vision, Manifest, Blueprint와 Business 문서 정렬
- 내부 검증을 외부 AI·OS 제품과 서비스로 발전시키는 경로 정의
- 대표 의존도, 자산 소유권과 양도가능성 KPI·Roadmap 추가

## 0.1.0 - 2026-07-21

- GP Company OS 5-Level Architecture 수립
- Mission, Vision, Manifest, Blueprint 초안 작성
- Business, Marketing, OEM, B2C, Production, Finance 운영 문서 생성
- SOP, Knowledge, Prompt Library, Decision, Context 체계 생성
- AI, Agents, Automation, Workflow, Memory 체계 생성
- Dashboard, KPI, Roadmap, Weekly Review, CEO Review 체계 생성
- GitHub Issue/PR 템플릿 추가
