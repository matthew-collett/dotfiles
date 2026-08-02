#!/usr/bin/env bash
# mjc: block `cd` in Bash — it mutates the shared working directory and trips the permission
# guard. Pass the target dir as the command's path argument, or use `git -C` / `make -C`.

input=$(cat)
[ "$(echo "$input" | jq -r '.tool_name // empty' 2>/dev/null)" = "Bash" ] || exit 0
command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Match `cd` only as a command word: at the start, or after ; && || | & or a newline.
# Won't match substrings like `git show abcd`, `mycd`, or `echo "cd x"`.
re='(^|[;&|])[[:space:]]*cd([[:space:]]|$)'
if [[ "$command" =~ $re ]]; then
  echo "BLOCKED: no 'cd' in Bash — it mutates the shared working directory. Pass the target dir as the command's path argument (e.g. 'rg PATTERN <dir>', 'ls <dir>', 'find <dir>') or use 'git -C <dir>' / 'make -C <dir>'." >&2
  exit 2
fi
exit 0
