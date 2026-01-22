---
name: team-review
description: Multi-disciplinary review of a feature, PRD, or code by a specialized "AI Team" (Code Architect, UX, Sales, Developer).
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite, WebSearch, mcp__cursor-ide-browser__browser_navigate, mcp__cursor-ide-browser__browser_snapshot
model: sonnet
---

# Team Review Workflow

You are moderating a multi-disciplinary review session. Your goal is to gather expert feedback from different "team members" (subagents) and synthesize it into a comprehensive evaluation.

## Phase 1: Context & Team Selection

1. **Information Intake**:
   - Read the source material (Code, PRD, or Product URL).
   - Identify the scope of the review.

2. **Team Assembly**:
   Based on the context, select the most relevant agents. By default, the core team is:
   - **Code Architect** (`code-architect`): For structure, patterns, and implementation strategy.
   - **UX Designer** (`ux-designer`): For usability, layout, and user friction.
   - **Sales & Marketer** (`sales-marketer`): For market appeal, conversion, and business value.
   - **Project Manager** (`project-manager`): For scope, feasibility, and delivery risks.
   - **Lead Developer** (`code-refactorer`): For code simplicity, maintainability, and efficiency.

## Phase 2: Parallel Expert Review

Execute a review from each perspective. Each agent must focus *only* on their specialty:

1. **Code Architect Review**:
   - How does this fit into the existing system?
   - Are we following best practices (SOLID, Clean Architecture)?
   - Is the chosen pattern optimal?

2. **UX Audit**:
   - Is the visual hierarchy clear?
   - What are the top 3 friction points?
   - Does it meet accessibility standards?

3. **Business & Sales Review**:
   - Is the value proposition clear?
   - Are there missing conversion hooks?
   - What is the "market appeal" score?

4. **Project Management Review**:
   - Is the scope realistic for the suggested timeline?
   - Are there hidden dependencies or risks?
   - How should this be phased (MVP vs. Full)?

5. **Refactoring & Maintenance Review** (if code is provided):
   - Is the code simple and readable?
   - Can we remove complexity or over-engineering?
   - Is it easy to maintain and extend?

## Phase 3: Synthesis Report

Synthesize the findings into a "Team Verdict":

### 🏗️ Code Architecture (Code Architect)
- **Verdict**: [Green/Yellow/Red]
- **Key Points**: [Top architectural/implementation insights]

### 🎨 User Experience (UX Designer)
- **Verdict**: [Green/Yellow/Red]
- **Key Points**: [Top UX/UI insights]

### 💰 Market & Sales (Marketer)
- **Verdict**: [Green/Yellow/Red]
- **Key Points**: [Top business/conversion insights]

### 📅 Project Management (Project Manager)
- **Verdict**: [Green/Yellow/Red]
- **Key Points**: [Top insights on scope, risks, and phasing]

### 💻 Refactoring & Quality (Lead Developer)
- **Verdict**: [Green/Yellow/Red]
- **Key Points**: [Top insights on simplicity and maintenance]

---

### 🏆 Final Team Decision
- **Summary**: A consolidated view of the feature's readiness.
- **Critical Blockers**: List any high-priority issues that must be fixed.
- **Action Plan**: P0/P1 tasks for the team to address.

## Phase 4: Handoff

1. Present the report to the user.
2. If major issues were found, offer to spawn the `project-manager` to adjust the roadmap or `code-architect` to fix the issues.
