#!/usr/bin/env sh
set -eu
cwd=${HERDR_ACTIVE_PANE_CWD:-$PWD}
label=${cwd##*/}
created=$(herdr workspace create --cwd "$cwd" --label "$label" --focus)
ws=$(printf '%s' "$created" | jq -r '.result.workspace.workspace_id')
root_tab=$(printf '%s' "$created" | jq -r '.result.tab.tab_id')
herdr tab rename "$root_tab" 1-zsh
nvim_pane=$(herdr tab create --workspace "$ws" --cwd "$cwd" --label 2-nvim | jq -r '.result.root_pane.pane_id')
herdr pane run "$nvim_pane" "nvim"
agent_pane=$(herdr tab create --workspace "$ws" --cwd "$cwd" --label 3-agent | jq -r '.result.root_pane.pane_id')
herdr pane run "$agent_pane" claude
