---
name: pr
description: Commit, push, open a PR, and (if a tracker's configured) link and advance the ticket. Use when I say "make a PR", "open a PR", or "PR this".
disable-model-invocation: true
---

## Branch
!`git rev-parse --abbrev-ref HEAD 2>/dev/null || echo NOT-A-REPO`

## Status
!`git status --short 2>/dev/null || true`

Read `~/.claude/mjc.config.local.json` first for `commit` and `tracker`. The tracker step runs only when
`tracker.type` isn't `none` and the branch carries a key (`[A-Za-z]+-[0-9]+`); otherwise skip it.

If Branch is NOT-A-REPO, ask which repo, then use `git -C <repo>` and `gh -R <owner>/<repo>`. If it's
the trunk or not a `feat-`/`fix-` branch, make one per `rules/git.md` carrying the current changes
before committing; unrelated or unpushed work on the tree → stop and ask.

## 1. Commit
Author the subject per `rules/git.md`. Present 3 candidates via AskUserQuestion, each `label` the
ENTIRE message and `description` empty, plus a 4th "None, propose 3 more". On pick,
`touch "$HOME/.claude/.mjc-commit-ok"` in its own Bash call, then `git commit -m "<chosen>"` in a
separate one — never chained, the hook checks the sentinel before a chained command runs.
Re-touch (separately) to retry a rejected commit. Nothing staged → ask what to stage.

## 2. Push
`git push origin "$(git branch --show-current)"` (never bare push).

## 3. Open the PR
`gh pr create`, title = the commit subject, body = the template below. Summary is 1–2 sentences.
Fill Testing only if the diff added unit tests; else leave it for me. Print the PR URL.

## 4. Tracker (jira)
Only when `tracker.type` is `jira` and the branch has a key. Extract the key (`[A-Za-z]+-[0-9]+`) from
the branch.
- Comment the PR link on the ticket via Atlassian MCP `addCommentToJiraIssue` (cloudId from
  `tracker.url`), `contentFormat: markdown`, body `PR: [<title>](<url>)`.
- Transition only if `tracker.statuses.pr` is set: `getTransitionsForJiraIssue`, pick the one whose
  target status matches it (case-insensitive), apply with `transitionJiraIssue`. No match from the
  current status → note it and skip.
- Atlassian MCP unavailable → say so and skip.
A second tracker later is a parallel `## 4. Tracker (linear)` block; nothing else changes.

Body template:

    <summary, 1–2 sentences: the problem and the fix>

    #### Ticket
    [<KEY>](<tracker.url>/browse/<KEY>)

    #### Testing

The Ticket section appears only when a tracker's set and the branch has a key. Otherwise the body is
summary + `#### Testing`, nothing else. No per-file breakdown, no extra headers.
