# Context Economics Quick Reference

Token costs, compliance metrics, and context thresholds for informed decisions about AI-assisted development.

**Last updated:** September 2026. Prices change frequently — verify at each provider's pricing page before budgeting.

---

## Token Costs by Model (September 2026)

### Anthropic (Claude)

| Model | Input $/MTok | Output $/MTok | Context Window | Best For |
|-------|-------------|--------------|----------------|----------|
| **Fable 5.1** | $10 | $50 | 1M tokens | Hardest reasoning and long-horizon agentic work; premium tier |
| **Opus 5** | $5 | $25 | 1M tokens | Default for coding in this workshop: complex reasoning, architecture, multi-file changes |
| **Sonnet 5** | $2 | $10 | 1M tokens | Well-scoped tasks, cheaper worker sub-agents |
| **Haiku 4.5** | $1 | $5 | 200k tokens | Simple edits, classification, quick completions |

Batch API: 50% discount on all tokens. Prompt caching: 0.1x input on cache hits (0.025x on Fable 5.1). Fast mode (Opus 5 and Opus 4.8 only, `/fast` in Claude Code): $10 / $50 per MTok. Previous generation still served at unchanged prices: Opus 4.8 / 4.7 / 4.6 ($5 / $25), Sonnet 4.6 ($3 / $15).

Source: platform.claude.com/docs/en/about-claude/pricing (accessed 2026-09-10)

### OpenAI

| Model | Input $/MTok | Output $/MTok | Context Window | Best For |
|-------|-------------|--------------|----------------|----------|
| **GPT-6 Astra** | $10 | $50 | [unverified] | Flagship (released 2026-09-03) |
| **GPT-5.6-Sol** | $4 | $20 | [unverified] | Top coding/agentic tier; promotional price through 2026-11-21 |
| **GPT-5.6-Terra** | $2 | $12 | [unverified] | Mid-tier |
| **GPT-5.6-Luna** | $0.20 | $1.20 | [unverified] | Budget tier |
| **GPT-5.5** | $5 | $30 | <272k | Previous flagship, still listed |
| **GPT-5.4** | $2.50 | $15 | <272k | Still listed |
| **GPT-4.1** | $2 | $8 | 1M tokens | Still listed; 1M context |

Cached input: 10% of standard price. Batch API: 50% off. Older models (GPT-5.4 Mini/Nano, o3, o4-mini) remain listed at unchanged prices.

Source: developers.openai.com/api/docs/pricing (accessed 2026-09-10)

### Google (Gemini)

| Model | Input $/MTok | Output $/MTok | Context Window | Notes |
|-------|-------------|--------------|----------------|-------|
| **Gemini 3.1 Pro Preview** | $2 (≤200k) / $4 (>200k) | $12 / $18 | [unverified] | Current Pro-tier flagship; no GA "Gemini 3 Pro" yet |
| **Gemini 3.8 / 3.7 / 3.6 Flash** | $0.75 | $3.75 | [unverified] | Promotional price through 2026-12-31, then $1.50 / $7.50 |
| **Gemini 3.5 Flash** | $1.50 | $9 | [unverified] | |
| **Gemini 2.5 Pro** | $1.25 / $2.50 | $10 / $15 | 1M tokens | Same >200k surcharge |
| **Gemini 2.5 Flash** | $0.30 | $2.50 | — | Budget option |

Long context surcharge: >200k tokens roughly doubles input pricing on Pro models.

Source: ai.google.dev/gemini-api/docs/pricing (accessed 2026-09-10)

### DeepSeek

| Model | Input $/MTok (cache miss) | Output $/MTok | Context Window | Notes |
|-------|--------------------------|--------------|----------------|-------|
| **DeepSeek V4.1 Flash** | $0.15 off-peak / $0.30 peak | $0.60 / $1.20 | 1M tokens | Current default; cache hits ~$0.003–0.006 |
| **DeepSeek V4 Pro** | $0.66 / $1.32 | $1.98 / $3.96 | 1M tokens | Being phased out; routes to Flash pricing from 2026-09-14 |

Peak hours: 01:00–04:00 and 06:00–10:00 UTC, Mon–Fri. V3.x and R-series are no longer listed.

Source: api-docs.deepseek.com/quick_start/pricing (accessed 2026-09-10)

### Quick Comparison (coding-tier models)

**Flagship tier** (best quality):

| Provider | Model | Input $/MTok | Output $/MTok | Context |
|----------|-------|-------------|--------------|---------|
| Anthropic | Fable 5.1 | $10 | $50 | 1M |
| OpenAI | GPT-6 Astra | $10 | $50 | [unverified] |
| Anthropic | Opus 5 | $5 | $25 | 1M |
| OpenAI | GPT-5.6-Sol | $4 | $20 | [unverified] |
| Google | Gemini 3.1 Pro Preview | $2 | $12 | [unverified] |
| Anthropic | Sonnet 5 | $2 | $10 | 1M |

**Budget tier** (best value):

| Provider | Model | Input $/MTok | Output $/MTok | Context |
|----------|-------|-------------|--------------|---------|
| Anthropic | Haiku 4.5 | $1 | $5 | 200k |
| Google | Gemini 3.8 Flash | $0.75 | $3.75 | [unverified] |
| OpenAI | GPT-5.6-Luna | $0.20 | $1.20 | [unverified] |
| DeepSeek | V4.1 Flash | $0.15–0.30 | $0.60–1.20 | 1M |

---

## Typical Session Costs

A typical agentic coding session (10-20 tool calls, ~50k tokens total):

| Model tier | Approx. cost per session |
|-----------|------------------------|
| Nano/budget (GPT-5.6-Luna, DeepSeek V4.1 Flash, Gemini Flash) | < $0.05 |
| Mid-tier (Haiku 4.5, Sonnet 5, Gemini 3.1 Pro) | $0.10-$0.50 |
| Coding-tier (Opus 5, GPT-5.6-Sol) | $0.25-$1.25 |
| Premium (Fable 5.1, GPT-6 Astra) | $0.50-$2.50 |
| Multi-agent (3 agents, coding-tier) | $0.75-$4.00 |

---

## Context Utilization Thresholds

Quality degrades based on **absolute token volume**, not percentage of window capacity. The thresholds below apply regardless of whether your model has a 200K or 1M context window — the degradation is driven by attention dilution and positional effects, not by how full the window is.

| Token Usage | Observed Behavior | Action |
|-------------|-------------------|--------|
| < ~50K | Normal operation | Continue |
| ~100K | Precision begins to drop; agent starts missing instructions | Consider `/compact` |
| ~150K+ | Hallucination rate increases; behavior becomes erratic | Use `/compact` with specific focus, or start a new session (write HANDOFF.md first) |

![The 1M Context Window — showing system prompts, MCP tools, memory files, and messages filling the window from left to right, with Optimal, Caution, and Danger zones](../../assets/context-window-diagram.png)

The lower end of each range applies to smaller context windows; larger windows with better positional encoding may tolerate slightly more. But a 1M window at 200K tokens used will perform worse than a fresh session — more context is not always better context.

Source: Practitioner guidance informed by the "Lost in the Middle" paper (Liu et al., 2023), which established that LLM accuracy degrades when relevant information is buried in long contexts, regardless of total window size.

---

## Instruction File Design — What the Research Shows

How instruction file design affects agent behavior:

**Instruction count degrades compliance.** [Jaroslawicz et al. (2025)](https://arxiv.org/abs/2507.11538) measured 20 LLMs on the IFScale benchmark (500 instructions). Claude Sonnet dropped from ~100% compliance at 10 instructions to ~53% at 500. The relationship is roughly linear for Claude models — more instructions means lower compliance per instruction.

**Context files can hurt if poorly written.** [ETH Zurich (2026)](https://arxiv.org/html/2602.11988v1) tested context files (AGENTS.md) across 300 SWE-bench Lite tasks. LLM-generated context files *reduced* performance by ~2% and increased cost 20%. Human-written files improved performance by ~4%. Quality matters more than quantity.

**Practical guidance** (broad community experience, not rigorous measurement):

| Design choice | Effect |
|---|---|
| Fewer, focused rules (< ~15) | Higher compliance per rule |
| Imperative phrasing ("Do X", "Never Y") | Stronger adherence than descriptive ("X is preferred") |
| Shorter files (< ~200 lines) | Better than long files — consistent with Jaroslawicz instruction-count findings |
| Multiple focused files | Better than one monolithic file — allows selective loading |

Key takeaway: **Short + imperative + selective loading = best results.** Anthropic's own documentation treats CLAUDE.md as context, not enforcement — there are no compliance guarantees.

Sources:
- Jaroslawicz et al., ["How Many Instructions Can LLMs Follow at Once?"](https://arxiv.org/abs/2507.11538) — arXiv (July 2025)
- ETH Zurich, ["Evaluating AGENTS.md"](https://arxiv.org/html/2602.11988v1) — arXiv 2602.11988 (February 2026)
- Practitioner observations from Claude Code community (2025-2026)

---

## Multi-Agent Cost vs. Quality

| Metric | Single Agent | Multi-Agent | Delta |
|--------|-------------|-------------|-------|
| Output quality score | baseline | +90.2% | Significant improvement |
| Token consumption | 1x | ~15x | Substantial cost increase |

ROI is positive for complex, parallelizable tasks. ROI is negative for simple tasks where coordination overhead dominates. At September 2026 Opus 5 pricing ($5/$25 per MTok), a 3-agent session on a medium feature costs roughly $3-8 total; on Sonnet 5 ($2/$10) roughly $1-3.

Source: Anthropic multi-agent research benchmarks (2025)

---

## When Human Work Is Cheaper

A rough decision heuristic (recalibrated for September 2026 pricing):

- **Task takes a human < 2 minutes**: at current pricing, even the cheapest agent call may not save time (context loading + verification overhead)
- **Task is repetitive across many files**: multi-agent ROI improves sharply; automation wins decisively
- **Task requires judgment calls every step**: human-in-the-loop beats full automation
- **Task output is hard to verify**: add verification cost to the total
- **DeepSeek/Haiku tier**: at < $0.10 per session, the cost barrier has effectively disappeared — the question is quality, not price

Rule of thumb: if you can't describe the success criteria in one sentence, the briefing cost may exceed the token cost.

---

## Sources

- Anthropic pricing — platform.claude.com/docs/en/about-claude/pricing (accessed 2026-09-10)
- OpenAI pricing — developers.openai.com/api/docs/pricing (accessed 2026-09-10)
- Google Gemini pricing — ai.google.dev/gemini-api/docs/pricing (accessed 2026-09-10)
- DeepSeek pricing — api-docs.deepseek.com/quick_start/pricing (accessed 2026-09-10)
- Anthropic, context window guidance — engineering blog (2025)
- Jaroslawicz et al., "How Many Instructions Can LLMs Follow at Once?" — arXiv (July 2025)
- ETH Zurich, "Evaluating AGENTS.md" — arXiv 2602.11988 (February 2026)
- Anthropic, multi-agent quality benchmarks — engineering blog (2025)
- Nelson et al., "Lost in the Middle" — Transactions of ACL (2023)
