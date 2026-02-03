# Documentation System Guide

This guide outlines the documentation standards and methodology for the project, enforced by the **Librarian** agent.

## Core Philosophy

1.  **Information Architecture**: Clear, logical structure with consistent naming (kebab-case).
2.  **Minimalism**: Create only necessary documentation to avoid bloat.
3.  **Active Archiving**: Outdated docs are technical debt. Move them to `docs/archive/`.
4.  **Single Source of Truth**: Avoid duplication. Link to existing docs instead of copying.

## Folder Structure Standards

The root documentation folder is `docs/`.

### 1. Feature Documentation (`docs/features/`)

*   **Structure**: Each feature gets its own folder: `docs/features/[feature-name]/`.
*   **Required Files**:
    *   `prd.md`: Product Requirements Document.
    *   `ac.md`: Acceptance Criteria & Verification Checklist.
    *   `test-cases.md`: Test cases and coverage gaps.
    *   `code-explanation.html`: Visualization/explanation of the solution (optional but recommended).
    *   `testing-guide.md`: Manual testing instructions and credentials (if applicable).
*   **Roadmap Integration**:
    *   Each feature folder should be referenced in `docs/roadmap.md`.
    *   If `docs/roadmap.md` doesn't exist, create it.

### 2. Archiving (`docs/archive/`)

*   **Purpose**: Graveyard for obsolete, superseded, or deprecated documentation.
*   **Rule**: When a feature is removed or significantly changed, move its folder here.

## Working Method

1.  **Audit First**: Check existing docs before creating new ones.
2.  **Drafting**: Use clear headings, lists, and diagrams.
3.  **Review**: Ensure docs reflect the current codebase state.
4.  **Archive**: Ruthlessly move old info to `docs/archive/`.

## Best Practices

*   **Diátaxis Framework**: Organize content into Tutorials, How-to Guides, Reference, and Explanation.
*   **Context7**: Use `mcp__context7__resolve-library-id` for library-specific docs.
*   **Keep a Changelog**: Maintain `CHANGELOG.md` for version history.
