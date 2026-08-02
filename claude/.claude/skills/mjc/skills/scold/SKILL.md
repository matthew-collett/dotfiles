---
name: scold
description: I'm calling out a rule you just broke. Identify which instruction you violated and fix it, or ask if you can't tell. Use when I say "scold", "bad", "you broke a rule", or call out a mistake.
disable-model-invocation: true
---

$ARGUMENTS is my complaint, often empty ("you know what you did").

## 1. Find the violation
Check what you just did/said against my instructions, CLAUDE.md, `rules/*.md`, and the active
skill. Name the exact rule and quote it. If $ARGUMENTS points at it, start there.

## 2. If you can't tell, ask
Not sure what you did wrong? ASK. Don't invent a violation to look responsive, and don't guess.

## 3. Fix this instance
If the violation and its fix are both clear, fix it now, undo/redo it correctly, nothing more. If
the right fix is ambiguous, propose it and wait.

## 4. Keep it terse
Name the rule, fix it, done. No groveling. This fixes the one instance; if it keeps happening, the
fix belongs at the framework level (change the rule), a separate, deliberate pass.
