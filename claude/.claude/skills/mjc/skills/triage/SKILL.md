---
name: triage
description: Investigate a tracker ticket read-only. Paste the URL/key plus any hints (which file, what changed). Fetch the ticket, read the pointed-at code, report. Use when I say "triage this", "investigate this ticket", or paste a ticket URL.
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `tracker`. This skill needs a tracker: if `tracker.type` is `none`, say so and stop. Input: a ticket URL or key, plus optional hints (a file/symbol, what changed).

READ-ONLY. Investigate and report; never edit files, write a plan, build, or commit. The report is the deliverable. If a fix is needed next, say so and stop; I'll plan it separately.

## 1. Fetch the ticket
Pull the key from the URL, or take it verbatim, then fetch via the tracker's API:
- jira: load `mcp__atlassian__getJiraIssue` (ToolSearch `select:mcp__atlassian__getJiraIssue`); call it with `cloudId` from `tracker.url`, `responseContentFormat: markdown`, and `fields` including `comment`.
- (a second tracker later is a parallel bullet.)

## 2. Locate the code
If I pointed at a file/symbol, read that first. Otherwise run one search for the ticket's key terms. Prefer the repo I'm in.

## 3. Gate
Before investigating, you must be able to state the ask in one line and name the code area. If you can't, or at any point you hit something you can't read, a different repo, or a gap in the picture, output only this and stop:

```
**Blocked:** <what's missing or unclear>
**Need:**
1. <specific question>
```

## 4. Investigate
Bug: trace the root cause, not the symptom. Feature: find where it lands and what already exists. When "recently changed" is in play, check git history (`git log -S`, `git blame`, `git show`). Mark anything unverified `(inferred)`.

Never present a guess as the cause. If you've exhausted read-only checks without a definitive cause, Finding is `Not found`, Evidence lists what you ruled out, and Next names what would settle it.

Runtime data (database queries, logs, cluster commands): never run first. Output this and wait for my OK:

```
**Want to run:** `<exact command>`
**To answer:** <one line>
```

## 5. Report
Exactly this: one blank line between sections, no preamble, no code blocks, no narration of what you searched.

```
### Type
bug | feature

### Ask
<one line>

### Finding
<≤2 lines: root cause, where it lands, or `Not found`> `file:line`

### Evidence
- ≤3 bullets, `file:line` + one line each

### Open
- ≤3 bullets; omit if none

### Next
<one line>
```
