# Contributing to Custom Agent AGY

Thank you for your interest in contributing to **Custom Agent AGY**! We welcome contributions from developers, Business Analysts, QA engineers, and open-source enthusiasts.

---

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

---

## How Can I Contribute?

### 1. Reporting Bugs
If you find a bug or unexpected behavior in any of the agent prompts:
1. Check existing [Issues](https://github.com/Le-Ngoc-Tu/custom_agent_agy/issues) to avoid duplicates.
2. Open a new issue using the **Bug Report** template.
3. Describe the issue, including the agent name, input prompt, and expected vs actual behavior.

### 2. Proposing Improvements or New Agents
Before creating a new agent, please read our [Architecture Sweet Spot Guide](docs/USAGE_GUIDE.md) — we maintain a strict **8-Agent Golden Ratio** architecture.
- For new technology rules (e.g., React, Next.js, Postgres), create or suggest **Skills/Guidelines**, NOT new agents.
- If you believe a fundamental role is missing, open an issue using the **Agent Proposal** template.

### 3. Submitting Pull Requests (PRs)
1. Fork the repository and create your branch from `main`:
   ```bash
   git checkout -b feat/enhance-ba-agent
   ```
2. Make your changes adhering to the **4-Part Harness Structure** for agent prompts:
   - Part 1: ROLE & IDENTITY
   - Part 2: SAFETY CONSTRAINTS
   - Part 3: QUALITY STANDARDS
   - Part 4: TOOLS & EXECUTION
3. Ensure commit messages follow **Conventional Commits**:
   - `feat(agent): add Gherkin scenario outline support to BA agent`
   - `fix(docs): correct broken link in README`
   - `docs: update workflow guide`
4. Push to your fork and submit a Pull Request using our PR template.

---

## Conventional Commits Reference

```
feat(scope):     A new feature or agent enhancement
fix(scope):      A bug fix in prompt or scripts
docs(scope):     Documentation changes only
refactor(scope): Restructuring prompt harness without changing behavior
test(scope):     Adding or updating verification tests
chore(scope):    Build, CI/CD, or maintenance tasks
```

---

Thank you for helping make Custom Agent AGY better!
