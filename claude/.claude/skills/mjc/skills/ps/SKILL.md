---
name: ps
description: Sync a plan's @me/@ai markers. Use after I've left notes on a plan, or to work my blockers.
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `dirs.plans` and `dirs.repos`.

## 1. Find the plan
`find <dirs.plans> -name '*.md' -type f`. Nothing → ask which plan. Otherwise the newest by mtime
(`ls -t`, take the first), unless I named one.

## 2. Work the markers
`grep -nE '^[[:space:]]*@(me|ai)' <plan>`, handle every hit, never eyeball.
- `@me <note>` = my note to you; you resolve it. Decide, apply the change to the plan, delete the
  line, and say what you did in chat. If it's ambiguous or a blocker you can't call, leave it and ask me.
- `@ai <note>` = your note to me; I resolve it, never you. Surface it in chat and wait. Once I answer
  (in chat or by editing the line), fold it in and delete it.

One reply per item. Never implement while any `@me` or `@ai` remains. Touch only this plan file.
