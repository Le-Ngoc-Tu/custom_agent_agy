<p align="center">
  <img src="assets/banner.jpg" alt="Custom Agent AGY Banner" width="100%"/>
</p>

<h1 align="center">Custom Agent AGY</h1>

<p align="center">
  <strong>专为 Antigravity CLI 打造的 8 个专业 AI Agent 套件，覆盖从需求分析、架构设计、安全编码、日志规范、质量测试到 DevOps 的软件开发全生命周期。</strong>
</p>

<p align="center">
  <a href="README.md"><strong>🇻🇳 Tiếng Việt</strong></a> | <a href="README_EN.md"><strong>🇺🇸 English</strong></a> | <a href="README_ZH.md"><strong>🇨🇳 简体中文</strong></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/agents-8-blue?style=for-the-badge" alt="Agents"/>
  <img src="https://img.shields.io/badge/architecture-Graph_Topology-brightgreen?style=for-the-badge" alt="Architecture"/>
  <img src="https://img.shields.io/badge/version-2.5.0-orange?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/orchestration-Google_ADK_2-blueviolet?style=for-the-badge" alt="Orchestration"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License"/>
  <img src="https://img.shields.io/badge/platform-Antigravity_CLI-purple?style=for-the-badge" alt="Platform"/>
</p>

---

## 目录

- [项目概述](#项目概述)
- [确定性图编排架构 (ADK 2)](#确定性图编排架构-adk-2)
- [详细设计哲学 DSL](#详细设计哲学-dsl)
- [8 大 Agent 目录](#8-大-agent-目录)
- [8 阶段流水线架构](#8-阶段流水线架构)
- [一键全局安装](#一键全局安装)
- [如何使用面板选择 Agent (`/agents`)](#如何使用面板选择-agent-agents)
- [实际应用示例](#实际应用示例)
- [BA 技巧：如何使用 AI 绘制流程图](#ba-技巧如何使用-ai-绘制流程图)
- [目录结构](#目录结构)
- [补充文档](#补充文档)
- [贡献指南](#贡献指南)
- [开源协议](#开源协议)

---

## 项目概述

**Custom Agent AGY** 是专为 [Antigravity CLI](https://antigravity.dev) (v1.1.6+) 及支持 Subagent 机制的 AI 编码助手量身定制的**生产级 Custom System Prompts** 集合。

---

## 确定性图编排架构 (ADK 2)

在 **v2.5.0** 中，系统已全面升级为符合 Google ADK 2.0 标准的**确定性有向图编排模式 (Directed Graph Topology)**：

```mermaid
graph TD
    UserReq["👤 用户需求：'构建功能 X'"] --> NODE_BA["Node 1: ba-requirements-specialist<br/>模式: task desk"]
    NODE_BA --> GATE_SPEC{"确定性门禁:<br/>需求与 AC 是否已验证?"}
    
    GATE_SPEC -- 需求不明确 --> NODE_BA
    GATE_SPEC -- 验证通过 --> FORK_DESIGN["Fork: 并行技术设计分支"]
    
    FORK_DESIGN --> NODE_ARCH["Node 2a: api-db-architect<br/>模式: single_turn"]
    FORK_DESIGN --> NODE_OBS["Node 2b: logging-observability-specialist<br/>模式: single_turn"]
    FORK_DESIGN --> NODE_RES["Node 2c: codebase-researcher<br/>模式: dynamic exploration"]
    
    NODE_ARCH --> JOIN_DESIGN["JoinNode: 统一技术合同"]
    NODE_OBS --> JOIN_DESIGN
    NODE_RES --> JOIN_DESIGN
    
    JOIN_DESIGN --> NODE_DEV["Node 3: dev-security-implementer<br/>模式: execution"]
    NODE_DEV --> NODE_QC["Node 4: qc-verification-specialist<br/>模式: verification & router"]
    
    NODE_QC --> ROUTER_QC{"确定性路由器:<br/>测试 Exit Code == 0?"}
    ROUTER_QC -- "Exit Code != 0 & 循环 < 3<br/>Route: FIX_CYCLE" --> NODE_DEV
    ROUTER_QC -- "循环 >= 3<br/>Route: CIRCUIT_BREAKER" --> STOP_CIRCUIT(("紧急熔断器:<br/>向用户报告错误"))
    ROUTER_QC -- "Exit Code == 0<br/>Route: HANDOFF" --> FORK_HANDOFF["JoinNode: 并行交付分支"]
    
    FORK_HANDOFF --> NODE_DOCS["Node 5a: docs-readme-specialist"]
    FORK_HANDOFF --> NODE_DEVOPS["Node 5b: devops-git-specialist"]
    NODE_DOCS --> TERMINAL(("完成"))
    NODE_DEVOPS --> TERMINAL
```

---

## 详细设计哲学 DSL

所有 8 个 Agent 均构建于 5 大核心工程原则及 **4-Part Harness 架构**之上，并编码为机器可读的 DSL：

```yaml
# design_philosophy.dsl
version: "2.0.0"
description: "AI Agent 与软件工程师的架构设计原则"

principles:
  - id: P1
    name: "继承工业级标准 (Standardization over Reinvention)"
    rationale: "对于已有业界成熟解决方案的问题，绝不重新造轮子。"
    rule: "100% 优先使用工业级标准库 (如 pino, Zod, Prisma, Argon2, Redis)。切勿自定义加密算法、验证器或日志库。"
    boundary: "仅在当下无任何靠谱开源库满足要求时，才编写自定义代码。"
    good_example: "使用 Argon2id 进行密码哈希，使用 Zod 进行 Schema 校验，使用 Pino 进行结构化日志输出。"
    bad_example: "手写 SHA256 + Salt 密码哈希函数，或编写复杂的自定义正则表达式校验 Email。"

  - id: P2
    name: "简约设计与拒绝过早抽象 (Simplicity & YAGNI)"
    rationale: "非必要的代码即是技术债务，更是 Bug 的温床。"
    rule: "严格践行 YAGNI & KISS 原则。代码保持扁平 (Flat Code)，优先早返回 (Early Returns) 与单一职责。"
    boundary: "除非当下已有至少 3 处实际调用，否则严禁抽取抽象类、接口或通用 Helper 工具。"
    good_example: |
      if (!user) return res.status(404).json({ error: "USER_NOT_FOUND" });
      if (!user.isActive) return res.status(403).json({ error: "USER_INACTIVE" });
    bad_example: "仅为执行一条简单的 SELECT 查询就创建 GenericAbstractBaseUserRepositoryFactoryImpl。"

  - id: P3
    name: "基于经验数据的性能优化 (Data-Driven Optimization)"
    rationale: "缺乏数据支撑凭直觉优化只会增加代码复杂度，无法带来实际价值。"
    rule: "仅在 Profiler、指标监控或数据库 EXPLAIN 执行计划提供确凿证据时才进行性能优化。"
    boundary: "任何关于添加数据库索引、Redis 缓存或 Worker 线程的提议，必须附带优化前后的 Benchmark 对比。"
    good_example: "运行 EXPLAIN ANALYZE 发现全表扫描 -> 添加复合索引 (user_id, status)。"
    bad_example: "即便数据表只有 50 行静态数据，也强制给所有查询套上 Redis 缓存。"

  - id: P4
    name: "贯穿开发至生产的全流程可观测性 (Dev-to-Prod Observability)"
    rationale: "不可观测的系统无法在生产环境中稳定运行。"
    rule: "功能只有从第一行代码起内置结构化日志、Correlation ID 与错误追踪，才被视为完成 (Done)。"
    boundary: "所有 HTTP 请求、Cron Job 或消息队列必须端到端传递并继承 Correlation ID (requestId/traceId)。"
    good_example: "网关/中间件生成 X-Request-ID Header，并自动附加到该请求的每一行日志中。"
    bad_example: "在 Controller 捕捉到了异常并打印日志，却没有 Trace ID 用于追溯原始请求上下文。"

  - id: P5
    name: "每一行日志具备丰富上下文 (Context-Rich Structured Logging)"
    rule: "所有日志输出必须为 JSON 结构化格式，包含丰富上下文，便于机器与人工精准查询过滤。"
    boundary: "禁止使用 console.log('here')、console.log(err) 或无结构文本。每行日志必须回答：发生了什么？何时？涉及谁？结果如何？"
    good_example: |
      logger.info({
        timestamp: "2026-07-25T16:20:00.000Z",
        level: "info",
        traceId: "req_xyz789",
        event: "order.payment_processed",
        metadata: { orderId: "ord_123", userId: "usr_456", amount: 500000, durationMs: 142 }
      })
    bad_example: "console.log('Payment success for order ' + orderId);"

agent_structure:
  format: "4-Part Harness 架构"
  description: "每个 Agent System Prompt 的强制 4 部分结构，确保稳定性与安全防线"
  sections:
    - section: 1
      name: "ROLE & IDENTITY"
      purpose: "明确专业角色、领域边界与核心身份。"
      mandatory_elements: ["Agent 名称", "专业领域", "工作范围", "内置基础知识"]

    - section: 2
      name: "SAFETY CONSTRAINTS"
      purpose: "严格防线，防止破坏性或越界行为。"
      mandatory_elements: ["非破坏性规则", "代码修改边界", "输入校验要求", "禁止瞎猜规则"]

    - section: 3
      name: "QUALITY STANDARDS"
      purpose: "输出标准，确保交付生产级质量。"
      mandatory_elements: ["Clean Code 标准", "JSON 日志标准", "RFC 7807 错误格式", "测试与文档标准"]

    - section: 4
      name: "TOOLS & EXECUTION"
      purpose: "清晰的 3-4 步执行工作流与工具权限。"
      mandatory_elements: ["可用工具列表", "分步执行工作流", "输出格式模板"]
```

---

## 8 大 Agent 目录

```mermaid
block-beta
  columns 4
  ba["① BA\n需求分析\n专家"]:1
  arch["② API & DB\n架构师"]:1
  qc["③ QC\n测试验证\n专家"]:1
  res["④ Codebase\n调研专家"]:1
  dev["⑤ 开发与\n安全专家"]:1
  log["⑥ 日志与\n可观测性专家"]:1
  docs["⑦ 文档与\nREADME专家"]:1
  git["⑧ DevOps\n与 Git 专家"]:1
```

| # | Agent 名称 | Prompt 文件 | 职责描述 | 工具链 |
|:-:|-----------|-------------|----------|-------|
| ① | **BA Requirements Specialist** | [`ba-requirements-specialist.md`](ba-requirements-specialist.md) | 需求工程、User Stories、Gherkin 标准 Acceptance Criteria、NFRs | read, write, search_web |
| ② | **API & DB Architect** | [`api-db-architect.md`](api-db-architect.md) | REST/GraphQL API 契约、DB Schema、RFC 7807 错误标准、日志契约 | read, write |
| ③ | **QC Verification Specialist** | [`qc-verification-specialist.md`](qc-verification-specialist.md) | 测试矩阵、AAA 模式单元/集成测试、日志验证、回归测试 | read, write, shell |
| ④ | **Codebase Researcher** | [`codebase-researcher.md`](codebase-researcher.md) | 代码库扫描、模式挖掘、日志审计、影响分析、Roadmap 规划 | read, shell, search_web |
| ⑤ | **Developer & Security** | [`dev-security-implementer.md`](dev-security-implementer.md) | 安全编码、Auth/RBAC、JSON 结构化日志、自定义异常类 | read, write, shell |
| ⑥ | **Logging & Observability** | [`logging-observability-specialist.md`](logging-observability-specialist.md) | 日志 Schema 设计、Logger 配置 (pino/structlog)、Correlation ID、全局异常捕捉 | read, write, shell, search_web |
| ⑦ | **Docs & README** | [`docs-readme-specialist.md`](docs-readme-specialist.md) | README 生成、双层 .gitignore、CHANGELOG、.env.example、架构图生成 | read, write, search_web, generate_image |
| ⑧ | **DevOps & Git** | [`devops-git-specialist.md`](devops-git-specialist.md) | Conventional Commits 规范、GitHub Flow、CI/CD Pipeline (GitHub Actions)、SemVer 版本发布 | read, write, shell |

---

## 8 阶段流水线架构

### 详细 Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor User as 👤 用户 / PO
    participant AG as 🤖 Antigravity Orchestrator
    participant BA as ① BA 需求专家
    participant Arch as ② 架构师
    participant QC as ③ QC 测试专家
    participant Res as ④ 调研专家
    participant Dev as ⑤ 开发专家
    participant Log as ⑥ 日志专家
    participant Doc as ⑦ 文档专家
    participant Git as ⑧ DevOps 专家

    User->>AG: "构建功能 X"

    rect rgb(230, 245, 255)
        Note over AG,BA: 阶段 1 — 需求分析
        AG->>BA: 分析需求 prompt
        BA-->>AG: SRS + User Stories + Gherkin AC + NFRs
    end

    rect rgb(230, 255, 230)
        Note over Arch,QC: 阶段 2-3 — 并行架构设计与测试策略
        par 并行执行
            AG->>Arch: 设计 API 契约与 DB Schema
            AG->>QC: 制定测试矩阵与测试计划
        end
        Arch-->>AG: API 契约 + Schema + 日志契约
        QC-->>AG: 测试矩阵 + 测试用例
    end

    rect rgb(255, 245, 230)
        Note over AG,Res: 阶段 4 — 代码库勘测
        AG->>Res: 扫描代码库与规范审计
        Res-->>AG: Roadmap + 规范约定 + 影响分析
    end

    rect rgb(255, 230, 230)
        Note over AG,Dev: 阶段 5 — 功能编码
        AG->>Dev: 编写代码 + 认证 + 日志
        Dev-->>AG: 源代码 + 安全审计报告
    end

    rect rgb(240, 230, 255)
        Note over Log,Doc: 阶段 6-7 — 并行增强
        par 并行执行
            AG->>Log: 配置 Logger 与错误追踪
            AG->>Doc: 生成 README, .gitignore 与 CHANGELOG
        end
        Log-->>AG: Logger + 全局异常处理 + Correlation ID
        Doc-->>AG: 完整项目文档
    end

    rect rgb(245, 245, 220)
        Note over AG,QC: 最终测试验证
        AG->>QC: 运行测试套件与验证日志
        QC-->>AG: 测试证据 + 日志验证报告
    end

    rect rgb(220, 220, 245)
        Note over AG,Git: 阶段 8 — 交付发布
        AG->>Git: 规范化 Commit + Push + CI/CD
        Git-->>AG: Release 标签发布
    end

    AG-->>User: ✅ 全生命周期完成报告
```

---

## 一键全局安装

克隆仓库后，仅需运行**一条命令**即可将全部 8 个 Agent 自动安装至全局配置目录 (`~/.gemini/config/agents/`)：

### Windows (PowerShell)：

```powershell
.\scripts\setup_global.ps1
```

### Linux / macOS (Bash)：

```bash
bash scripts/setup_global.sh
```

---

## 如何使用面板选择 Agent (`/agents`)

在 Antigravity CLI 中输入以下命令唤出交互式 TUI 面板：

```bash
/agents
```

---

## 实际应用示例

### 用例：构建认证系统 (Authentication)

```mermaid
flowchart TD
    subgraph "① BA Agent 分析需求"
        BA1["User Story: As a user,\nI want to login with email/password"]
        BA2["AC: Given valid credentials\nWhen POST /auth/login\nThen return JWT tokens"]
        BA3["NFR: Rate limit 5 req/min\nLog every login attempt"]
    end

    subgraph "② Architect Agent 设计架构"
        AR1["POST /api/v1/auth/login\nPOST /api/v1/auth/register\nPOST /api/v1/auth/refresh"]
        AR2["users table: id, email,\npassword_hash, role, created_at"]
        AR3["Logging Contract:\nauth.login.success → INFO\nauth.login.failed → WARN"]
    end

    subgraph "⑤ Developer Agent 编码实现"
        DEV1["authService.ts\nauthController.ts\nauthMiddleware.ts"]
        DEV2["Argon2 hashing\nJWT access + refresh\nZod validation"]
    end

    BA1 & BA2 & BA3 --> AR1 & AR2 & AR3
    AR1 & AR2 & AR3 --> DEV1 & DEV2
```

---

## BA 技巧：如何使用 AI 绘制流程图

> **实用技巧：** 除了编写代码，本 Agent 套件还支持 BA/PM 利用 AI 创建专业技术文档与可视化流程图。

### 解决方案：使用 AI Agent + Mermaid/PlantUML

```mermaid
sequenceDiagram
    actor Customer as 👤 客户
    participant FE as 前端
    participant MW as 中间件
    participant CB as 征信局 API
    participant UW as 审批系统

    Customer->>FE: 提交贷款申请 (表单数据)
    FE->>MW: POST /api/v1/loans/apply
    MW->>CB: GET /credit-score?ssn=***
    CB-->>MW: { score: 720, history: "good" }
    MW->>UW: POST /underwrite { loan + credit_data }
    UW-->>MW: { decision: "APPROVED", limit: 500万 }
    MW-->>FE: { status: "approved", loanId: "LN-001" }
    FE-->>Customer: 显示结果：贷款申请已批准 ✅
```

---

## 目录结构

```
custom_agent_agy/
├── README.md                              # 越南语 README
├── README_EN.md                           # 英文 README
├── README_ZH.md                           # 简体中文 README
├── LICENSE                                # MIT License
├── CONTRIBUTING.md                        # 贡献指南
├── CODE_OF_CONDUCT.md                     # 社区行为准则
├── SECURITY.md                            # 安全策略
├── .gitignore                             # Git 忽略规则 (双层)
├── full_lifecycle_workflow_guide.md        # 8 阶段工作流指南
│
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml                 # Bug 报告模板
│   │   └── feature_request.yml            # 功能请求模板
│   ├── PULL_REQUEST_TEMPLATE.md           # PR 检查清单
│   └── workflows/
│       └── ci.yml                         # GitHub Actions CI
│
├── assets/
│   └── banner.jpg                         # 仓库 Banner 图片
├── scripts/
│   ├── setup_global.ps1                   # Windows 一键安装脚本
│   └── setup_global.sh                    # Linux/macOS 一键安装脚本
├── docs/
│   ├── USAGE_GUIDE.md                     # 各 Agent 详细使用手册
│   └── TIPS_BA_AI_FLOW.md                 # BA AI 流程图技巧
│
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

## 补充文档

| 文档 | 描述 |
|------|------|
| [英文版 (English)](README_EN.md) | Custom Agent AGY 英文完整文档 |
| [越南语版 (Vietnamese)](README.md) | Custom Agent AGY 越南语完整文档 |
| [Workflow Guide](full_lifecycle_workflow_guide.md) | 8 阶段流水线编排指南与并行执行规则 |
| [Usage Guide](docs/USAGE_GUIDE.md) | 各 Agent 详细使用手册：目标、Prompt 模板与输出示例 |
| [BA AI Flow Tips](docs/TIPS_BA_AI_FLOW.md) | BA 使用 AI 绘制流程图与撰写 BRD 文档指南 |

---

## 贡献指南

欢迎提交 Issue 或 Pull Request！请参阅 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详细规范。

---

## 开源协议

基于 [MIT License](LICENSE) 开源。

---

<p align="center">
  <strong>Built with ❤️ by <a href="https://github.com/Le-Ngoc-Tu">Le Ngoc Tu</a></strong>
</p>
