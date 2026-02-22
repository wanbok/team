# team

Điều phối đội ngũ đa agent động cho [Claude Code](https://claude.com/claude-code). Tạo các đội chuyên biệt xây dựng dự án của bạn qua các giai đoạn có cấu trúc — từ yêu cầu đến production.

[한국어](README.md) | [English](README.en.md) | [日本語](README.ja.md)

## Làm gì

Thay vì một AI code một mình, framework này tạo ra **đội ngũ agent chuyên biệt** cộng tác như một đội phát triển thực sự:

```
Bạn (Leader)
├── PM           — thu thập yêu cầu, phân tách task
├── Designer     — UI spec, design system
├── Dev A        — triển khai Feature A (TDD)
├── Dev B        — triển khai Feature B (TDD)
├── QA           — code review, testing
└── Oracle       — xác minh chéo mô hình (tùy chọn)
```

Đội ngũ tuân theo **pipeline 6 giai đoạn** với quality gate:

```
Phase 0: Thành lập đội [bạn duyệt]
  → Phase 1: Yêu cầu [bạn duyệt]
  → Phase 2: Thiết kế [bạn duyệt]
  → Phase 3: Phát triển [tự động — TDD, song song]
  → Phase 4: QA [tự động — testing, review]
  → Phase 5: Hoàn thiện [tự động — build, xác minh]
```

Bạn duyệt Phase 0-2, sau đó đội ngũ tự động chạy từ 3-5.

## Cài đặt

### Claude Code Plugin (khuyến nghị)

```bash
# Qua marketplace (nếu đã đăng ký)
/plugin install team@wanbok-claude-marketplace

# Hoặc trực tiếp từ GitHub
/plugin install --source github:wanbok/team
```

### Cài đặt thủ công

```bash
git clone https://github.com/wanbok/team.git
cd team
chmod +x install.sh
./install.sh
```

## Cách sử dụng

### `/team:up` — Khởi động đội

```
/team:up SwiftUI + TCA iOS app - sàn nhận nuôi thú cưng
/team:up Flutter mobile app - fitness tracker có tính năng xã hội
/team:up Full-stack web app - công cụ HR nội bộ
```

PM sẽ phân tích dự án, đề xuất đội ngũ, và hướng dẫn qua từng phase.

### `/team:design` — Thiết kế đội tùy chỉnh

```
/team:design Nền tảng tích hợp IoT smart home
/team:design Data pipeline phân tích real-time
/team:design Ứng dụng vẽ iPad hỗ trợ Apple Pencil
```

Phân tích domain và ánh xạ catalog vai trò chung sang vai trò chuyên biệt.

## Catalog vai trò

| Vai trò | Mô tả | Model | Nhiều |
|---------|-------|-------|-------|
| pm | Yêu cầu, lập kế hoạch, phân tích cạnh tranh | Opus | - |
| designer | UI/UX, design system, wireframe | Opus | - |
| ios-dev | iOS (SwiftUI/TCA) | Opus | Có |
| flutter-dev | Flutter/Dart | Opus | Có |
| frontend-dev | Web frontend | Opus | Có |
| backend-dev | Backend API | Opus | Có |
| qa | Testing, code review | Opus | - |
| ui-tester | Device/simulator UI testing | Opus | - |
| oracle | Xác minh chéo mô hình (chỉ đọc) | Sonnet | - |

Với domain không phải app, vai trò dev được ánh xạ sang chuyên gia domain:

| Domain | Vai trò có thể |
|--------|---------------|
| IoT/Infra | Platform Engineer, Integrator, Architect |
| Data | ETL Engineer, ML Engineer, Schema Designer |
| CLI Tools | Core Dev, Plugin Dev (không cần designer) |

## Nguyên tắc cốt lõi

1. **Yêu cầu trước** — không code trước khi yêu cầu được duyệt
2. **TDD bắt buộc** — mọi code bắt đầu từ test (Red → Green → Refactor)
3. **Quyền sở hữu file** — mỗi thành viên chỉ sửa thư mục của mình, tránh xung đột
4. **Hoàn thành dựa trên bằng chứng** — "xong" phải có bằng chứng test
5. **Phát triển không ngừng** — sau Phase 2, đội không dừng cho đến Phase 5
6. **Feedback loop** — pattern QA lặp lại được chuyển thành lint rule

## Plugin kết hợp tốt

### [oracle](https://github.com/wanbok/oracle)

Plugin xác minh chéo mô hình. Khi cài đặt, vai trò Oracle trong đội tự động sử dụng cho:
- Review kiến trúc tại Phase Gate
- Second opinion cho code review
- Đề xuất triển khai thay thế

### [superpowers](https://github.com/obra/superpowers)

Framework tham chiếu các skill superpowers (brainstorming, writing-plans, test-driven-development, v.v.).

## Tùy chỉnh

### Template

Copy và tùy chỉnh cho dự án của bạn:

- `templates/CLAUDE.md.template` — cấu hình team thêm vào CLAUDE.md của dự án
- `templates/roles/` — định nghĩa vai trò chi tiết (pm, designer, dev, qa, oracle)

### Ví dụ

- `examples/ios-app-team.md` — iOS SwiftUI + TCA team
- `examples/flutter-app-team.md` — Flutter mobile team
- `examples/web-service-team.md` — Full-stack web team

## Cấu trúc plugin

```
team/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (name: "team")
├── commands/
│   ├── up.md                # /team:up — khởi động đội
│   └── design.md            # /team:design — thiết kế đội tùy chỉnh
├── skills/
│   └── workflow/
│       └── SKILL.md         # Hướng dẫn workflow theo phase
├── agents/
│   └── reviewer.md          # Phase 0 reviewer thành phần đội
├── templates/
│   ├── CLAUDE.md.template   # Template cấu hình dự án
│   └── roles/               # Định nghĩa vai trò
├── examples/                # Ví dụ team composition
├── install.sh               # Cài đặt thủ công
└── uninstall.sh             # Gỡ cài đặt
```

## Giấy phép

MIT
