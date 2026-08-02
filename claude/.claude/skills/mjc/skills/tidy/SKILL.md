---
name: tidy
description: Clean up stray/personal local Claude config and leftover auto-memory. Use when I say "tidy" or "clean up local claude config".
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `dirs.tidy` (roots to sweep; missing/empty → just
the auto-memory sweep below). DRY-RUN by default, delete nothing until I confirm.

## 1. Find
- Under each root in `dirs.tidy`: `.claude/settings.local.json`, `.claude/settings.json`,
  `CLAUDE.local.md`, stray `.claude/` dirs, `.omc/` state dirs.
- Auto-memory: any `~/.claude/projects/*/memory/` dirs, auto-memory is disabled, so these are
  leftover cruft; flag all for removal.

## 2. Classify
Via `git ls-files` / `check-ignore`:
- ALWAYS KEEP, never a candidate regardless of git status: the home-level global config
  `~/.claude/settings.local.json`, `~/.claude/settings.json`, and `~/.claude/CLAUDE.local.md`.
  These are deliberate machine-local config, not project cruft. Only these filenames found
  inside a project root are candidates; the sole thing swept under `~/.claude` itself is the
  `projects/*/memory/` auto-memory cruft.
- TRACKED in git → NEVER touch (keep, team-owned).
- UNTRACKED/gitignored personal cruft, and any auto-memory dir → candidate for removal.

## 3. Report
Print a table: path | classification | recommendation | why.

## 4. Remove on my confirm
On my explicit confirm, remove ONLY the confirmed cruft; report what was removed. Never delete
anything tracked, or anything you can't classify with confidence, surface those instead.
