# team

[Claude Code](https://claude.com/claude-code)向けの動的マルチエージェントチームオーケストレーション。要件定義からプロダクションまで、構造化されたフェーズを通じて専門エージェントチームを生成します。

[한국어](README.md) | [English](README.en.md) | [Tiếng Việt](README.vi.md)

## 何をするか

AIが一人でコーディングする代わりに、実際の開発チームのように**専門エージェントチーム**が協力します：

```
あなた (リーダー)
├── PM           — 要件収集、タスク分解
├── Designer     — UIスペック、デザインシステム
├── Dev A        — Feature A実装 (TDD)
├── Dev B        — Feature B実装 (TDD)
├── QA           — コードレビュー、テスト
└── Oracle       — クロスモデル検証 (オプション)
```

チームは**6フェーズパイプライン**と品質ゲートに従います：

```
Phase 0: チーム構成 [ユーザー承認]
  → Phase 1: 要件定義 [ユーザー承認]
  → Phase 2: 設計 [ユーザー承認]
  → Phase 3: 開発 [自動 — TDD、並列]
  → Phase 4: QA [自動 — テスト、レビュー]
  → Phase 5: 完成 [自動 — ビルド、検証]
```

Phase 0〜2はユーザーが承認し、その後3〜5はチームが自律的に進行します。

## インストール

### Claude Codeプラグイン（推奨）

```bash
# マーケットプレイス登録後
/plugin install team@wanbok-claude-marketplace

# またはGitHubから直接
/plugin install --source github:wanbok/team
```

### 手動インストール

```bash
git clone https://github.com/wanbok/team.git
cd team
chmod +x install.sh
./install.sh
```

## 使い方

### `/team:up` — チーム起動

```
/team:up SwiftUI + TCA iOSアプリ - ペット養子縁組マーケットプレイス
/team:up Flutter モバイルアプリ - フィットネストラッカー（ソーシャル機能付き）
/team:up フルスタックWebアプリ - 社内HRツール
```

PMがプロジェクトを分析し、チームを提案し、フェーズごとに進行します。

### `/team:design` — カスタムチーム設計

```
/team:design IoTスマートホーム統合プラットフォーム
/team:design リアルタイム分析データパイプライン
/team:design Apple Pencil iPad ドローイングアプリ
```

ドメインを分析して汎用ロールカタログを専門ロールにマッピングします。

## ロールカタログ

| ロール | 説明 | モデル | 複数 |
|--------|------|--------|------|
| pm | 要件、計画、競合分析 | Opus | - |
| designer | UI/UX、デザインシステム、ワイヤーフレーム | Opus | - |
| ios-dev | iOS (SwiftUI/TCA) | Opus | ○ |
| flutter-dev | Flutter/Dart | Opus | ○ |
| frontend-dev | Webフロントエンド | Opus | ○ |
| backend-dev | バックエンドAPI | Opus | ○ |
| qa | テスト、コードレビュー | Opus | - |
| ui-tester | デバイス/シミュレーターUIテスト | Opus | - |
| oracle | クロスモデル検証（読み取り専用） | Sonnet | - |

非アプリドメインではdevロールがドメインスペシャリストにマッピングされます：

| ドメイン | 可能なロール |
|----------|-------------|
| IoT/インフラ | Platform Engineer, Integrator, Architect |
| データ | ETL Engineer, ML Engineer, Schema Designer |
| CLIツール | Core Dev, Plugin Dev（designerは不要） |

## 核心原則

1. **要件優先** — 要件承認前のコード作成禁止
2. **TDD必須** — すべてのコードはテストから (Red → Green → Refactor)
3. **ファイル所有権** — 各チームメンバーは自分のディレクトリのみ編集、競合防止
4. **エビデンスベース完了** — 「完了」はテストエビデンスが必要
5. **ノンストップ開発** — Phase 2以降Phase 5まで自動進行
6. **フィードバックループ** — QAで繰り返されるパターンはリントルールに変換

## 一緒に使うと便利なプラグイン

### [oracle](https://github.com/wanbok/oracle)

クロスモデル検証プラグイン。インストールするとチームのOracleロールが自動的に活用します：
- Phase Gateでのアーキテクチャレビュー
- コードレビューのセカンドオピニオン
- 代替実装の提案

### [superpowers](https://github.com/obra/superpowers)

brainstorming、writing-plans、test-driven-developmentなどのスキルを参照します。

## カスタマイズ

### テンプレート

プロジェクトにコピーしてカスタマイズ：

- `templates/CLAUDE.md.template` — プロジェクトのCLAUDE.mdに追加するチーム設定
- `templates/roles/` — 詳細ロール定義 (pm, designer, dev, qa, oracle)

### サンプル

- `examples/ios-app-team.md` — iOS SwiftUI + TCA チーム
- `examples/flutter-app-team.md` — Flutter モバイルチーム
- `examples/web-service-team.md` — フルスタックWebチーム

## プラグイン構造

```
team/
├── .claude-plugin/
│   └── plugin.json          # プラグインマニフェスト (name: "team")
├── commands/
│   ├── up.md                # /team:up — チーム起動
│   └── design.md            # /team:design — カスタムチーム設計
├── skills/
│   └── workflow/
│       └── SKILL.md         # フェーズワークフローガイド
├── agents/
│   └── reviewer.md          # Phase 0 チーム構成レビュアー
├── templates/
│   ├── CLAUDE.md.template   # プロジェクト設定テンプレート
│   └── roles/               # ロール定義
├── examples/                # チーム構成サンプル
├── install.sh               # 手動インストール
└── uninstall.sh             # 手動アンインストール
```

## ライセンス

MIT
