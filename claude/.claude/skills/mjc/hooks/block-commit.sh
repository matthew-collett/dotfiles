#!/usr/bin/env bash
# mjc: block `git commit` in Bash. Commits happen ONLY inside the commit skills (which the
# user invokes), which drop the one-shot sentinel below right before committing. Any other
# `git commit` — an ad-hoc/reflexive one — is refused.

input=$(cat)
[ "$(echo "$input" | jq -r '.tool_name // empty' 2>/dev/null)" = "Bash" ] || exit 0
command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Match `git commit` / `git -C <dir> commit` as a command word (also after ; && || | &).
re='(^|[;&|])[[:space:]]*git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+commit([[:space:]]|$)'
[[ "$command" =~ $re ]] || exit 0

sentinel="$HOME/.claude/.mjc-commit-ok"
if [ -f "$sentinel" ]; then
  rm -f "$sentinel"
  exit 0
fi
echo "BLOCKED: don't run 'git commit' yourself. Commits go only through the commit skills the user invokes." >&2
exit 2
