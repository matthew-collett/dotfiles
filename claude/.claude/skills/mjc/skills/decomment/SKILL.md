---
name: decomment
description: Scrub slop comments from code that's already written, omit them or rewrite them to stand alone. Use when I say "decomment", "clean the comments", or "fix the comments".
disable-model-invocation: true
---

Enforce my comment rules (the "Comments" block in CLAUDE.md) on code that's already written.
This edits my working files, so triage first, change nothing without my OK.

## 1. Scope
Default to the uncommitted diff: `git diff HEAD`. If that's empty, or I name files/paths, use
those. Judge only comments on changed lines unless I say scan the whole file.

## 2. Triage, change nothing yet
Judge each comment in scope against the rule (omit or stands-alone; WHY not WHAT; no transient
references, the bug, ticket, conversation, test data, "now/previously"). Classify:
- keep, earns its place, already stands alone.
- remove, WHAT-restating, chatty, banner, redundant, or the code is self-evident.
- rewrite, a durable WHY is buried under transient/unprofessional wording; give the
  standalone replacement.
Show a list: `file:line` → verdict + replacement (or "delete") + one-line why.

## 3. Apply, on my OK
On approval, apply the removes and rewrites in one pass; I can veto individual ones first. Touch
only comments, never logic. Report what changed.
