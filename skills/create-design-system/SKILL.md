---
name: ai-tools:create-design-system
description: Guides the creation of a robust design system covering goals, foundations, components, documentation, and governance. Use when creating a new design system, establishing UI foundations, defining component libraries, or setting up design tokens.
---

# Create Design System

A comprehensive guide to building a design system that ensures coherence and maintainability over time.

## Strategy & Goals

1.  **Define Purpose**: Why do you need a design system? (e.g., consistency, speed, accessibility, brand alignment).
2.  **Identify Users**: Who are the primary users? (product designers, engineers, marketing, external vendors).
3.  **Set Metrics**: Define measurable success metrics (e.g., reduced design debt, faster feature delivery, fewer UI bugs).

## Team & Ownership

1.  **Core Team**: Assign a core systems team (design, engineering, PM, optionally brand/content).
2.  **Responsibilities**: Clarify who designs, builds, reviews, and approves changes.
3.  **Allocation**: Allocate explicit time in roadmaps for system work and maintenance.

## Principles & Foundations

1.  **Design Principles**: Write 3–7 principles guiding decisions (e.g., simple, inclusive, scalable).
2.  **Visual Foundations**: Define color palette, typography scale, spacing, grid, elevation, motion.
3.  **Brand Foundations**: Capture logo usage, imagery, icon style, voice and tone references.

## Audit & Inventory

1.  **Audit**: Review current products for patterns, inconsistencies, and tech constraints.
2.  **Inventory**: Create an inventory of UI elements (buttons, inputs, cards, nav, modals, etc.) with screenshots.
3.  **Decide**: Decide what to keep, refactor, or deprecate; note gaps.

## Tokens & Theming

1.  **Define Tokens**: Create tokens for color, typography, spacing, radius, shadows, motion, z-index.
2.  **Map Implementation**: Map tokens to platform implementations (CSS variables, iOS/Android tokens).
3.  **Plan Theming**: Plan for dark mode, brand variants, and high contrast from the start.

## Components & Patterns

1.  **Prioritize Starter Set**: Buttons, inputs, selects, text fields, alerts, modals, tooltips, nav, tabs, tables.
2.  **Define States**: For each component, define hover, focus, active, disabled, loading, error, success.
3.  **Establish Patterns**: Define solutions for forms, authentication, navigation flows, data display.

## Accessibility

1.  **Standards**: Adopt accessibility standards (e.g., WCAG) as non-negotiable.
2.  **Guidelines**: Document guidelines for contrast, focus states, keyboard interactions, ARIA, motion.
3.  **Testing**: Include checklists per component and embed testing into the workflow.

## Documentation & Guidelines

1.  **Central Hub**: Centralize documentation in a single discoverable site.
2.  **Component Docs**: Document purpose, usage, props/variants, anatomy, do/don’t examples.
3.  **Technical Specs**: Include code snippets, design specs, and platform-specific notes.

## Engineering Integration

1.  **Stack**: Choose the implementation stack (e.g., React + CSS vars, native libraries).
2.  **Distribution**: Provide versioned packages or libraries for easy adoption.
3.  **Contribution**: Define workflow from feature teams back into the system.

## Governance & Maintenance

1.  **Rules**: Set rules for proposing, reviewing, deprecating, and updating components.
2.  **Cadence**: Define release cadence and changelog expectations.
3.  **Audits**: Schedule regular audits to remove unused patterns and update for new needs.

## Adoption & Communication

1.  **Onboarding**: Plan usage guides, starter kits, example screens, playground files.
2.  **Education**: Run workshops or office hours to help teams adopt the system.
3.  **Feedback**: Track adoption and satisfaction via surveys or telemetry.

## Scaling & Evolution

1.  **Extensibility**: Define rules for extending components/tokens without forking.
2.  **Multi-platform**: Support multiple products/platforms with shared foundations + local extensions.
3.  **Strategy Review**: Periodically revisit principles and goals to keep aligned with product strategy.
