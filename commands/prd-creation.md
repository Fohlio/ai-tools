---
name: prd-creation
description: Create a comprehensive Product Requirements Document (PRD) for a new feature with Project Manager assistance.
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskQuestion, TodoWrite, mcp__stitch__create_project, mcp__stitch__generate_screen_from_text, mcp__stitch__list_screens, mcp__stitch__get_screen, mcp__user-Figma__get_design_context, mcp__user-Figma__get_screenshot, mcp__user-Figma__get_metadata
---

# PRD Creation Workflow

You are orchestrating the creation of a Product Requirements Document (PRD). Your goal is to transform a high-level feature idea into a detailed, technically feasible specification.

## Phase 1: Exploration & Context

1. **Initial Concept**:
   - **Ask the user**: "What is the core idea of the new feature? What problem are we solving?" **Use the `AskQuestion` tool to gather structured input if there are multiple options or specific details needed.**

2. **Architectural Audit**:
   - **Spawn code-architect agent** to:
     - Analyze the existing codebase for relevant integration points.
     - Identify technical constraints or existing patterns that the new feature should follow.
     - Provide a brief "Technical Context" summary for the Project Manager.

## Phase 2: Requirements Gathering

1. **Spawn project-manager agent** to:
   - Interview the user with targeted questions based on the feature idea and technical context. **Use the `AskQuestion` tool for structured feedback.**
   - Topics to cover: Target audience, core user stories (JTBD), functional requirements, non-functional requirements (performance, security), and success metrics.
   - Identify potential edge cases and out-of-scope items.

2. **Design Resource Check**:
   - **Ask the user**: "Do you have existing designs for this feature (Figma, mockups, wireframes)?" **Use the `AskQuestion` tool to present choices (e.g., Figma, Stitch, None).**
   - **If Figma designs exist**: Use **Figma MCP** to extract design context:
     - Request the Figma URL from the user (format: `https://figma.com/design/:fileKey/:fileName?node-id=X-Y`).
     - Use `mcp__user-Figma__get_screenshot` to capture visual reference of the design.
     - Use `mcp__user-Figma__get_design_context` to extract UI structure and generate implementation hints.
     - Use `mcp__user-Figma__get_metadata` to get component names, variants, and design tokens.
     - Include extracted design context and screenshots in the PRD for implementation guidance.
   - **If no designs exist**: Suggest using **Stitch MCP** to generate UI mockups from the requirements:
     - Use `mcp__stitch__create_project` to create a design project for the feature.
     - Use `mcp__stitch__generate_screen_from_text` to generate initial UI concepts based on user stories and requirements.
     - Include generated design references in the PRD for implementation guidance.

## Phase 3: Drafting the PRD

1. **Document Structure**:
   The Project Manager will draft the PRD using the following structure:
   - **Overview**: Problem statement and goals.
   - **Target Audience**: Who is this for?
   - **User Stories**: "As a [user], I want to [action], so that [benefit]."
   - **Functional Requirements**: Detailed list of what the feature *must* do.
   - **Technical Constraints**: Integration points, data models, and performance targets (informed by Phase 1).
   - **UI/UX Requirements**: Key interactions and visual expectations. Link to Figma designs or Stitch-generated mockups.
   - **Phasing & MVP**: What goes into the first release vs. later.
   - **Success Metrics**: How will we know it's working?

2. **Review & Refine**:
   - Show the draft to the user for feedback. **Use the `AskQuestion` tool to confirm approval or gather specific refinements.**
   - Refine the document based on user input.

## Phase 4: Finalization & Handoff

1. **Spawn librarian agent** to:
   - Index the new PRD in the project's documentation registry.
   - Ensure all cross-references to other documents (ADRs, existing PRDs) are accurate.
   - Verify adherence to documentation best practices.

2. **Spawn code-refactorer agent** to:
   - Review the PRD for technical clarity and consistency.
   - Ensure the requirements are actionable and don't introduce unnecessary complexity.

3. **Completion**:
   - Save the PRD (typically to `docs/features/[feature-name]/prd.md`).
   - Offer to start the implementation using the `/implement-feature` command. **Use the `AskQuestion` tool to let the user choose the next step.**
