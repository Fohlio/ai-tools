---
name: ai-tools:brainstorming
description: Structured ideation using TRIZ contradictions, SCAMPER mutations, and morphological analysis. Turns vague ideas into ranked, testable concepts. Use before any creative work including creating features, building components, adding functionality, or modifying behavior.
---

# Brainstorming Skill

## When to Use This Skill

- User has a vague idea and needs to shape it into something concrete
- User needs creative solutions for a technical or product problem
- Before implementing a feature — to explore the solution space first
- User is stuck and needs to break out of obvious approaches
- Comparing multiple directions before committing

## How It Works

Six phases, executed sequentially. Each phase builds on the previous one.

1. **Frame** the problem as a contradiction
2. **Map** the system and its constraints
3. **Generate** ideas via TRIZ, SCAMPER, and morphological analysis
4. **Evaluate** ideas through Six Thinking Hats
5. **Rank** and select top 3
6. **Define** the minimum testable step for each

## Procedure

### Phase 1: Frame the Contradiction

Formulate the task as a TRIZ contradiction:

```
"I want [X], but [Y] prevents it, and I cannot sacrifice [Z]."
```

Infer X, Y, Z from the user's message and codebase context. If truly ambiguous, ask one clarifying question — no more.

Examples:
- "I want real-time updates, but polling kills the server, and I can't add WebSocket infrastructure."
- "I want a flexible permissions system, but the data model is already in production, and I can't break existing APIs."

### Phase 2: Map the System

Define the system under analysis:

```
Object:       [what we're changing — the product, feature, component]
Parts:        [sub-components, modules, layers involved]
Environment:  [external systems, APIs, users, infrastructure]
Goal:         [what success looks like]
Constraints:  [budget, time, tech debt, team size, backward compat]
Users:        [who benefits, who is affected]
```

Then identify pain points — where exactly things break, frustrate, or fail:

```
Pain 1: [description] — affects [who/what]
Pain 2: [description] — affects [who/what]
Pain 3: [description] — affects [who/what]
```

For each pain, define the contradiction pair:
- "Improving [A] worsens [B]"

Select the **1-2 sharpest contradictions** — biggest impact, real pain, resources available to act.

### Phase 3: Generate Ideas

Run three frameworks in sequence. Capture all ideas without judgment — volume first, filtering later.

#### 3a. TRIZ Inventive Principles

Apply relevant TRIZ principles to the contradiction. Not all 40 apply — pick the ones that resonate:

| Principle | Software interpretation | Question |
|-----------|----------------------|----------|
| Segmentation | Microservices, split into smaller units | What can be broken into independent parts? |
| Taking Out | Extract the problematic part, handle separately | What piece can be isolated or moved elsewhere? |
| Local Quality | Different settings per context/user/env | Where should behavior vary by context? |
| Asymmetry | Treat read/write paths differently | What if we optimized one direction only? |
| Merging | Combine operations, batch, bulk | What can be done together instead of separately? |
| Universality | One component serves multiple purposes | What existing piece can do double duty? |
| Nesting | Embed one thing inside another | What can be composed or layered? |
| Counterweight | Cache, prefetch, precompute | What can be done in advance to offset runtime cost? |
| Prior Action | Migrations, setup scripts, warm-up | What can be prepared before the user needs it? |
| Dynamicity | Feature flags, adaptive UI, runtime config | What should change at runtime instead of deploy time? |
| Intermediary | API gateway, middleware, adapter, proxy | What middle layer would decouple the problem? |
| Self-service | Auto-healing, self-registration, defaults | Can the object handle itself without intervention? |
| Copying | Read replicas, CDN, snapshot | Can we use a cheap copy instead of the expensive original? |
| Inversion | Push vs pull, server vs client, sync vs async | What if we reversed the direction? |

For each applicable principle: **"How does this apply to my system?"** — generate 2-3 ideas per principle.

#### 3b. SCAMPER on the Key Object

Take the main object (product, feature, process) and run each letter:

**S — Substitute**
- What can be replaced: participant, channel, technology, format, data source?
- What existing thing could serve as a replacement?

**C — Combine**
- What can be merged: functions, steps, screens, API calls, roles?
- What parallel processes could become one?

**A — Adapt**
- What pattern from another domain/product solves this?
- What open-source solution already exists for this shape of problem?

**M — Magnify / Minimize**
- What if we 10x'd the key metric: speed, depth, personalization, frequency?
- What if we reduced it to the absolute minimum viable version?

**P — Put to Other Use**
- Where else could this module/feature/API serve a different audience?
- What adjacent problem does this accidentally solve?

**E — Eliminate**
- What steps, fields, screens, roles, approvals can be removed without destroying value?
- What can be "default" so the user never has to touch it?

**R — Reverse / Rearrange**
- What if we flipped the order: result first, then input?
- What if the user does nothing and the system acts proactively?

#### 3c. Morphological Analysis (for complex problems)

When the solution space has multiple independent dimensions:

1. Identify 3-5 key parameters of the solution (e.g., "storage type", "auth method", "rendering strategy")
2. List 2-4 options per parameter
3. Build a matrix:

```
| Parameter        | Option A      | Option B       | Option C      |
|------------------|---------------|----------------|---------------|
| Storage          | PostgreSQL    | Redis          | SQLite        |
| Auth             | JWT           | Session        | API Key       |
| Rendering        | SSR           | CSR            | ISR           |
| Communication    | REST          | gRPC           | WebSocket     |
```

4. Combine across rows to generate non-obvious solution configurations
5. Flag 3-5 most interesting combinations (especially counter-intuitive ones)

### Phase 4: Evaluate (Six Thinking Hats)

Take the collected ideas and run a quick evaluation pass:

- **White Hat (Facts)**: What data/evidence supports or contradicts this idea?
- **Red Hat (Gut)**: Instinctive reaction — does this feel right or forced?
- **Yellow Hat (Benefits)**: Best-case outcome if this works perfectly?
- **Black Hat (Risks)**: What could go wrong? What's the failure mode?
- **Green Hat (Alternatives)**: Can this idea be twisted, combined, or improved further?

Skip Blue Hat (process facilitation) — that's the skill's job, not a separate step.

### Phase 5: Rank and Select Top 3

Score each idea on:

```
Impact:      [1-5] How much does it move the needle on the core contradiction?
Feasibility: [1-5] Can we build this with current resources and constraints?
Novelty:     [1-3] Does it break out of obvious solutions?
```

Select **top 3** by composite score. Present them:

```
Idea 1: [Name]
  What: [one-liner]
  How:  [key mechanism]
  Via:  [which TRIZ principle / SCAMPER letter / morphological combo]
  Risk: [main concern]

Idea 2: ...
Idea 3: ...
```

### Phase 6: Define the Minimum Test

For each top-3 idea, formulate:

```
"For [audience], we do [change], so that [improvement], using [TRIZ principle / SCAMPER step]."
```

Then define the smallest possible validation:

| Idea | Validation method | Effort |
|------|-------------------|--------|
| Idea 1 | [mockup / script / API call / user interview / A-B test] | [hours/days] |
| Idea 2 | ... | ... |
| Idea 3 | ... | ... |

Pick **1 idea** to test first — the one with the best impact/effort ratio.

If the user wants to proceed with implementation, hand off to the `poc-hypothesis` or `feature-implementation` skill as appropriate.

## Important Rules

- **Volume first, judgment later** — generate as many ideas as possible in Phase 3 before evaluating in Phase 4
- **No "that won't work" during generation** — every idea gets written down, even bad ones. Bad ideas trigger good ones
- **Contradiction is the starting point** — if there's no tension, there's no creative problem to solve
- **Concrete over abstract** — "add a caching layer in front of the payment API" beats "improve performance"
- **One question max** — infer context from the codebase and user message. Ask at most one clarifying question, then start generating
- **Always end with an action** — brainstorming that doesn't produce a testable next step is just a conversation
