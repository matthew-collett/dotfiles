---
name: triage
description: Investigate a tracker ticket read-only. Paste the URL/key plus any hints (which file, what changed). Fetch the ticket, read the pointed-at code, report. Use when I say "triage this", "investigate this ticket", or paste a ticket URL.
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `tracker`. This skill needs a tracker: if `tracker.type` is
`none`, say so and stop. Input: a ticket URL or key, plus optional hints (a file/symbol, what changed).

READ-ONLY. Investigate and report; never edit files, write a plan, build, or commit. The report is the
deliverable. If a fix is needed next, say so and stop; I'll plan it separately.

## 1. Fetch the ticket
Pull the key from the URL, or take it verbatim, then fetch via the tracker's API:
- jira: load `mcp__atlassian__getJiraIssue` (ToolSearch `select:mcp__atlassian__getJiraIssue`); call it
  with `cloudId` from `tracker.url`, `responseContentFormat: markdown`, and `fields` including `comment`.
- (a second tracker later is a parallel bullet.)
If a screenshot/attachment can't be read, say so; never guess what it shows.

## 2. Locate the code
If I pointed at a file/symbol, read that first. Otherwise grep the repo for the ticket's key terms.
Prefer the repo I'm in; if it clearly targets another repo, name it rather than guessing across repos.

## 3. Investigate
Trace the real cause, not the symptom. When "recently changed" is in play, check git history
(`git log -S`, `git blame`, `git show`). Separate what you verified from what you're inferring; call
out unknowns rather than speculating.

## 4. Report
Concise, no preamble: what the ticket asks, the root cause with `file:line` references, and any open
questions (unreadable attachment, cross-repo, needs my call).
