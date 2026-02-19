# agent-team-framework

[Claude Code](https://claude.com/claude-code)를 위한 동적 멀티 에이전트 팀 오케스트레이션. 요구사항부터 프로덕션까지 구조화된 페이즈를 거치는 전문 에이전트 팀을 생성합니다.

[English](README.md)

## 하는 일

AI 하나가 혼자 코딩하는 대신, 실제 개발팀처럼 **전문 에이전트 팀**이 협업합니다:

```
나 (리더)
├── PM           — 요구사항 수집, 태스크 분해
├── Designer     — UI 스펙, 디자인 시스템
├── Dev A        — Feature A 구현 (TDD)
├── Dev B        — Feature B 구현 (TDD)
├── QA           — 코드 리뷰, 테스트
└── Oracle       — 크로스 모델 검증 (선택)
```

팀은 **6단계 파이프라인**과 품질 게이트를 따릅니다:

```
Phase 0: 팀 구성 [사용자 승인]
  → Phase 1: 요구사항 [사용자 승인]
  → Phase 2: 설계 [사용자 승인]
  → Phase 3: 개발 [자동 — TDD, 병렬]
  → Phase 4: QA [자동 — 테스트, 리뷰]
  → Phase 5: 완성 [자동 — 빌드, 검증]
```

Phase 0~2는 사용자가 승인하고, 이후 3~5는 팀이 자율적으로 진행합니다.

## 설치

### Claude Code 플러그인 (권장)

```bash
# 마켓플레이스 등록 후
/plugin install team@wanbok-claude-marketplace

# 또는 GitHub에서 직접
/plugin install --source github:wanbok/agent-team-framework
```

### 수동 설치

```bash
git clone https://github.com/wanbok/agent-team-framework.git
cd agent-team-framework
chmod +x install.sh
./install.sh
```

## 사용법

### `/team:up` — 팀 시작

```
/team:up SwiftUI + TCA iOS 앱 - 반려동물 입양 마켓플레이스
/team:up Flutter 모바일 앱 - 피트니스 트래커 (소셜 기능 포함)
/team:up 풀스택 웹앱 - 사내 HR 도구
```

PM이 프로젝트를 분석하고, 팀을 제안한 뒤, 페이즈별로 진행합니다.

### `/team:design` — 커스텀 팀 설계

```
/team:design IoT 스마트홈 통합 플랫폼
/team:design 실시간 분석 데이터 파이프라인
/team:design Apple Pencil iPad 드로잉 앱
```

도메인을 분석해서 범용 역할 카탈로그를 전문 역할로 매핑합니다.

## 역할 카탈로그

| 역할 | 설명 | 모델 | 복수 |
|------|------|------|------|
| pm | 요구사항, 계획, 경쟁 분석 | Opus | - |
| designer | UI/UX, 디자인 시스템, 와이어프레임 | Opus | - |
| ios-dev | iOS (SwiftUI/TCA) | Opus | O |
| flutter-dev | Flutter/Dart | Opus | O |
| frontend-dev | 웹 프론트엔드 | Opus | O |
| backend-dev | 백엔드 API | Opus | O |
| qa | 테스트, 코드 리뷰 | Opus | - |
| ui-tester | 디바이스/시뮬레이터 UI 테스트 | Opus | - |
| oracle | 크로스 모델 검증 (읽기 전용) | Sonnet | - |

비앱 도메인에서는 dev 역할이 도메인 전문가로 매핑됩니다:

| 도메인 | 가능한 역할 |
|--------|------------|
| IoT/인프라 | Platform Engineer, Integrator, Architect |
| 데이터 | ETL Engineer, ML Engineer, Schema Designer |
| CLI 도구 | Core Dev, Plugin Dev (designer 불필요) |

## 핵심 원칙

1. **요구사항 우선** — 요구사항 승인 전 코드 작성 금지
2. **TDD 필수** — 모든 코드는 테스트 먼저 (Red → Green → Refactor)
3. **파일 소유권** — 각 팀원은 자신의 디렉토리만 편집, 충돌 방지
4. **증거 기반 완료** — "완료"는 테스트 증거가 있어야만 선언
5. **멈추지 않는 개발** — Phase 2 이후 Phase 5까지 자동 진행
6. **피드백 루프** — QA에서 반복되는 패턴은 린트 룰로 전환

## 함께 사용하면 좋은 플러그인

### [claude-oracle](https://github.com/wanbok/claude-oracle)

크로스 모델 검증 플러그인. 설치하면 팀의 Oracle 역할이 자동으로 활용합니다:
- Phase Gate에서 아키텍처 리뷰
- 코드 리뷰 세컨드 오피니언
- 대안 구현 제안

### [superpowers](https://github.com/obra/superpowers)

brainstorming, writing-plans, test-driven-development 등의 스킬을 참조합니다.

## 커스터마이징

### 템플릿

프로젝트에 복사해서 커스터마이즈하세요:

- `templates/CLAUDE.md.template` — 프로젝트 CLAUDE.md에 추가할 팀 설정
- `templates/roles/` — 상세 역할 정의 (pm, designer, dev, qa, oracle)

### 예시

- `examples/ios-app-team.md` — iOS SwiftUI + TCA 팀
- `examples/flutter-app-team.md` — Flutter 모바일 팀
- `examples/web-service-team.md` — 풀스택 웹 팀

## 라이선스

MIT
