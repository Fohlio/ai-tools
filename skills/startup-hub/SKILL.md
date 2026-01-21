---
name: startup-hub
description: Research startups, analyze market fit, and manage project entries in Startup Hub. Use when documenting new project ideas or conducting competitive analysis.
---

# Startup Hub Skill

## When to Use This Skill

- User wants to document a new startup/project idea
- User needs competitive analysis or market research
- User wants to list, create, update, or manage projects in Startup Hub
- User asks about market fit, TAM/SAM/SOM, or business viability

## MCP Tools

This skill uses the **Startup Hub MCP** (`mcp__startup-hub__*`):

| Tool | Description |
|------|-------------|
| `list_projects` | Search and list projects with filtering |
| `get_project` | Get detailed project information by slug |
| `create_project` | Create a new project entry |
| `update_project` | Update an existing project |
| `delete_project` | Delete a project |

## Procedure

### 1. Research Phase

Before documenting any project:

1. **Web Search**: Use `WebSearch` to investigate:
   - Market landscape and trends
   - Competitors and their positioning
   - Target audience pain points
   - Technology maturity

2. **Check for Duplicates**: Use `list_projects` to ensure similar projects don't already exist.

### 2. Analysis Framework

Evaluate projects against these criteria:

**Market Analysis:**
- Problem Validation: Is there a real pain point?
- Target Audience: Who are the users? TAM/SAM/SOM?
- Competitive Landscape: Who else is solving this?
- Trends: Is the market growing?

**Project Evaluation:**
- Feasibility: Technical complexity vs. capabilities
- Viability: Revenue model, unit economics
- Desirability: User demand, engagement potential
- Timing: Why now? Market readiness

### 3. Documentation

Use these status values:
- `IDEA` — Early concept, needs validation
- `MVP` — Minimum viable product in development
- `BETA` — Limited release, gathering feedback
- `LAUNCHED` — Live product with active users
- `PAUSED` — On hold or pivoting

### 4. Create/Update Project

#### create_project Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| title | string | Yes | Project title (max 100 chars) |
| shortDescription | string | Yes | One-liner pitch (max 200 chars) |
| pitch | string | No | Vision, problem, solution, value proposition (markdown) |
| features | string | No | Key features and functionality (max 10000 chars) |
| traction | string | No | Metrics: user growth, revenue, partnerships, milestones |
| status | string | No | IDEA, MVP, BETA, LAUNCHED, PAUSED |
| tags | string[] | No | Project tags |
| lookingFor | string[] | No | Roles you're hiring for |
| websiteUrl | string | No | Project website URL |
| needsInvestment | boolean | No | Looking for investment? |
| investmentDetails | string | No | Investment requirements |
| language | enum | No | Content language: `en` or `ru` (default: ru) |

#### Example

```
create_project(
  title: "Project Name",
  shortDescription: "One-liner pitch (max 200 chars)",
  pitch: "Vision, problem, solution, value proposition (markdown)",
  features: "- Feature 1\n- Feature 2\n- Feature 3",
  traction: "Metrics: users, revenue, partnerships",
  status: "IDEA",
  tags: ["ai", "saas", "b2b"],
  lookingFor: ["Frontend Developer", "AI Engineer"],
  needsInvestment: true,
  investmentDetails: "Seeking $500K seed round",
  language: "en"
)
```

## Output Format

When presenting research, structure as:

```markdown
## Project: [Name]

### Problem
[What pain point does this solve?]

### Solution
[How does this project address the problem?]

### Key Features
[Core functionality and capabilities]

### Market
- Target Audience: [Who]
- Market Size: [TAM/SAM/SOM estimates]
- Competitors: [Key players]

### Differentiation
[What makes this unique?]

### Traction
[User growth, revenue, partnerships, milestones]

### Status & Next Steps
[Current stage and recommended actions]
```

## Important Rules

| Rule | Description |
|------|-------------|
| **List First** | Always check `list_projects` before creating to avoid duplicates |
| **Research First** | Use WebSearch before documenting any project |
| **Full Pitch** | Write detailed markdown descriptions with problem, solution, differentiation |
| **Track Traction** | Record metrics and validation evidence |
| **Language Support** | Use `language` param when creating; `locale` when listing |
