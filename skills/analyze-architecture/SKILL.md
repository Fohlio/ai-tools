---
name: analyze-architecture
description: Systematic architecture audit for backend/web applications. Analyzes system context, domains, data model, integrations, quality attributes, security, observability, and evolution strategy. Use when reviewing an existing codebase architecture, onboarding to a new project, or before major refactoring.
allowed-tools: Read, Glob, Grep, Bash(ls *), Bash(wc *), Bash(git log *), Bash(git shortlog *), Task
---

# Analyze Architecture Skill

## When to Use This Skill

- Onboarding to an unfamiliar codebase — need the full picture fast
- Before a major refactoring or migration — assess what exists
- Architecture review / health check — find structural problems
- Pre-mortem — identify risks before they become incidents
- Due diligence — evaluating a codebase quality

## How It Works

Walk through the checklist below against the actual codebase. For each section, read the relevant code/config/docs, assess the current state, and produce a verdict. Don't ask the user to explain the architecture — read the code yourself.

## Procedure

### Step 1: Orient

Quickly scan the project to understand the tech stack and structure:

- Read `package.json` / `requirements.txt` / `go.mod` / `Cargo.toml` / `build.gradle` etc.
- Read project root for config files (docker-compose, k8s manifests, terraform, CI configs)
- Scan directory structure to identify modules/services/packages
- Read README and any docs/ directory
- Check git history for scale: contributors, commit frequency, age

Produce a one-paragraph summary of what this system is and does before proceeding.

### Step 2: Run the Checklist

Go through each section of the checklist (see below). For each item:

```
- Read the relevant code, config, or documentation
- Assess: is this addressed, partially addressed, or missing?
- Note evidence: file paths, code snippets, config values
- Flag risks: what could go wrong because of the current state
```

### Step 3: Produce the Report

Output the architecture analysis using the format in the Output section below.

## Checklist

### 1. System Context & Boundaries

- [ ] External consumers identified — who calls this system, via what protocols/channels
- [ ] External dependencies identified — what third-party services, APIs, databases does it depend on
- [ ] System boundary is clear — what's inside vs outside, where the code ends and infra begins
- [ ] Business goals behind the architecture are stated or inferable — why this structure (scale, speed of development, domain complexity, team topology, etc.)

### 2. Domains & Bounded Contexts

- [ ] Core domain identified — the primary business logic this system exists to serve
- [ ] Domain boundaries are explicit — separate modules/packages/services per domain, not a monolithic tangle
- [ ] Ubiquitous language is consistent — naming in code matches business concepts (or at least is internally consistent)
- [ ] Cross-domain dependencies are minimal and explicit — domains don't reach into each other's internals

### 3. Components & Service Map

- [ ] High-level component structure is clear — can you draw a box diagram from the code?
- [ ] Responsibility of each component is identifiable — each module/service has a single clear purpose
- [ ] Communication patterns between components are explicit — sync (HTTP/gRPC) vs async (message bus/events), clearly visible in code
- [ ] Trust boundaries and entry points are defined — API gateways, BFF layers, public endpoints are identifiable
- [ ] No "god" components — no single module that does everything

### 4. Architecture Quality (Modularity & Evolvability)

- [ ] Independent evolution — can you change one module without cascading changes across the system
- [ ] Loose coupling — minimal dependencies between modules, clear interfaces/contracts
- [ ] High cohesion — related code lives together, unrelated code is separate
- [ ] Evolution strategy — how are new features/services added without turning the codebase into a big ball of mud
- [ ] No circular dependencies between modules/packages

### 5. Quality Attributes

- [ ] Performance — critical hot paths identified, bottleneck points known, optimization strategy exists (or at least thought about)
- [ ] Scalability — how does the system handle 10x load? Horizontal scaling points identified
- [ ] Availability — SLA expectations, redundancy, failover strategy
- [ ] Latency — time-sensitive paths identified, caching strategy where needed
- [ ] Consistency model — eventual vs strong consistency, explicitly chosen per use case

### 6. Data & Databases

- [ ] Data model is defined — aggregates/entities are identifiable, source of truth is clear for each
- [ ] Data ownership boundaries — which service/module owns which data (shared DB vs DB-per-service)
- [ ] Schema migration strategy — how are DB changes applied (migration tool, versioning)
- [ ] Data retention & archival — old data handling, cleanup policies
- [ ] No raw SQL scattered across business logic (repository/DAO pattern or ORM usage)

### 7. Integrations & Communication

- [ ] Interaction style is consciously chosen — request/response vs event-driven, sync vs async, and the reasons are clear
- [ ] Degradation strategy — what happens when an external service is down (queues, outbox pattern, circuit breakers, retries)
- [ ] Contract management — API versioning, schema evolution for events, backward compatibility
- [ ] Idempotency — critical operations are idempotent or have deduplication
- [ ] Timeout and retry policies — explicitly configured, not relying on defaults

### 8. Security

- [ ] Authentication — mechanism is clear (JWT, sessions, OAuth, API keys), implemented consistently
- [ ] Authorization — permission model exists, enforced at the right layer (not just UI)
- [ ] Input validation — at system boundaries, not trusting external input
- [ ] Secret management — no secrets in code, using a vault/env-based approach, rotation policy
- [ ] HTTPS/TLS — enforced for all external communication
- [ ] CORS, CSP, rate limiting — configured where applicable
- [ ] Dependency vulnerabilities — audit tooling in place (npm audit, Snyk, Dependabot)

### 9. Error Handling, Resilience & Observability

- [ ] Unified error strategy — consistent error codes/formats, clear retry vs fail-fast boundaries
- [ ] Logging — structured, with correlation/trace IDs for request tracing
- [ ] Metrics — business and technical metrics collected (request rates, error rates, latencies)
- [ ] Tracing — distributed tracing for cross-service calls (or at least request ID propagation)
- [ ] Dashboards & alerts — key metrics visualized, alerting on anomalies
- [ ] Graceful degradation — system continues to function (with reduced capability) when parts fail

### 10. Deployment & Infrastructure

- [ ] Deployment topology is clear — where components run (k8s, VMs, serverless, edge), which regions/accounts
- [ ] Infrastructure as Code — infra is reproducible, not manually configured
- [ ] Environment parity — dev/staging/prod are structurally similar
- [ ] Scaling configuration — auto-scaling rules, resource limits defined
- [ ] Rollback strategy — how to revert a bad deploy quickly

### 11. CI/CD & Testing

- [ ] CI pipeline exists — builds, lints, and tests on every push
- [ ] Test coverage — critical business logic has automated tests (unit + integration at minimum)
- [ ] Static analysis — linters, type checking, security scanning in the pipeline
- [ ] Branching & release strategy — clear (trunk-based, git-flow, etc.), hotfix process defined
- [ ] Deploy pipeline — automated deployment with gates (not manual SSH-and-pray)

### 12. Documentation & Communication

- [ ] Architecture overview exists — 1-3 pages for newcomers, reasonably up to date
- [ ] Sequence/flow diagrams — for complex scenarios, including error paths
- [ ] Architecture decision records (ADRs) — key decisions documented with rationale
- [ ] Architecture ownership — someone (person, guild, team) is responsible for architectural coherence

### 13. Evolution & Long-term Cost

- [ ] Technical debt is tracked — known shortcuts are documented, not hidden
- [ ] Migration path exists — how to get from current state to target state for known improvements
- [ ] Cost of change is reasonable — adding a typical feature doesn't require touching 20 files across 10 services
- [ ] Team topology alignment — architecture supports how teams actually work (Conway's law awareness)
- [ ] No vendor lock-in traps — or the lock-in is conscious and the trade-off is documented

## Output Format

```markdown
# Architecture Analysis: [Project Name]

## Summary
[1-2 paragraphs: what this system is, its tech stack, scale, and overall architectural health]

## Scorecard

| Area | Score | Key Risk |
|------|-------|----------|
| 1. Context & Boundaries | OK / WARN / MISSING | [one-liner] |
| 2. Domains | OK / WARN / MISSING | [one-liner] |
| 3. Components & Services | OK / WARN / MISSING | [one-liner] |
| 4. Modularity & Evolvability | OK / WARN / MISSING | [one-liner] |
| 5. Quality Attributes | OK / WARN / MISSING | [one-liner] |
| 6. Data & Databases | OK / WARN / MISSING | [one-liner] |
| 7. Integrations | OK / WARN / MISSING | [one-liner] |
| 8. Security | OK / WARN / MISSING | [one-liner] |
| 9. Errors & Observability | OK / WARN / MISSING | [one-liner] |
| 10. Deployment & Infra | OK / WARN / MISSING | [one-liner] |
| 11. CI/CD & Testing | OK / WARN / MISSING | [one-liner] |
| 12. Documentation | OK / WARN / MISSING | [one-liner] |
| 13. Evolution & Cost | OK / WARN / MISSING | [one-liner] |

## Detailed Findings

### [Section Name]
**Score: OK / WARN / MISSING**

What exists:
- [finding with file path evidence]

What's missing or risky:
- [gap with concrete impact]

Recommendation:
- [actionable next step]

[Repeat for each section]

## Top 5 Risks (Priority Order)

1. **[Risk]** — [Impact] — [Mitigation]
2. ...

## Recommended Next Steps

1. [Most impactful improvement, with concrete scope]
2. [Second priority]
3. [Third priority]
```

## Important Rules

- **Read the code, don't ask** — infer everything from the codebase. Only ask the user if something is genuinely unknowable from code (e.g., business context, team structure)
- **Evidence-based** — every finding must reference a file path or concrete observation, not vibes
- **Proportional depth** — spend more time on areas that look problematic, skim areas that look healthy
- **Actionable output** — every WARN/MISSING must have a concrete recommendation, not "consider improving"
- **No boilerplate praise** — don't pad the report with "great job on X". State what's there, what's missing, what to do
- **Codebase scale awareness** — a 500-line side project doesn't need k8s and ADRs. Calibrate expectations to the project's size and stage
