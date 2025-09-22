# Claude Usage Guidelines

Concise rules for working with Claude across agents and docs in this repo.

## Interaction principles

- Be explicit about goals, constraints, acceptance criteria, and deliverables.
- Prefer minimal, verifiable outputs; avoid over-engineering.
- Ask focused clarifying questions when scope is ambiguous.

## Output quality

- Use clear structure with headings and bullets; keep high signal.
- Follow repository conventions (paths like `.agents-playbook/[task-name]/`).
- Provide code and specs that are testable and type-safe.

## Function/tool schemas

- Follow the user rule: avoid optional parameters in Zod schemas for OpenAI function calling; handle defaults in execution logic; keep schemas simple and explicit; test after changes.

## Security and privacy

- Do not include secrets in commits or logs.
- Redact tokens and credentials; use environment variables whenever possible.

## Cross-references

- See `AGENTS.md` for available agents and responsibilities.
- See `links.md` for model, SDK, and tooling references.
- Additional rules in `rules/claude.md`.


