---
name: heal
description: Update this MJC framework from a correction. Use when I say "heal this", "fix the framework so this doesn't happen again", or after I correct a recurring mistake.
disable-model-invocation: true
---

Turn a correction into a durable framework change. Input: $ARGUMENTS (what went wrong), else the
recent conversation.

## 1. Name the root behavior
State it in ONE line, the thing to prevent next time.

## 2. Pick the right layer
Do NOT default to piling prose into CLAUDE.md.
- Must-never-happen → a permission ask|deny rule or a PreToolUse hook (enforcement).
- Behavioral default, all languages → the personal block in CLAUDE.md.
- Language/tool-specific → `rules/<x>.md` (create with a `paths:` scope if absent).
- A skipped workflow step → the relevant skill.

## 3. Show the change
Give the exact change, name the layer, say why.

## 4. Apply on my OK
Apply only on my explicit OK. For settings.json/hook changes, show the diff first.

## 5. Tighten, don't duplicate
If this came up before, TIGHTEN the existing rule, don't add a second one.
