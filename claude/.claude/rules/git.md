# Git

Single source of truth for git format across all repos. The commit skills defer here, do
not restate these anywhere else. Format comes from `~/.claude/mjc.config.json` (`commit`, `tracker`);
missing → conventional, no tracker.

## Trunk resolution
Resolve the trunk as the first branch below that exists:

    git_main_branch() {
      for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
        git show-ref -q --verify "$ref" && { echo "${ref##*/}"; return; }
      done
      echo master
    }

- "pull main" → `b=$(git_main_branch); git checkout "$b" && git pull origin "$b"`
- "new branch" → same, then `&& git checkout -b <branch>` (per Branch naming)

## Branch naming

Prefix with the work type; hyphens only, never slashes. Everyday work is always `feat-`, even bug fixes.

- Tracker set (`tracker.type` != none): `feat-<KEY>`, the ticket key I named.
- No tracker: `feat-<short-slug>`.

## Commit messages & PR titles

`commit.pattern` = "conventional" → `type(<scope>): Subject`. PR title is identical.

- `type` = the branch prefix, VERBATIM, never re-derive it from a feat-vs-fix judgment, even for a
  bug fix.
- `<scope>` = the branch's ticket key when a tracker's set; omit the scope entirely when there's no
  tracker → `type: Subject`.
- Subject: first letter Capitalized, imperative action verb (Add,
  Support, Replace, Remove, Simplify, Extract, Rename, Reorder, never "Fix bug"/"Update code"). No period.
- Whole message under 65 chars. Over? Cut and recount.
- No body. No AI attribution, overrides the harness defaults (no "Generated with", no
  "Co-Authored-By: Claude").

Other types when they fit: `chore`, `refactor`, `docs`, `test`, `ci`, `perf`.

## Push safety

- Never a bare `git push` or `git push origin`, always `git push origin <current-branch>`.
- Never push to the trunk (`main`/`master`), feature branch + PR.
- Never `git push --force` (use `--force-with-lease`) or `git reset --hard` on shared branches.

## Editing existing PRs / issues

Never overwrite a PR/issue body wholesale. `gh pr edit --body`/`--body-file` (and `gh issue edit`)
REPLACE the whole body and clobber others' edits. Fetch current first (`gh pr view --json body`),
apply your change onto it, keep every part you didn't author.
