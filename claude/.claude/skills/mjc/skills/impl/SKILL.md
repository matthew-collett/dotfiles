---
name: impl
description: Implement an approved, fully-resolved plan. Use when I say "implement this", "build the plan", or "start implementing".
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `dirs.plans`, `dirs.repos`, and `tracker`. Missing
→ stop, say it doesn't exist, ask me to create it.

## 1. Find the plan
`find <dirs.plans> -name '*.md' -type f`. Nothing → ask which plan. Otherwise the newest by mtime
(`ls -t`, take the first), unless I named one.

## 2. Gate: only a resolved plan
`grep -nE '^[[:space:]]*@(me|ai)' <plan>`. If ANY `@me` or `@ai` remains, STOP: the plan isn't
resolved. Say the markers need working first, and don't touch code.

## 3. Get onto the right branch
The plan's repo is its path segment (`<dirs.plans>/<repo>/…`) at `<dirs.repos>/<repo>`. The branch is
per `rules/git.md`: `feat-<KEY>` using the key from the plan's filename when a tracker's set, else `feat-<slug>`.
- `git -C <repo> rev-parse --abbrev-ref HEAD`; check for uncommitted changes.
- Already on the correct, current feature branch for this plan → nothing to do.
- Otherwise, off a freshly-pulled default (branch naming per `rules/git.md`):
  `b=$(git_main_branch); git checkout "$b" && git pull origin "$b" && git checkout -b <branch>`.
- NEVER discard work: a dirty tree, or unrelated/unpushed work on the current branch → stop and ask.
  Ambiguous target repo (cross-repo plan set) → confirm which.

## 4. Build it
Work the plan's Sequencing in order. My working-mode rules apply: one change at a time, lowest level
first, stop for review between; describe non-trivial edits before applying. Don't commit; I run the
commit skills.
