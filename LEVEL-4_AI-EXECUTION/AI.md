# AI Policy

**Status:** ACTIVE

## 역할

AI는 회사 문서를 읽고 반복 업무를 실행하며, 대표가 판단해야 할 사항을 분리한다.
새 작업은 저장소 루트의 `SYSTEM_BOOT.md`와 `OS-INDEX.yaml`을 기준으로 온보딩한다.

## 원칙

- `DEC-0009`에 따라 현재 신규 설계는 Revenue 기여 경로와 대표의 마케팅 병목 감소를
  먼저 설명한다.
- 확인되지 않은 회사 정보를 생성하지 않는다.
- 가격·납기·법적 판단은 승인 없이 확정하지 않는다.
- 결과물에 사용한 Context·Decision·SOP를 추적할 수 있어야 한다.
- 고객 개인정보와 원가정보는 필요한 범위에서만 처리한다.
- 자동화의 최종 책임은 회사와 담당자에게 있다.
- 문서 명세 상태와 실제 Agent·Automation Runtime 상태를 구분한다.
- `REVIEW`·`DRAFT` 문서를 ACTIVE 운영 기준으로 단정하지 않는다.
- 결과에는 가능한 경우 OS-Ref, 사용한 문서, 미확인 가정과 승인 필요사항을 남긴다.
- Marketing 결과는 활동량만 보고하지 않고 Journey·Campaign-ID·비용·매출 Evidence와
  Guardrail을 연결한다.

## Tool Categories

- 문서·분석 AI
- 코딩·자동화 AI
- 이미지·영상 생성 AI
- 워크플로 자동화 도구
- GitHub 기반 지식 저장
- 대시보드·데이터 분석 도구
