---
name: park
description: Quick WIP "parking" commit of all current changes. Use when I say "park", "park this", or "park it".
disable-model-invocation: true
---

One-shot WIP commit. `touch "$HOME/.claude/.mjc-commit-ok"` in its own Bash call (never chained
into the commit — the hook checks the sentinel before a chained command runs), then
`git add -A && git commit -m "chore: parking"`, then push:
`git push origin "$(git rev-parse --abbrev-ref HEAD)"`. Print the short hash on ONE line,
nothing else. No proposals, no questions, no reviewers/tests.
