#!/bin/bash

# Define custom labels/icons for your workspaces
SPACE_ICONS=("T" "F" "N" "P" "M" "I" "1" "2" "3")
# background.color=0x44ffffff \

for i in "${!SPACE_ICONS[@]}"; do
    id="${SPACE_ICONS[i]}"
  space_item=(
    icon="$id"
    icon.padding_left=7
    icon.padding_right=7
    icon.y_offset=1
    label.drawing=off
    background.color=0xff939ab7
    background.corner_radius=6
    background.padding_left=3
    background.padding_right=3
    background.height=20
    icon.font="$FONT:Regular:14.0"
    drawing=on
    script="$CONFIG_DIR/plugins/aerospace.sh $id"
    click_script="$PLUGIN_DIR/close_popups.sh; aerospace workspace $id"
  )

  sketchybar --add item space.$id left \
             --set space.$id "${space_item[@]}" \
             --subscribe space.$id aerospace_workspace_change
done
