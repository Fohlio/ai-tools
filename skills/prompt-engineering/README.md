# Prompt Engineering Skill

A comprehensive, research-backed skill for creating, editing, reviewing, and enhancing AI prompts. Optimizes prompts for specific models (Claude 4.5, GPT-5.2, Gemini 3, DeepSeek R1) and use cases based on the latest research and best practices from 2026.

## Overview

This skill provides:

- **Model-specific optimization** for Claude 4.5, GPT-5.2, Gemini 3.0, DeepSeek R1, Qwen 3, and Qwen 3 Coder
- **65+ prompting techniques** from systematic research review (including agent-specific patterns)
- **Prompt library integration** - Search and adapt from major prompt collections
- **Agent workflows** - Multi-agent orchestration, memory systems, security patterns, cost optimization
- **Cost optimization** - Including ultra-low-cost DeepSeek R1 (10x cheaper)
- **Open-source option** - DeepSeek R1 with full open weights
- **Use case guidance** for when to use each technique
- **Evaluation framework** for testing and improving prompts
- **Comprehensive references** with links to research, documentation, and examples

## Key Features

### Evidence-Based Approach

Based on "The Prompt Report: A Systematic Survey of Prompting Techniques" (2024), which analyzed 1,565 papers to identify proven techniques.

### Model-Specific Best Practices (2026 Models)

Different models require different approaches:
- **Claude 4.5** (Sonnet/Opus/Haiku): Extended thinking, context awareness, autonomous agents, state-of-the-art coding
- **GPT-5.2** (Instant/Thinking/Pro): CTCO framework, adaptive reasoning, 70.9% wins vs professionals
- **Gemini 3** (Pro/Flash/Pro Image): Dynamic thinking, 1M context, simplified prompts, multimodal excellence
- **DeepSeek R1** (Open-source): Zero-shot only, no system prompts, built-in reasoning, 85% cost savings, o1-comparable performance
- **Qwen 3** (0.6B-235B): Hybrid thinking mode, 119 languages, Apache 2.0, 128K context, multilingual excellence
- **Qwen 3 Coder** (0.6B-480B): MCP protocol, 256K-1M context, 119 programming languages, SWE-Bench oriented, execution-driven RL

### Prompt Libraries Integration

Access to 1000+ proven prompts from:
- LangChain Hub (versioned, model-specific)
- Anthropic Prompt Library (Claude 4.5-optimized)
- OpenAI Cookbook (GPT-5.2, CTCO templates)
- Google AI Studio (Gemini 3, multimodal)
- Community collections (GitHub, FlowGPT, PromptHero)
- Context7 integration for latest official examples

### Comprehensive Technique Library

- Chain-of-Thought (CoT)
- Few-Shot Learning
- ReAct (Reasoning + Acting)
- Metaprompting
- Self-Consistency
- Zero-Shot optimization
- CTCO Framework (GPT-5.2)
- Extended Thinking (Claude 4.5)
- Dynamic Thinking (Gemini 3)
- **Agent Loop Prompting** (OpenAI Codex patterns)
- **Prompt Caching Optimization**
- **Context Window Management**
- **Tool Schema Design**
- **Self-Correction & Planning Patterns**
- And 50+ more...

### Practical Tools

- Prompt enhancement process
- Evaluation criteria
- Test case creation
- Common anti-patterns to avoid
- Quick reference selection matrix

## When to Use

- Creating new prompts from scratch
- Optimizing existing prompts for cost/performance
- Reviewing prompts for best practices
- Choosing the right technique for a use case
- Adapting prompts across different models
- Reducing costs (DeepSeek R1 = 85% savings)
- Reducing hallucination or improving accuracy
- Structuring complex multi-step prompts
- **Building software agents with tool calling**
- **Optimizing agent loops and context management**
- **Multi-turn conversations with prompt caching**
- Open-source / self-hosting requirements

## Research Foundation

This skill synthesizes knowledge from:

- **The Prompt Report** - Systematic survey of 1,565 papers
- **Anthropic Documentation** - Claude 4.5-specific best practices (Nov 2025)
- **Anthropic Claude Code** - Extension-based agent architecture, context loading strategies (Jan 2026)
- **OpenAI Documentation** - GPT-5.2 guidelines and CTCO framework (Dec 2025)
- **OpenAI Codex Architecture** - Production agent loop patterns (Jan 2025)
- **Google Documentation** - Gemini 3 prompt strategies (Nov 2025)
- **Academic Research** - ReAct, CoT, and other foundational papers
- **Prompt Libraries** - 1000+ curated prompts from major collections
- **2026 Agent Research** - Multi-agent orchestration, memory systems, security, evaluation, cost optimization
  - Agentic workflows best practices
  - Tool calling optimization (ToolGen, parallel function calling)
  - Memory systems (CMA, EverMemOS, Mem0)
  - Security & guardrails (OWASP)
  - Evaluation frameworks (HB-Eval, Agent-Pex, HAL)
  - MCP integration patterns
  - LangSmith debugging strategies
  - Framework comparison (LangGraph, CrewAI, AutoGen)

## Quick Start

Activate this skill when:
- You need to write or improve a prompt
- You're unsure which prompting technique to use
- You want model-specific optimization
- You need to reduce errors or improve output quality

The skill will guide you through:
1. Understanding your goal
2. Selecting appropriate techniques
3. Structuring for your target model
4. Optimizing for agents (if applicable)
5. Testing and validation
6. Documentation and iteration

## References

**Core Prompting:**
- [The Prompt Report (2024)](https://trigaten.github.io/Prompt_Survey_Site/)
- [Claude 4.5 Best Practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [GPT-5.2 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide/)
- [Gemini 3 Developer Guide](https://ai.google.dev/gemini-api/docs/gemini-3)
- [ReAct Paper (2022)](https://arxiv.org/abs/2210.03629)

**Agent Systems (2026):**
- [OpenAI Codex Agent Loop](https://openai.com/index/unrolling-the-codex-agent-loop/) - Prompt-centric architecture
- [Anthropic Claude Code](https://code.claude.com/docs/how-claude-code-works) - Extension-based architecture
- [Practical Guide for Agentic AI Workflows](https://www.emergentmind.com/papers/2512.08769)
- [Multi-Agent Orchestration](https://onabout.ai/p/mastering-multi-agent-orchestration-architectures-patterns-roi-benchmarks-for-2025-2026)
- [HB-Eval Framework](https://labs.sciety.org/articles/by?article_doi=10.20944%2Fpreprints202512.2186.v1)
- [HAL: Holistic Agent Leaderboard](https://hal.cs.princeton.edu/)
- [OWASP AI Agent Security](https://cheatsheetseries.owasp.org/cheatsheets/AI_Agent_Security_Cheat_Sheet.html)
- [MCP Best Practices](https://mcp-best-practice.github.io/mcp-best-practice/)

## Files Included

- **SKILL.md** - Main skill with model-specific best practices, techniques, and agent patterns
- **techniques-catalog.md** - 65+ prompting techniques with examples (including agent-specific patterns)
- **model-comparison.md** - Side-by-side model comparison and adaptation guide
- **prompt-libraries.md** - Comprehensive prompt library resources and discovery
- **agent-research-2026.md** - ⭐ NEW: Comprehensive research summary on production-ready agentic systems (13 sections, ~18K words)
- **agent-quick-reference.md** - ⭐ NEW: Fast lookup guide for agent development (checklists, decision trees, metrics)

## Integration

This skill uses Context7 MCP integration to fetch the latest documentation when needed:
- `/anthropics/courses` - Interactive Claude 4.5 tutorials
- `/anthropics/anthropic-cookbook` - Claude code examples and patterns

The skill also provides direct access to major prompt libraries:
- LangChain Hub for versioned prompts
- Anthropic/OpenAI/Google official prompt collections
- Community resources (GitHub, FlowGPT, PromptHero)

---

**Note:** This skill emphasizes that prompting is an evidence-based engineering discipline, not an art. Every recommendation is grounded in research and real-world testing.
