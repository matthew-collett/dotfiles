---
name: plan
description: Write an implementation plan. Use when I say "plan this", "make a plan", or similar.
disable-model-invocation: true
---

Read `~/.claude/mjc.config.local.json` first for `dirs.plans` and `tracker`. Missing → stop, say
it doesn't exist, ask me to create it. State the plans dir you resolved before writing.

Write the plan to `<dirs.plans>/<repo>/<date>-<name>.md`, lowercase kebab except the ticket key,
which stays exactly as I gave it:
- `<repo>`: the repo the work targets, infer from what I'm planning; ask if ambiguous.
- `<date>`: today (`date +%F`).
- `<name>`: the ticket key verbatim + a short kebab slug when a tracker's set, else just a short slug.
  I name the ticket; if a tracker's set and I didn't give a key, ask for it.

Cross-repo work: one plan per repo, each under its own `<dirs.plans>/<repo>/`, never one combined
file. Each opens with a one-line `Scope:` note cross-referencing the sibling plans. Split clearly
separable pieces of work into their own plans too.

If the file already exists, append `-2`/`-3`, never clobber a past plan. Print the full path(s)
when done. Touch only the plan file(s) for this request.

## Skeleton, every plan follows this
    # <title>
    ## Open questions   (your @ai questions for me; "none" when empty)
    ## Approach         (2–4 decisions, each one line + its tradeoff)
    ## New files        (full path + complete contents)
    ## Changed files    (changed fn = full-function diff; new = complete block)
    ## Tests            (what to test + how)
    ## Sequencing       (ordered implement steps)

## Content rules
- New file or new function → full path + complete contents in a language-fenced block (```go,
  ```ts), no diff. Changed function → the ENTIRE function as one ```diff block: every line shown,
  only changed lines prefixed +/-. Never ellipsis.
- The plan holds only final decisions and the code, not your thought process. Reason and read the
  code first; don't explain what you considered or ruled out. Output, not narrative.
- One line + tradeoff per decision. Minimal markdown, no bold/italic, no nested bullets, no headers
  beyond the skeleton. Plain lines + fenced code.
- Never hard-wrap prose. One line per paragraph. Fenced and indented blocks keep their line breaks.

## Markers (async notes in the plan; both block implementation)
- `@me <note>` = my note to you; you resolve it. Decide, apply it to the plan, delete the line, and
  say what you did in chat. If you can't call it, leave it and ask me.
- `@ai <note>` = your note to me; I resolve it, never you. Surface it and wait; list open ones under
  Open questions. Once I answer (in chat or by editing the line), fold it in and delete it.
- Markers sit at line start; separate consecutive ones with a blank line so each renders on its own.

## Rules
- Plan only. Do NOT write, edit, or run real code until I explicitly approve. "Looks good"/"ok" is
  NOT approval, ask.
- Never implement while any `@me` or `@ai` marker remains.
