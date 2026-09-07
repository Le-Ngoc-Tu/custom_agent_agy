---
task_id: ""
current_node: "NODE_BA" # Enum: NODE_BA | NODE_DESIGN | NODE_DEV | NODE_QC | NODE_HANDOFF | TERMINAL
iteration_count: 0
max_iterations: 3
deterministic_gates:
  spec_validated: false
  build_exit_code: null
  test_exit_code: null
route: "PENDING" # Enum: PENDING | FIX_CYCLE | HANDOFF | CIRCUIT_BREAKER
active_subagents: []
modified_files: []
---

# Task Plan: [Tên Nhiệm Vụ]

## 1. Graph State Monitor
- **Active Node**: `current_node`
- **Current Route**: `route`
- **Feedback Loop Counter**: `iteration_count` / `max_iterations`

## 2. Phase Checklist & Deterministic Gates
- [ ] **Node 1: Business Analysis (`ba-requirements-specialist`)**
  - Gate: `spec_validated == true` (Gherkin Acceptance Criteria hoàn tất)
- [ ] **Node 2: Technical Design (`api-db-architect` + `logging-observability-specialist`)**
  - Gate: API Spec, DB Migration, Logging Contract sẵn sàng
- [ ] **Node 3: Implementation (`dev-security-implementer`)**
  - Gate: Code hoàn thiện, không có dead code, syntax check exit 0
- [ ] **Node 4: Verification & Quality Routing (`qc-verification-specialist`)**
  - Gate: `test_exit_code == 0` (Thực thi shell command thật)
  - Branch: Nếu test fail và `iteration_count < max_iterations` -> Quay lại Node 3
- [ ] **Node 5: Parallel Handoff (`docs-readme-specialist` + `devops-git-specialist`)**
  - Gate: Tài liệu cập nhật, git diff clean, commit sẵn sàng
