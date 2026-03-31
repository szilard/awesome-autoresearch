# Contributing to awesome-autoresearch

Thanks for helping improve this list.

The goal is simple: collect public, concrete autoresearch use cases and make them easy to scan.

## What belongs here

We accept public examples such as:

- GitHub repositories
- X threads or posts
- Blog posts and articles
- Project homepages or public write-ups

A good entry clearly shows:

- **Scenario**: where autoresearch is used
- **Method**: what the autoresearch loop actually does
- **Value**: why it matters

It should also satisfy at least one of these:

- explicitly uses the term `autoresearch`
- explicitly cites Karpathy's autoresearch
- clearly implements a modify → verify → keep/discard → repeat loop

If a project is merely an AI agent for research, monitoring, scraping, summarization, or workflow automation, it probably does **not** belong here.

## What does not belong here

Please do not submit:

- Generic research agents or monitoring agents with no explicit autoresearch loop
- Generic multi-agent systems with no keep/discard verification pattern
- Plain RAG, scraping, summarization, or dashboard projects unless they explicitly operate as autoresearch loops
- Pure conceptual discussion
- Tool lists without a real workflow
- Marketing fluff with no concrete example
- Private, dead, or inaccessible sources
- Multi-paragraph explanations inside category files

## Core rules

### 1. Keep every entry to one sentence

Every entry must stay on a single bullet line.

### 2. Use autoresearch-domain classification

Choose the category based on the direct autoresearch application domain, not on generic labels like "agent", "research", or "monitoring".

### 3. Prefer clarity over cleverness

If a reader cannot understand the use case in one quick pass, rewrite it.

### 4. Prefer fewer, stronger entries

High-signal curation is more important than volume.

## Entry format

Use this exact format:

```md
- [Name](URL) - Industry: one-sentence description of the autoresearch use case.
```

### Good examples

```md
- [AutoKernel](https://example.com) - GPU optimization: applies Karpathy-style autoresearch to kernel bottlenecks, benchmarking each change and keeping only verified speedups.
- [Claudini](https://example.com) - AI safety research: uses an autoresearch-style loop to discover and benchmark stronger LLM attack algorithms.
- [Autoresearch Genealogy](https://example.com) - Genealogy: runs `/autoresearch` prompts to expand family trees, verify claims, and keep a structured evidence-backed vault.
```

### Weak examples

```md
- [Cool Tool](https://example.com) - AI agent for research.
```

Why weak:

- No concrete scenario
- No explicit autoresearch loop
- No method
- No outcome
- Too vague to classify

## Where to place entries

Add entries to one of these files:

- `categories/scientific-research.md`
- `categories/software-systems-optimization.md`
- `categories/evaluation-red-teaming.md`
- `categories/finance-trading.md`
- `categories/personal-knowledge-humanities.md`
- `categories/infra-skills-forks.md`
- `categories/related-practices-discussions.md`

If an example could fit multiple categories, choose the one that best represents the direct autoresearch use case.

`README.md` is the homepage aggregate, so contributors should edit category files first and then refresh the aggregate instead of treating the README as the primary source of truth.

### Quick classification rule

- **Domain case**: the repo shows autoresearch being applied to a concrete field like science, trading, evaluation, genealogy, or systems optimization.
- **Infra / Skills / Forks**: the repo mainly provides the engine, harness, port, skill, plugin, dashboard, memory layer, or orchestration layer for running autoresearch.
- **Related Practices / Discussions**: the source is a public thread, interview, forum post, or article describing a concrete autoresearch practice, but there is no strong open-source repo or standalone case page yet.

When unsure, prefer **not** to submit rather than stretching the definition.

## Style guidance

- Keep wording concrete.
- Name the industry or domain explicitly.
- Describe the autoresearch loop, not just the tool.
- Avoid buzzwords unless the source itself depends on them.
- Do not add long commentary under entries.

## Pull request checklist

Before submitting, confirm:

- [ ] The source is public and accessible.
- [ ] The entry is one sentence.
- [ ] The source is directly about autoresearch, not just a generic research agent.
- [ ] The entry explains scenario + method + value.
- [ ] The category reflects the direct autoresearch use case.
- [ ] The wording is concise and easy to scan.
