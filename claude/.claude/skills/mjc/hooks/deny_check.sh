#!/usr/bin/env bash
# Claude Code PreToolUse hook — blocks dangerous commands before execution.
# Exit 0 = allow, exit 2 = block (with stderr message shown to user).

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty' 2>/dev/null)

# Only inspect Bash tool invocations
if [ "$tool_name" != "Bash" ]; then
  exit 0
fi

command=$(echo "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)

# --- Destructive filesystem commands ---

if [[ "$command" =~ rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*f ]] || \
   [[ "$command" =~ rm[[:space:]]+-[a-zA-Z]*f[a-zA-Z]*r ]]; then
  # Block rm with both -r and -f flags (rm -rf, rm -fr, rm -rfi, etc.)
  echo "BLOCKED: recursive force delete (rm -rf). Use explicit paths with 'rm -r' instead." >&2
  exit 2
fi

if [[ "$command" == "shutdown"* ]] || [[ "$command" == "reboot"* ]]; then
  echo "BLOCKED: system shutdown/reboot command." >&2
  exit 2
fi

# --- Destructive git commands ---

if [[ "$command" =~ git[[:space:]]+push[[:space:]]+.*--force ]] || \
   [[ "$command" =~ git[[:space:]]+push[[:space:]]+-f[[:space:]] ]]; then
  # Allow --force-with-lease (the safe alternative)
  if [[ ! "$command" =~ --force-with-lease ]]; then
    echo "BLOCKED: force push. Use --force-with-lease if you must." >&2
    exit 2
  fi
fi

if [[ "$command" =~ git[[:space:]]+reset[[:space:]]+--hard ]]; then
  echo "BLOCKED: git reset --hard. Use 'git stash' or 'git reset --soft' to preserve changes." >&2
  exit 2
fi

if [[ "$command" =~ git[[:space:]]+clean[[:space:]]+-[a-zA-Z]*f[a-zA-Z]*d ]] || \
   [[ "$command" =~ git[[:space:]]+clean[[:space:]]+-[a-zA-Z]*d[a-zA-Z]*f ]]; then
  echo "BLOCKED: git clean -fd. This permanently deletes untracked files and directories." >&2
  exit 2
fi

# --- Dangerous kubectl/helm commands ---

if [[ "$command" =~ kubectl[[:space:]]+delete[[:space:]]+namespace ]]; then
  echo "BLOCKED: deleting a Kubernetes namespace. This destroys all resources in the namespace." >&2
  exit 2
fi

if [[ "$command" =~ kubectl[[:space:]]+delete[[:space:]]+.*--all[[:space:]] ]] || \
   [[ "$command" =~ kubectl[[:space:]]+delete[[:space:]]+.*--all$ ]]; then
  echo "BLOCKED: kubectl delete --all. Too broad — specify individual resources." >&2
  exit 2
fi

# --- Package installation (global/system-wide) ---

if [[ "$command" =~ pip[3]?[[:space:]]+install[[:space:]] ]] && \
   [[ ! "$command" =~ pip[3]?[[:space:]]+install[[:space:]]+-e ]] && \
   [[ ! "$command" =~ pip[3]?[[:space:]]+install[[:space:]]+-r ]]; then
  echo "BLOCKED: bare pip install. Use a virtual environment or 'pip install -e .' / 'pip install -r requirements.txt'." >&2
  exit 2
fi

if [[ "$command" =~ npm[[:space:]]+install[[:space:]]+-g ]] || \
   [[ "$command" =~ npm[[:space:]]+install[[:space:]]+--global ]]; then
  echo "BLOCKED: global npm install. Install locally with 'npm install' or use npx." >&2
  exit 2
fi

# --- Credential / secret exfiltration ---

if [[ "$command" =~ curl.*(-d|--data).*(_TOKEN|_KEY|_SECRET|PASSWORD) ]]; then
  echo "BLOCKED: potential credential exfiltration via curl. Review the command manually." >&2
  exit 2
fi

# Allow everything else
exit 0
