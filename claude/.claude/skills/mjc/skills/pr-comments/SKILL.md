---
name: pr-comments
description: Triage a PR's review threads, fix what's in scope, then reply and resolve. Use when I say "address comments", "handle the PR comments", "address review", or similar.
disable-model-invocation: true
---

Work a PR's review threads. This touches shared code and a shared PR: I approve every code fix (one
at a time), and nothing commits, pushes, or posts to GitHub until I say the fixes are all good.

## 1. Find the PR
`gh pr view --json number,url` and `gh repo view --json owner,name`. If either errors (not a repo, or
no PR for this branch), ask me the repo + PR number and pass `-R <owner>/<repo>` on every `gh` call
below.

## 2. Fetch unresolved threads
GraphQL, because resolving later needs the thread node IDs:
```
gh api graphql -f query='
  query($owner:String!,$repo:String!,$pr:Int!){
    repository(owner:$owner,name:$repo){ pullRequest(number:$pr){
      reviewThreads(first:100){ nodes{
        id isResolved
        comments(first:50){ nodes{ databaseId author{login} body path line } } } } } } }' \
  -F owner=<owner> -F repo=<repo> -F pr=<number>
```
Consider only threads where `isResolved` is false.

## 3. Triage, change nothing yet
Judge each unresolved thread yourself; the reviewer's confidence is an input, not a verdict. Fill
these for each thread, you can't reach a verdict without them:
- claim, the concern, one line.
- checked, what in the code confirms or refutes it (a concrete line/symbol, not "looks fine").
- scope, in / out, tied to what this PR's diff actually touches.
- verdict, `fix` (real AND in scope; only this touches code) / `defer` (may be right but out of
  scope: pre-existing, unrelated, scope-creep) / `push back` (wrong, already handled, or a subjective
  preference I don't share).
One row per thread. Don't mark `fix` unless `checked` shows it's real and `scope` is in. Surface
every thread, never resolve one silently, but I decide.

## 4. Fix the `fix` bucket, on my approval, one at a time
For each I confirm: describe the change in plain terms first, then apply it. One change at a time,
stop between, don't batch. Only touch what a thread flagged.

## 5. One gate, "all good?"
Draft every addressed thread's reply (fixed → `Fixed in <hash>`, hash filled after the commit;
defer/push back → a short, polite explanation). Show me the fixes made + all draft replies, and ask
if it's all good. Nothing below runs until I say yes, "looks good"/"ok" is not yes, so ask.

## 6. On yes, commit, reply, resolve, no more prompts
1. WIP commit: `git add -A && git commit -m "chore: parking"`, then
   `git push origin "$(git rev-parse --abbrev-ref HEAD)"`; grab `git rev-parse --short HEAD`.
2. For each addressed thread, reply, then resolve:
   - `gh api --method POST repos/<owner>/<repo>/pulls/<pr>/comments/<top comment databaseId>/replies -f body='<text>'`
   - `gh api graphql -f query='mutation($id:ID!){ resolveReviewThread(input:{threadId:$id}){ thread{ isResolved } } }' -F id=<thread id>`
Don't touch un-flagged code or already-resolved threads.
