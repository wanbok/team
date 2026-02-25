# Agent Team Design — AI Central

## Overview

superpowers와 ui-ux-pro-max 스킬을 활용한 Agent Team 구조.
어떤 앱이든 상용 수준으로 완성할 수 있는 범용 개발 팀.
Critic 패턴으로 Codex(GPT-5.3) 크로스 모델 검증 지원.

## Team Structure

### Leader (User's Claude Session)
- **모드**: 위임 모드 (Delegation Mode)
- **역할**: 조율 전용. 코드 직접 작성 불가
- **책임**: 팀원 생성, 작업 할당, 계획 승인/거부, 품질 게이트

### Core Team (5인, 전원 Opus)

| # | 역할 | 이름 | 핵심 책임 | 스킬 |
|---|------|------|-----------|------|
| 1 | **PM + Analyst** | pm | 요구사항 정립, 작업 분해, 경쟁 분석 | `brainstorming`, `writing-plans` |
| 2 | **UI/UX Designer** | designer | 디자인 시스템, 컴포넌트, 와이어프레임 | `ui-ux-pro-max` |
| 3 | **iOS Dev A** | ios-a | 기능 단위 개발 (Feature A 담당) | `test-driven-development`, `composable-architecture`, `executing-plans` |
| 4 | **iOS Dev B** | ios-b | 기능 단위 개발 (Feature B 담당) | `test-driven-development`, `composable-architecture`, `executing-plans` |
| 5 | **QA Engineer** | qa | 테스트 작성, 코드 리뷰, 품질 검증 | `verification-before-completion`, `composable-architecture`, `requesting-code-review` |

### Critic (on-demand, Sonnet)

| # | 역할 | 이름 | 핵심 책임 | 도구 |
|---|------|------|-----------|------|
| 6 | **Critic** | critic | 마일스톤 리뷰, 아키텍처 검증, 세컨드 오피니언 | `codex exec` (Bash), 읽기 전용 |

## Workflow (5-Phase Pipeline)

```
Phase 1: Discovery ──→ Phase 2: Design ──→ Phase 3: Development ──→ Phase 4: QA ──→ Phase 5: Finalization
   [사용자 승인]          [사용자 승인]          [자동 실행]            [자동 실행]       [자동 실행]
```

### Phase 1: Discovery (요구사항 정립)
- **담당**: PM
- **PM 작업**:
  - `brainstorming` 스킬로 사용자와 대화
  - 핵심 요구사항, 사용자 페르소나, 성공 기준 정립
  - 경쟁앱 최소 3개 간략 조사 (PM이 겸임)
  - 요구사항이 불명확하면 계속 질문 (코드 작성 절대 금지)
- **Critic 리뷰**: 요구사항 완성도 검증
- **산출물**: `docs/plans/YYYY-MM-DD-requirements.md`
- **게이트**: Critic 리뷰 + 사용자 승인 필수

### Phase 2: Design (설계)
- **담당**: PM + UI/UX Designer (병렬)
- **PM 작업**:
  - `writing-plans` 스킬로 구현 계획 작성
  - 2~5분 단위 태스크로 분해
  - 팀원별 작업 할당 계획 (기능 단위 분리)
- **Designer 작업**:
  - `ui-ux-pro-max` 스킬로 디자인 시스템 생성
  - 컬러 팔레트, 폰트 페어링, 컴포넌트 구조
  - 접근성(WCAG 2.1 AA) 준수
- **Critic 리뷰**: 아키텍처/설계 검증
- **산출물**:
  - `docs/plans/YYYY-MM-DD-implementation-plan.md`
  - `docs/plans/YYYY-MM-DD-ui-spec.md`
- **게이트**: Critic 리뷰 + 사용자 승인 필수 → 이후 자동 실행 시작

### Phase 3: Development (구현)
- **담당**: ios-a + ios-b + Designer (병렬)
- **규칙**:
  - TDD 필수: 테스트 먼저 작성 → 구현 → 통과 확인
  - `test-driven-development` + `composable-architecture` 스킬 사용
  - TCA 패턴 (Reducer, State/Action, Effects, Navigation, Dependencies)은 `composable-architecture` 레퍼런스 참조
  - 각 팀원은 자신의 Feature 디렉토리만 편집 (충돌 방지)
  - QA Engineer가 지속적으로 코드 리뷰 수행
  - Critic: 핵심 모듈 완성 시 코드 리뷰 요청 가능
- **파일 소유권**: 프로젝트별 CLAUDE.md에서 기능 단위로 정의
- **자동 진행**: 태스크 완료 시 다음 태스크 자동 할당

### Phase 4: Quality Assurance (품질 검증)
- **담당**: QA Engineer 주도 + 전체 팀 협력
- **유닛 테스트**: 모든 모듈 커버리지 목표 80%+
- **통합 테스트**: Feature 간 연동 검증
- **사용성 테스트**:
  - 핵심 사용자 플로우 시나리오 작성
  - 접근성 검증
- **도구**: `verification-before-completion` 스킬
- **Critic 리뷰**: 핵심 이슈에 대해 세컨드 오피니언
- **실패 시**: 해당 개발 팀원에게 자동 재할당
- **완료 조건**: 모든 테스트 통과 + 증거 기반 확인

### Phase 5: Finalization (완성)
- **담당**: PM + QA Engineer
- **최종 코드 리뷰**: `requesting-code-review` 스킬
- **빌드 검증**: 프로덕션 빌드 성공 확인
- **Critic 최종 검증**: 핵심 아키텍처/코드 최종 리뷰
- **완성도 체크리스트**: 요구사항 대비 기능 완성도 확인
- **브랜치 정리**: `finishing-a-development-branch` 스킬
- **산출물**: 최종 보고서 + 배포 준비 완료 상태

## Communication Rules

- PM ↔ 모든 팀원: 요구사항 전달, 진행 확인
- Designer ↔ ios-a/ios-b: 디자인 스펙 전달, 구현 피드백
- ios-a ↔ ios-b: 공유 모델/계약 변경 합의
- QA ↔ 모든 Dev: 리뷰 피드백, 버그 리포트
- Devs → critic: 대안 구현, 아키텍처 검증 요청
- QA → critic: 코드 리뷰 세컨드 오피니언
- critic → 요청자: 검증 결과 보고 (제안만, 직접 적용 안함)

## Key Principles

1. **요구사항 우선**: 요구사항이 확실해질 때까지 코드 작성 금지
2. **TDD 필수**: 모든 코드는 테스트 먼저
3. **기능 단위 소유권**: 레이어가 아닌 Feature 단위로 파일 분리
4. **증거 기반 완료**: "완료"는 테스트 통과 증거가 있어야만 선언
5. **멈추지 않는 개발**: 설계 승인 후 완성까지 자동 진행
6. **Critic 게이트**: 마일스톤마다 크로스 모델 검증
