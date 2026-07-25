<p align="center">
  <img src="assets/banner.jpg" alt="Custom Agent AGY Banner" width="100%"/>
</p>

<h1 align="center">Custom Agent AGY</h1>

<p align="center">
  <strong>Bộ 8 AI Agents chuyên biệt — phủ toàn bộ quy trình phát triển phần mềm từ phân tích yêu cầu đến triển khai production.</strong>
</p>

<p align="center">
  <a href="README.md"><strong>🇻🇳 Tiếng Việt</strong></a> | <a href="README_EN.md"><strong>🇺🇸 English</strong></a> | <a href="README_ZH.md"><strong>🇨🇳 简体中文</strong></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/agents-8-blue?style=for-the-badge" alt="Agents"/>
  <img src="https://img.shields.io/badge/pipeline-8_stages-brightgreen?style=for-the-badge" alt="Pipeline"/>
  <img src="https://img.shields.io/badge/version-2.0.0-orange?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License"/>
  <img src="https://img.shields.io/badge/platform-Antigravity_CLI-purple?style=for-the-badge" alt="Platform"/>
</p>

---

## Mục Lục

- [Giới Thiệu](#giới-thiệu)
- [Cơ Chế Tự Động Chọn Agent & Spawn Subagents](#cơ-chế-tự-động-chọn-agent--spawn-subagents)
- [Triết Lý Thiết Kế](#triết-lý-thiết-kế)
- [Danh Sách 8 Agents](#danh-sách-8-agents)
- [Kiến Trúc Pipeline 8 Giai Đoạn](#kiến-trúc-pipeline-8-giai-đoạn)
- [Cài Đặt Tự Động 1-Click Global](#cài-đặt-tự-động-1-click-global)
- [Cách Mở Bảng Điều Khiển (`/agents`)](#cách-mở-bảng-điều-khiển-agents)
- [Ví Dụ Thực Tế](#ví-dụ-thực-tế)
- [Tips & Tricks: BA Dùng AI Vẽ Flow Diagrams](#tips--tricks-ba-dùng-ai-vẽ-flow-diagrams)
- [Cấu Trúc Thư Mục](#cấu-trúc-thư-mục)
- [Tài Liệu Bổ Sung](#tài-liệu-bổ-sung)
- [Contributing](#contributing)
- [License](#license)

---

## Giới Thiệu

**Custom Agent AGY** là bộ sưu tập các **Custom System Prompts** được thiết kế để chạy trên nền tảng [Antigravity CLI](https://antigravity.dev) (v1.1.6+) hoặc bất kỳ AI Coding Agent nào hỗ trợ cơ chế `define_subagent` / `invoke_subagent`.

**Dành cho ai?**
- Solo developers muốn có quy trình phát triển chuẩn chỉnh như team chuyên nghiệp
- Team leads cần chuẩn hóa workflow cho đội ngũ
- Business Analysts muốn tận dụng AI cho requirement analysis & documentation
- Bất kỳ ai muốn tối ưu năng suất phát triển phần mềm với AI agents

---

## Cơ Chế Tự Động Chọn Agent & Spawn Subagents

Trong phiên bản mới nhất của **Antigravity CLI (v1.1.6+)**, khi các custom agents đã được cài đặt vào hệ thống Global (`~/.gemini/config/agents/`), Antigravity sẽ tự động hoạt động theo cơ chế **Orchestrator Dynamic Spawning**:

```mermaid
flowchart TD
    UserReq["👤 Người dùng: 'Xây dựng tính năng X'"] --> Orch["🤖 Primary Agent (Orchestrator)"]
    Orch -->|Đọc metadata YAML frontmatter| Scan["🔍 Quét danh sách Global Agents\n~/.gemini/config/agents/"]
    Scan --> AutoSelect["⚡ Tự động chọn Agent phù hợp\ntheo vai trò và nhiệm vụ"]
    AutoSelect --> Spawn1["① Spawn ba-requirements-specialist"]
    AutoSelect --> Spawn2["② Spawn api-db-architect (song song)"]
    AutoSelect --> Spawn3["③ Spawn qc-verification-specialist (song song)"]
    AutoSelect --> Spawn4["⑤ Spawn dev-security-implementer"]
    AutoSelect --> Spawn5["... Spawn các agents còn lại theo pipeline"]
```

### Điểm nổi bật:

1. **Auto Agent Selection:** Bạn không cần phải chọn thủ công từng agent. Orchestrator Agent sẽ tự động đọc `name` và `description` trong YAML frontmatter để chọn đúng agent cho từng công việc.
2. **Dynamic Subagent Spawning:** Orchestrator tự động gọi `invoke_subagent` để spawn các subagents chạy song song (ví dụ: Architect + QC Test) hoặc chạy tuần tự theo quy trình pipeline 8 giai đoạn.
3. **Chuyển đổi thủ công (Nếu muốn):** Bạn vẫn có thể gõ `/agents` trong TUI để chủ động switch sang một agent cụ thể bất kỳ lúc nào.

---

## Triết Lý Thiết Kế

Tất cả agents được xây dựng trên 5 nguyên tắc cốt lõi, encode dưới dạng DSL để agent đọc hiểu:

```yaml
# design_philosophy.dsl
principles:
  - id: P1
    name: "Lựa chọn hơn nỗ lực"
    rule: "Chọn thư viện chuẩn công nghiệp (pino, Zod, Prisma), KHÔNG tự chế"
    example: "Dùng bcrypt/argon2 cho password hashing, không viết crypto riêng"

  - id: P2
    name: "Đơn giản hơn phức tạp"
    rule: "Early return, single responsibility, no premature abstraction"
    example: "Chỉ tách helper khi có >= 3 nơi dùng NGAY BÂY GIỜ"

  - id: P3
    name: "Hiệu suất có đo lường"
    rule: "Chỉ tối ưu nơi đo được bottleneck, không premature optimize"
    example: "Thêm index SAU KHI EXPLAIN cho thấy full table scan"

  - id: P4
    name: "Giám sát từ Dev đến Production"
    rule: "Structured logging, correlation ID, error tracking từ ngày đầu"
    example: "Mỗi request handler phải có requestId xuyên suốt"

  - id: P5
    name: "Mỗi dòng log phải có ý nghĩa"
    rule: "JSON structured, trả lời được: Gì xảy ra? Với ai? Kết quả?"
    example: |
      logger.info({
        event: "order.created",
        orderId: "ord_123",
        userId: "usr_456",
        duration: 145
      })

agent_structure:
  format: "4-part harness"
  sections:
    - "1. ROLE & IDENTITY — Vai trò và chuyên môn"
    - "2. SAFETY CONSTRAINTS — Hàng rào an toàn, điều cấm kỵ"
    - "3. QUALITY STANDARDS — Tiêu chuẩn chất lượng code & output"
    - "4. TOOLS & EXECUTION — Tools cụ thể + quy trình thực thi"
```

---

## Danh Sách 8 Agents

```mermaid
block-beta
  columns 4
  ba["① BA\nRequirements\nSpecialist"]:1
  arch["② API & DB\nArchitect"]:1
  qc["③ QC\nVerification\nSpecialist"]:1
  res["④ Codebase\nResearcher"]:1
  dev["⑤ Developer\n& Security"]:1
  log["⑥ Logging &\nObservability"]:1
  docs["⑦ Docs &\nREADME"]:1
  git["⑧ DevOps\n& Git"]:1
```

| # | Agent | File | Mô tả ngắn | Tools |
|:-:|-------|------|-------------|-------|
| ① | **BA Requirements Specialist** | [`ba-requirements-specialist.md`](ba-requirements-specialist.md) | Phân tích yêu cầu, User Stories, Acceptance Criteria (Gherkin), NFRs | read, write, search_web |
| ② | **API & DB Architect** | [`api-db-architect.md`](api-db-architect.md) | API Contracts (REST/GraphQL), DB Schema, Error Standard RFC 7807, Logging Contract | read, write |
| ③ | **QC Verification Specialist** | [`qc-verification-specialist.md`](qc-verification-specialist.md) | Test Matrix, Automation Tests (AAA Pattern), Log Verification, Regression | read, write, shell |
| ④ | **Codebase Researcher** | [`codebase-researcher.md`](codebase-researcher.md) | Scan codebase, Pattern Learning, Logging Audit, Impact Analysis, Roadmap | read, shell, search_web |
| ⑤ | **Developer & Security** | [`dev-security-implementer.md`](dev-security-implementer.md) | Code implementation, Auth/RBAC, Structured Logging JSON, Custom Error Classes | read, write, shell |
| ⑥ | **Logging & Observability** | [`logging-observability-specialist.md`](logging-observability-specialist.md) | Log Schema Design, Logger Setup (pino/structlog), Correlation ID, Error Tracking | read, write, shell, search_web |
| ⑦ | **Docs & README** | [`docs-readme-specialist.md`](docs-readme-specialist.md) | README.md, .gitignore, CHANGELOG, .env.example, Architecture Diagrams | read, write, search_web, generate_image |
| ⑧ | **DevOps & Git** | [`devops-git-specialist.md`](devops-git-specialist.md) | Conventional Commits, Branch Strategy, CI/CD Pipeline (GitHub Actions), SemVer | read, write, shell |

---

## Kiến Trúc Pipeline 8 Giai Đoạn

### Tổng quan luồng xử lý

```mermaid
flowchart LR
    subgraph "Phase 1: Phân tích"
        S1["① BA\nRequirements"]
    end

    subgraph "Phase 2: Thiết kế (Song song)"
        S2["② API & DB\nArchitect"]
        S3["③ QC Test\nStrategy"]
    end

    subgraph "Phase 3: Chuẩn bị"
        S4["④ Codebase\nResearcher"]
    end

    subgraph "Phase 4: Thực thi"
        S5["⑤ Developer\n& Security"]
    end

    subgraph "Phase 5: Hoàn thiện (Song song)"
        S6["⑥ Logging\nSetup"]
        S7["⑦ Docs &\nREADME"]
    end

    subgraph "Phase 6: Bàn giao"
        S8["⑧ DevOps\nGit & CI/CD"]
    end

    S1 --> S2 & S3
    S2 & S3 --> S4
    S4 --> S5
    S5 --> S6 & S7
    S6 & S7 --> S8
```

### Luồng chi tiết (Sequence Diagram)

```mermaid
sequenceDiagram
    autonumber
    actor User as 👤 Người dùng
    participant AG as 🤖 Orchestrator
    participant BA as ① BA
    participant Arch as ② Architect
    participant QC as ③ QC
    participant Res as ④ Researcher
    participant Dev as ⑤ Developer
    participant Log as ⑥ Logging
    participant Doc as ⑦ Docs
    participant Git as ⑧ DevOps

    User->>AG: "Xây dựng tính năng X"

    rect rgb(230, 245, 255)
        Note over AG,BA: Giai đoạn 1 — Phân tích yêu cầu
        AG->>BA: Phân tích requirement
        BA-->>AG: SRS + User Stories + AC + NFRs
    end

    rect rgb(230, 255, 230)
        Note over Arch,QC: Giai đoạn 2-3 — Song song
        par
            AG->>Arch: Thiết kế API & DB
            AG->>QC: Lập Test Strategy
        end
        Arch-->>AG: API Contracts + Schema + Logging Contract
        QC-->>AG: Test Matrix + Test Plan
    end

    rect rgb(255, 245, 230)
        Note over AG,Res: Giai đoạn 4 — Khảo sát codebase
        AG->>Res: Scan & Impact Analysis
        Res-->>AG: Roadmap + Conventions + Gaps
    end

    rect rgb(255, 230, 230)
        Note over AG,Dev: Giai đoạn 5 — Lập trình
        AG->>Dev: Code + Auth + Logging
        Dev-->>AG: Source code + Security audit
    end

    rect rgb(240, 230, 255)
        Note over Log,Doc: Giai đoạn 6-7 — Song song
        par
            AG->>Log: Setup logging & error tracking
            AG->>Doc: Tạo README, .gitignore, CHANGELOG
        end
        Log-->>AG: Logger + Error handler + Correlation ID
        Doc-->>AG: Tài liệu hoàn chỉnh
    end

    rect rgb(245, 245, 220)
        Note over AG,QC: Kiểm thử cuối
        AG->>QC: Chạy test suite + verify logs
        QC-->>AG: Test Evidence + Verification Report
    end

    rect rgb(220, 220, 245)
        Note over AG,Git: Giai đoạn 8 — Bàn giao
        AG->>Git: Commit + Push + CI/CD
        Git-->>AG: Release tagged
    end

    AG-->>User: ✅ Báo cáo hoàn thành
```

---

## Cài Đặt Tự Động 1-Click Global

Sau khi clone repo về máy, bạn chỉ cần chạy **1 lệnh duy nhất** để cài đặt toàn bộ 8 agents vào hệ thống Global Config của Antigravity CLI (`~/.gemini/config/agents/`):

### Trên Windows (PowerShell):

```powershell
.\scripts\setup_global.ps1
```

### Trên Linux / macOS (Bash):

```bash
bash scripts/setup_global.sh
```

---

## Cách Mở Bảng Điều Khiển (`/agents`)

Trong Antigravity CLI, gõ lệnh sau để mở giao diện quản lý agents:

```bash
/agents
```

### Màn hình quản lý Agents (TUI Panel)

Giao diện sẽ tự động quét và hiển thị cả 8 custom agents dưới mục **Available Agents**:

```
┌─────────────────────────────────────────────────────────────┐
│                       AGENTS MANAGER                        │
├─────────────────────────────────────────────────────────────┤
│ Available Agents                                            │
│   ● Default Agent                                           │
│     ba-requirements-specialist                              │
│     api-db-architect                                        │
│     qc-verification-specialist                              │
│     codebase-researcher                                     │
│     dev-security-implementer                                │
│     logging-observability-specialist                        │
│     docs-readme-specialist                                  │
│     devops-git-specialist                                   │
└─────────────────────────────────────────────────────────────┘
```

1. **Chọn Agent:** Phím `↑ / ↓` để chọn, nhấn `Enter` để kích hoạt (`●` biểu tượng màu xanh).
2. **Áp dụng:** Nhấn `Esc` để đóng panel và bắt đầu chat với agent được chọn.

---

## Ví Dụ Thực Tế

### Use Case: Xây dựng hệ thống Authentication

```mermaid
flowchart TD
    subgraph "① BA Agent phân tích"
        BA1["User Story: As a user,\nI want to login with email/password"]
        BA2["AC: Given valid credentials\nWhen POST /auth/login\nThen return JWT tokens"]
        BA3["NFR: Rate limit 5 req/min\nLog every login attempt"]
    end

    subgraph "② Architect Agent thiết kế"
        AR1["POST /api/v1/auth/login\nPOST /api/v1/auth/register\nPOST /api/v1/auth/refresh"]
        AR2["users table: id, email,\npassword_hash, role, created_at"]
        AR3["Logging Contract:\nauth.login.success → INFO\nauth.login.failed → WARN"]
    end

    subgraph "⑤ Developer Agent code"
        DEV1["authService.ts\nauthController.ts\nauthMiddleware.ts"]
        DEV2["Argon2 hashing\nJWT access + refresh\nZod validation"]
    end

    BA1 & BA2 & BA3 --> AR1 & AR2 & AR3
    AR1 & AR2 & AR3 --> DEV1 & DEV2
```

---

## Tips & Tricks: BA Dùng AI Vẽ Flow Diagrams

> **Mẹo thực tế:** Ngoài viết code, bộ agents này còn hỗ trợ BA/PM tạo tài liệu chuyên nghiệp với hình ảnh đẹp mắt.

### Vấn đề thực tế

Khi làm BA, bạn thường đứng giữa ngã ba đường:
- **Dev team** cần endpoint, payload, error codes
- **Stakeholders** chỉ cần biết "data chạy từ đâu sang đâu"

### Giải pháp: Dùng AI Agent + Mermaid/PlantUML

```mermaid
sequenceDiagram
    actor Customer as 👤 Khách hàng
    participant FE as Frontend
    participant MW as Middleware
    participant CB as Credit Bureau API
    participant UW as Underwriting System

    Customer->>FE: Nộp đơn vay (form data)
    FE->>MW: POST /api/v1/loans/apply
    MW->>CB: GET /credit-score?ssn=***
    CB-->>MW: { score: 720, history: "good" }
    MW->>UW: POST /underwrite { loan + credit_data }
    UW-->>MW: { decision: "APPROVED", limit: 500M }
    MW-->>FE: { status: "approved", loanId: "LN-001" }
    FE-->>Customer: Hiển thị kết quả: Đơn vay được duyệt ✅
```

---

## Cấu Trúc Thư Mục

```
custom_agent_agy/
├── README.md                              # Tài liệu chính (Tiếng Việt)
├── README_EN.md                           # Main English README
├── README_ZH.md                           # 简体中文 README
├── .gitignore                             # Git ignore rules
├── full_lifecycle_workflow_guide.md        # Hướng dẫn điều phối 8 giai đoạn
├── assets/
│   └── banner.jpg                         # Banner image cho README
├── scripts/
│   ├── setup_global.ps1                   # 1-Click setup script cho Windows
│   └── setup_global.sh                    # 1-Click setup script cho Linux/macOS
├── docs/
│   ├── USAGE_GUIDE.md                     # Hướng dẫn sử dụng chi tiết
│   └── TIPS_BA_AI_FLOW.md                 # Tips BA dùng AI vẽ Flow Diagrams
│
├── # --- 8 Custom Agent Prompts ---
├── ba-requirements-specialist.md          # ① BA Agent
├── api-db-architect.md                    # ② Architect Agent
├── qc-verification-specialist.md          # ③ QC Agent
├── codebase-researcher.md                 # ④ Researcher Agent
├── dev-security-implementer.md            # ⑤ Developer Agent
├── logging-observability-specialist.md    # ⑥ Logging Agent
├── docs-readme-specialist.md              # ⑦ Docs Agent
└── devops-git-specialist.md               # ⑧ DevOps Agent
```

---

## Tài Liệu Bổ Sung

| Tài liệu | Mô tả |
|-----------|--------|
| [English Version](README_EN.md) | Full English documentation of Custom Agent AGY |
| [Chinese Version](README_ZH.md) | Custom Agent AGY 简体中文完整文档 |
| [Workflow Guide](full_lifecycle_workflow_guide.md) | Hướng dẫn điều phối đầy đủ 8 giai đoạn + Parallel Execution Map |
| [Usage Guide](docs/USAGE_GUIDE.md) | Hướng dẫn chi tiết từng agent: mô tả, prompt mẫu, output mẫu |
| [BA AI Flow Tips](docs/TIPS_BA_AI_FLOW.md) | Mẹo BA dùng AI vẽ Flow Diagrams + tạo tài liệu chuyên nghiệp |

---

## Contributing

1. Fork repository
2. Tạo branch: `git checkout -b feature/agent-name-improvement`
3. Commit theo Conventional Commits: `feat(agent): add new capability`
4. Push và tạo Pull Request

---

## License

MIT License — Xem [LICENSE](LICENSE) để biết chi tiết.

---

<p align="center">
  <strong>Built with ❤️ by <a href="https://github.com/Le-Ngoc-Tu">Le Ngoc Tu</a></strong>
</p>
