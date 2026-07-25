<p align="center">
  <img src="assets/banner.jpg" alt="Custom Agent AGY Banner" width="100%"/>
</p>

<h1 align="center">Custom Agent AGY</h1>

<p align="center">
  <strong>Bộ 8 AI Agents chuyên biệt — phủ toàn bộ quy trình phát triển phần mềm từ phân tích yêu cầu đến triển khai production.</strong>
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
- [Triết Lý Thiết Kế](#triết-lý-thiết-kế)
- [Danh Sách 8 Agents](#danh-sách-8-agents)
- [Kiến Trúc Pipeline 8 Giai Đoạn](#kiến-trúc-pipeline-8-giai-đoạn)
- [Hướng Dẫn Cài Đặt & Sử Dụng](#hướng-dẫn-cài-đặt--sử-dụng)
- [Ví Dụ Thực Tế](#ví-dụ-thực-tế)
- [Tips & Tricks: BA Dùng AI Vẽ Flow Diagrams](#tips--tricks-ba-dùng-ai-vẽ-flow-diagrams)
- [Cấu Trúc Thư Mục](#cấu-trúc-thư-mục)
- [Tài Liệu Bổ Sung](#tài-liệu-bổ-sung)
- [Contributing](#contributing)
- [License](#license)

---

## Giới Thiệu

**Custom Agent AGY** là bộ sưu tập các **Custom Subagent System Prompts** được thiết kế để chạy trên nền tảng [Antigravity CLI](https://antigravity.dev) (v1.1.6+) hoặc bất kỳ AI Coding Agent nào hỗ trợ cơ chế `define_subagent` / `invoke_subagent`.

**Dành cho ai?**
- Solo developers muốn có quy trình phát triển chuẩn chỉnh như team chuyên nghiệp
- Team leads cần chuẩn hóa workflow cho đội ngũ
- Business Analysts muốn tận dụng AI cho requirement analysis & documentation
- Bất kỳ ai muốn tối ưu năng suất phát triển phần mềm với AI agents

**Tri thức tích hợp từ:**

```mermaid
mindmap
  root((Custom Agent AGY))
    BA & QC Guidelines
      IEEE 29148 SRS
      ISTQB Test Design
      Gherkin AC Format
      BPMN 2.0 Modeling
    API Best Practices
      REST API Standards
      GraphQL & gRPC
      WebSocket & Webhooks
      MCP Protocol
    Production Standards
      Structured Logging JSON
      Error Tracking RFC 7807
      CI/CD GitHub Actions
      Conventional Commits
    Agent Templates
      Auth & Security
      Bug Fixing
      Database Design
      Codebase Analysis
```

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

### Bản đồ thực thi song song

```
┌─────────────────────────────────────────────────────────────────┐
│ Timeline    T1      T2           T3        T4       T5     T6  │
│            ┌───┐  ┌───┬───┐   ┌───┐     ┌───┐   ┌───┬───┐┌──┐│
│ Agents     │ ① │→ │ ② │ ③ │→ │ ④ │  →  │ ⑤ │→ │ ⑥ │ ⑦ ││⑧ ││
│            │BA │  │Ar │QC │   │Res│     │Dev│   │Log│Doc││Gt ││
│            └───┘  └───┴───┘   └───┘     └───┘   └───┴───┘└──┘│
│                   (parallel)                     (parallel)    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Hướng Dẫn Cài Đặt & Sử Dụng

### Yêu cầu

- [Antigravity CLI](https://antigravity.dev) >= 1.1.6 (hỗ trợ Custom Agents)
- Hoặc bất kỳ AI coding agent hỗ trợ `define_subagent` / `invoke_subagent`

### Cài đặt

```bash
git clone https://github.com/Le-Ngoc-Tu/custom_agent_agy.git
cd custom_agent_agy
```

### 3 Cách Sử Dụng

#### Cách 1: Kích hoạt toàn bộ Pipeline (Khuyến nghị)

Trong phiên Antigravity, yêu cầu:

```
Hãy dùng bộ custom agents trong E:\agent_resources\antigravity_custom_agents\
theo quy trình 8 giai đoạn để phát triển tính năng:

"Hệ thống đăng nhập/đăng ký với JWT, phân quyền RBAC, reset password qua email"
```

Antigravity sẽ tự động đọc các file `.md`, nạp từng agent qua `define_subagent` và điều phối theo pipeline.

#### Cách 2: Kích hoạt Agent đơn lẻ

```
Hãy đọc file ba-requirements-specialist.md và dùng nó làm system prompt
để define_subagent, rồi invoke nó để phân tích yêu cầu cho tính năng:
"Module quản lý đơn hàng với workflow: Draft → Confirmed → Shipping → Delivered"
```

#### Cách 3: Tham chiếu như Knowledge Base

```
Khi viết code cho API endpoint mới, hãy tham khảo file api-db-architect.md
để tuân thủ error format RFC 7807 và logging contract standards.
```

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

### Ví dụ output từ ⑥ Logging Agent

```json
{
  "timestamp": "2026-07-25T14:00:00.000Z",
  "level": "info",
  "service": "auth-service",
  "traceId": "req_abc123",
  "event": "auth.login.success",
  "metadata": {
    "userId": "usr_456",
    "method": "POST",
    "path": "/api/v1/auth/login",
    "statusCode": 200,
    "duration": 145
  }
}
```

---

## Tips & Tricks: BA Dùng AI Vẽ Flow Diagrams

> **Mẹo thực tế:** Ngoài viết code, bộ agents này còn hỗ trợ BA/PM tạo tài liệu chuyên nghiệp với hình ảnh đẹp mắt.

### Vấn đề thực tế

Khi làm BA, bạn thường phải giải thích luồng hệ thống cho cả 2 phía:
- **Dev team** cần endpoint, payload, error codes
- **Stakeholders** chỉ cần biết "data chạy từ đâu sang đâu"

### Giải pháp: Dùng AI Agent + Mermaid/PlantUML

**Bước 1:** Yêu cầu agent vẽ flow bằng Mermaid:

```
Vẽ API flow diagram cho Loan Origination System:
1. User nộp form → Frontend
2. Frontend gọi Middleware
3. Middleware gọi Credit Bureau API lấy credit score
4. Middleware gửi data tổng hợp sang Underwriting API
5. Underwriting trả quyết định → User

Dùng Mermaid sequence diagram, label rõ từng component.
```

**Output Mermaid:**

```mermaid
sequenceDiagram
    actor User as 👤 Khách hàng
    participant FE as Frontend
    participant MW as Middleware
    participant CB as Credit Bureau API
    participant UW as Underwriting System

    User->>FE: Nộp đơn vay (form data)
    FE->>MW: POST /api/v1/loans/apply
    MW->>CB: GET /credit-score?ssn=***
    CB-->>MW: { score: 720, history: "good" }
    MW->>UW: POST /underwrite { loan + credit_data }
    UW-->>MW: { decision: "APPROVED", limit: 50000 }
    MW-->>FE: { status: "approved", loanId: "LN-001" }
    FE-->>User: Hiển thị kết quả: Đơn vay được duyệt ✅
```

**Bước 2:** Yêu cầu agent tóm tắt bằng ngôn ngữ nghiệp vụ:

```
Viết lại giải thích flow trên bằng ngôn ngữ nghiệp vụ cho stakeholders.
```

> **Output:** "Khi khách hàng nộp đơn xin vay, hệ thống tự động kiểm tra điểm tín dụng qua API của Trung tâm Thông tin Tín dụng. Sau đó, toàn bộ hồ sơ (thông tin cá nhân + điểm tín dụng) được gửi sang hệ thống Thẩm định để ra quyết định phê duyệt. Kết quả cuối cùng hiển thị lại cho khách hàng trên giao diện."

**Bước 3:** Kết hợp `⑦ Docs Agent` + tool `generate_image` để tạo hình ảnh cho tài liệu BRD:

```
Dùng agent docs-readme-specialist với tool generate_image
để tạo ảnh architecture diagram chuyên nghiệp cho tài liệu BRD
dự án Loan Origination System.
```

> **Kết quả:** Combo 1 hình trực quan cho Dev + 1 đoạn giải thích cho Sếp → bê thẳng vào BRD hoặc Confluence.

### PlantUML Alternative

Nếu team dùng PlantUML thay vì Mermaid, cùng flow trên sẽ là:

```plantuml
@startuml
actor "Khách hàng" as User
participant "Frontend" as FE
participant "Middleware" as MW
participant "Credit Bureau" as CB
participant "Underwriting" as UW

User -> FE: Nộp đơn vay
FE -> MW: POST /api/v1/loans/apply
MW -> CB: GET /credit-score
CB --> MW: score: 720
MW -> UW: POST /underwrite
UW --> MW: decision: APPROVED
MW --> FE: loanId: LN-001
FE --> User: Đơn vay được duyệt ✅
@enduml
```

---

## Cấu Trúc Thư Mục

```
custom_agent_agy/
├── README.md                              # Tài liệu chính (file này)
├── .gitignore                             # Git ignore rules
├── full_lifecycle_workflow_guide.md        # Hướng dẫn điều phối 8 giai đoạn
├── assets/
│   └── banner.jpg                         # Banner image cho README
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
| [Workflow Guide](full_lifecycle_workflow_guide.md) | Hướng dẫn điều phối đầy đủ 8 giai đoạn + Parallel Execution Map |
| [Usage Guide](docs/USAGE_GUIDE.md) | Hướng dẫn chi tiết từng agent: mô tả, prompt mẫu, output mẫu |
| [BA AI Flow Tips](docs/TIPS_BA_AI_FLOW.md) | Mẹo BA dùng AI vẽ Flow Diagrams + tạo tài liệu chuyên nghiệp |

---

## Contributing

1. Fork repository
2. Tạo branch: `git checkout -b feature/agent-improvement`
3. Commit theo **Conventional Commits**: `feat(agent): add new capability`
4. Push và tạo Pull Request

**Conventional Commits format:**

```
feat(scope): tính năng mới
fix(scope): sửa lỗi
docs: thay đổi tài liệu
refactor(scope): tái cấu trúc
test(scope): thêm/sửa tests
chore: build, CI, dependencies
```

---

## License

MIT License — Xem [LICENSE](LICENSE) để biết chi tiết.

---

<p align="center">
  <strong>Built with ❤️ by <a href="https://github.com/Le-Ngoc-Tu">Le Ngoc Tu</a></strong>
</p>
