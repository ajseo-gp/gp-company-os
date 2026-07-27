# Memory Policy

Memory는 별도의 회사 사실 저장소가 아니라 AI와 시스템이 어떤 정보를 장기 보존할지 정하는
lifecycle 정책이다. 현재 상태는 Context, 검증된 재사용 지식은 Knowledge, 승인된 선택은
Decision에 저장한다.

## 저장 대상

- 장기간 유지되는 회사 사실
- 대표가 확정한 Decision
- 제품별 핵심 사양과 제한
- 브랜드 톤과 표현 원칙
- 반복되는 고객 요구와 대응 기준
- 검증된 SOP와 Prompt
- Campaign-ID·근거·적용 범위가 연결된 검증된 Marketing Experiment와 Failure

## 저장 제외

- 확인되지 않은 추측
- 일시적인 일정
- 고객 개인정보 원문
- 주문·광고·CRM 원문과 채널 credential
- 변경 가능성이 높은 임시 가격
- 감정적 또는 사적인 대화

## Lifecycle

수집 → 검증 → 문서 분류 → 승인 → 저장 → 정기 검토 → 갱신 또는 보관

각 저장 항목은 가능한 범위에서 원본 Evidence ID, 적용 범위, 소유자와 다음 검토일을
가진다. 원본의 접근권한과 보존기간은 `SECURITY.md`와 해당 운영 저장소 정책을 따른다.
