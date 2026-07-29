# OS Unblock 응답 — Codex

- 상태: ACTIVE HANDOFF
- 소유자: Codex
- 처리 시점: 2026-07-29
- 적용 범위: `gpcompany-lab`의 Claude Code 구현 재개
- Direction Profile: D2
- 기준 OS-Ref: `74632d450fbc8f99e35420dd16f1ffee58ecd1df`
- 적용 승인 OS-Ref: `f0487153ef9ef93b65e2755054c2d0d0aca73893`
- branch: `codex/unattended-execution-unblock`
- 원격 상태: `REMOTE_READY`
- Draft PR: `https://github.com/ajseo-gp/gp-company-os/pull/11`
- 검증: `ruby scripts/validate_os.rb` PASS, YAML parse PASS, `git diff --check` PASS

> 대표가 위 40자리 OS-Ref의 적용과 작업 재개를 명시적으로 지시했다. Claude Code는
> PR merge 여부를 이유로 적용 승인을 다시 묻거나 이 항목을 `DECISION_QUEUE`에 넣지
> 않는다. 원격 SHA의 존재와 이 인계문을 확인한 뒤 승인된 구현을 계속한다.
> ACTIVE Commerce Control Rules instance와 채널별 첫 L1 승인이 없으므로 외부 쓰기는
> 계속 금지한다.

## 요청별 처리 결과

### 0. lab OS 참조

Claude Code 담당이다. `.gp-company-os.yaml`을 적용 승인 OS-Ref로 갱신하고
DEC-0006·0007·0012·0013·0014·0015를 포함한다. `sync.status=current`는 원격 SHA 존재,
필수 문서 read와 governance validation을 모두 확인한 뒤에만 기록한다.

### 1. WB-LOW Fast Lane

기존 ACTIVE `DEC-0007`이 이미 권한 근거다. lab `GOVERNANCE.md`·`CLAUDE.md`에
`WB-LOW` 자체 승인·merge·deploy·smoke·사후 PC/mobile 보고 예외를 구현한다.
`WB-MEDIUM`·`WB-HIGH` Gate는 유지한다.

### 2. Commerce Control Rules

다음을 신설했다.

- `LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/COMMERCE-CONTROL-RULES.md`
- `LEVEL-3_OPERATING-KNOWLEDGE/SOP/SOP-014_COMMERCE-CONTROL-RULES.md`
- `LEVEL-3_OPERATING-KNOWLEDGE/TEMPLATES/COMMERCE-CONTROL-RULES-TEMPLATE.yaml`

현재 상태는 의도적으로 `active CCR = NONE`, `externalWriteEnabled=false`다. Claude Code는
schema, validator, dry-run, audit, rollback을 구현할 수 있다. 실제 가격·할인·예산 값과
채널별 첫 L1 승인이 들어오기 전 외부 쓰기는 금지한다.

### 3. SYSTEM_BOOT 충돌

활성 CCR과 DEC-0013·SOP-014 Gate를 통과한 가격·콘텐츠·프로모션·가역적 채널 변경 예외를
명시했다.

### 4. AUT-006 전환 기준

승인 identity, exact revision, required CI, desktop/mobile Evidence, deployment SHA,
smoke, rollback과 ACTIVE 전환 Evidence를 구체화했다. branch protection이 없어도
Automation 자체가 각 결과를 조회해 PASS가 아니면 merge하지 않아야 한다.

### 5. 무인 실행

`DEC-0015`를 추가했다.

- 기본 무인 창: `22:00-08:00 KST`
- 비차단 판단: `DECISION_QUEUE`
- Claude 사용량 한도: `WAITING_FOR_QUOTA` + checkpoint
- Digest: `08:00`, 필요 시 `18:00` 추가
- Hermes: 작업 큐 단일 Primary
- Orca: 같은 Task-ID의 Claude Worker를 감독하는 선택적 하위 조정자
- 사용량 한도의 비용 상한 없는 API 자동 우회 금지

앞으로 정책 요청은 대표에게 파일을 복사하게 하지 말고 Hermes·Orca 또는 공유 작업
artifact로 Codex에 직접 전달한다.

### 6. L2 기본 담당

`LEVEL-3_OPERATING-KNOWLEDGE/CONTEXT/DOMAIN-OPERATING-DEFAULTS.md`를 추가하고 B2C의
Owner·Reviewer·검토 준비 대리·주간 측정 주기를 기본 상속으로 고정했다. Reviewer의 일시
부재는 승인된 Campaign 실행을 막지 않고 Learning의 검증·PRACTICE 승격만 보류한다.

### 7. 실패 중단 범위

DEC-0013과 SOP-014를 다음처럼 수정했다.

- 일반 실패·반려·규칙 이탈: 채널×SKU 격리
- 예산 초과: 해당 채널 중단
- 표현 Gate 미통과: 해당 SKU hard stop
- 같은 원인 3회 또는 rollback 실패: 모든 채널 중단
- 영향받지 않는 채널×SKU는 계속

### 8. 화장품 표현 Gate

`COSMETIC-CLAIMS-GUIDE.md`를 `AUTO_ALLOW`·`AUTO_BLOCK`·`HUMAN_REVIEW` 계약으로
구조화했다. 공식 법령·식약처 근거를 연결했다.

Claude 전달문의 “젠틀파파 기능성화장품 미신고”는 OS 권한 원본으로 확인되지 않았으므로
회사 사실로 확정하지 않았다. SKU별 기능성·시험 원본을 확인할 때까지 탈모·기능성 관련
표현은 `HUMAN_REVIEW`이며 외부 쓰기를 보류한다.

## Claude Code 다음 실행 순서

1. 적용 승인 OS-Ref를 고정하고 lab의 schema·validator·테스트·dry-run 구현
2. lab `GOVERNANCE.md`·`CLAUDE.md`의 WB Fast Lane 정합성 수정
3. checkpoint·`DECISION_QUEUE`·`WAITING_FOR_QUOTA` 구현
4. CCR validator, 표현 Gate, idempotency, before snapshot, rollback과 audit 구현
5. 채널×SKU 격리와 확대 중단 테스트
6. AUT-006 활성화 Evidence 패키지 생성
7. `.gp-company-os.yaml`을 적용 승인 OS-Ref로 갱신하고 원격 조회 Evidence 기록
8. 활성 CCR·첫 L1 승인 전 `externalWriteEnabled=false` 유지

## 남은 CEO 1회 결정

구현을 시작하기 위해 즉시 질문할 필요는 없다. 외부 쓰기 활성화 직전에 다음만 하나의
Decision Digest로 요청한다.

- 채널·SKU 범위
- 가격 하한·상한 또는 산식
- 최대 할인율
- 허용 프로모션과 기간
- 일·총예산
- 첫 L1 상품
- SKU별 기능성 상태 원본

## 재인계 규칙

추가 정책 충돌이 생기면 대표에게 파일을 전달시키지 말고 같은 작업 공간에
`OS-UNBLOCK-REQUEST-<N>.md`를 남기고, 활성 Hermes·Orca 경로가 있으면 Codex 작업으로
직접 dispatch한다. 대표에게는 정책 선택이 실제로 필요한 항목만 Digest로 올린다.
