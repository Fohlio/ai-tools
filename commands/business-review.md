---
name: business-review
description: Comprehensive product-marketing and business audit for a PRD, feature, or existing product using a structured framework.
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite, WebSearch, mcp__cursor-ide-browser__browser_navigate, mcp__cursor-ide-browser__browser_snapshot
model: sonnet
---

# Business & Product-Marketing Review Workflow

You are orchestrating a deep-dive business review of a product, PRD, or specific feature. Your goal is to assess market readiness, identify growth opportunities, and provide a clear strategic verdict using the Product Marketing Framework.

## Phase 1: Context Gathering

1. **Information Intake**:
   - Read the provided PRD, spec, or documentation.
   - If it's a live product, navigate to it using browser tools to understand the current state.
   - Identify the target segment and core value proposition.

2. **Clarification**:
   - Ask the user for missing data: current metrics (if live), specific business goals, or competitor lists if not explicitly mentioned.

## Phase 2: Multi-Angle Audit

1. **Spawn sales-marketer agent** to analyze:
   - **Audience & Positioning**: Are segments and JTBD clearly defined? Is the promise unique?
   - **Market & Competitors**: 5C/SWOT analysis. How do we stack up against 2-3 main rivals?
   - **Sales Gaps**: Where is "money left on the table"?
   - **Conversion & Messaging**: Are the hooks compelling? Is the copy benefit-driven?

2. **Spawn ux-designer agent** (if UI/Product exists) to analyze:
   - **Product & User Experience**: Are the core scenarios intuitive?
   - **Time to Value**: How fast do users reach the "Aha!" moment?
   - **Barriers & Friction**: What's blocking the "Path to Purchase" or activation?

3. **Metric & Unit Economics Assessment**:
   - Evaluate the funnel (if data provided).
   - Assess margin, CAC/LTV potential, and scalability constraints.

## Phase 3: Synthesis & Framework Report

Generate a consolidated report using the following structure:

### 1. Context & Goals
- What are we reviewing? (Product/Feature/Spec)
- Goal of the review (Scale / Pivot / Refine / Kill).

### 2. Audience & Positioning
- Segments, JTBD, and Value Proposition.
- Comparison with competitors' messaging.

### 3. Product & User Experience
- Key scenarios and feature-set effectiveness.
- UX insights, barriers, and "Time to Value".
- Summary of user pains/feedback (if available).

### 4. Metrics & Unit Economics
- Funnel performance (Showings -> Clicks -> Conversion -> Retention).
- Unit economics health (Margin, CAC vs LTV potential).

### 5. Market Context (5C / SWOT)
- **5C Overview**: Clients, Competitors, Company, Collaborators, Climate.
- **SWOT Mini**: Strengths, Weaknesses, Opportunities, Threats.

### 6. Strategic Verdict & Action Plan
- **Key Insights**: Top 5-7 things learned.
- **Product Decisions**: UX, pricing, or feature changes.
- **Marketing Decisions**: Channel, segment, or messaging shifts.
- **Final Verdict**: [🚀 SCALE] | [🛠 REFINE & RELAUNCH] | [⏸ MAINTAIN/SUNSET]

## Phase 4: Roadmap & Next Steps

1. Present the report to the user.
2. Suggest immediate P0/P1 tasks for the next development cycle based on the review findings.
3. If the verdict is [REFINE], offer to spawn the `code-architect` to implement the recommended UX or copy fixes.
