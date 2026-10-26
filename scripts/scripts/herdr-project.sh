#!/usr/bin/env bash
set -eu
cwd=${HERDR_ACTIVE_PANE_CWD:-$PWD}
default_label=${cwd##*/}
label=""
while IFS= read -r -s -n 1 char; do
  if [ -z "$char" ]; then
    break
  fi
  case "$char" in
    $'\x1b') exit 1 ;;
    $'\x7f'|$'\x08')
      if [ -n "$label" ]; then
        label=${label%?}
        printf '\b \b'
      fi
      ;;
    *)
      label="$label$char"
      printf '%s' "$char"
      ;;
  esac
done
label=${label:-$default_label}
created=$(herdr workspace create --cwd "$cwd" --label "$label" --focus)
ws=$(printf '%s' "$created" | jq -r '.result.workspace.workspace_id')
root_tab=$(printf '%s' "$created" | jq -r '.result.tab.tab_id')
herdr tab rename "$root_tab" 1-zsh
agent_pane=$(herdr tab create --workspace "$ws" --cwd "$cwd" --label 2-agent | jq -r '.result.root_pane.pane_id')
printf -v agent_cmd 'claude --name %q' "$label"
herdr pane run "$agent_pane" "$agent_cmd"
