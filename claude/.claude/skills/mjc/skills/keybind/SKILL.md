---
name: keybind
description: Find where a keybind lives across my dotfiles (nvim, karabiner, aerospace, ghostty, zsh) from a plain-English description. Use when I say "keybind for X", "what's the bind for X", or ask what a specific key combo does.
disable-model-invocation: true
---

Find a keybind, or what a specific combo does, from $ARGUMENTS: a plain-English description of what
I'm trying to do or what I already know about it (app, rough key, context).

READ-ONLY. Locate and report; never edit a config file.

Read `~/.claude/mjc.config.local.json` first for `dirs.repos`, the dotfiles repo is at `<dirs.repos>/dotfiles`.

## 1. Search
Grep/search the whole dotfiles repo for whatever $ARGUMENTS points at. Don't assume which tool
(nvim, karabiner, aerospace, ghostty, zsh, ...) owns it ahead of time, let the search tell you.

## 2. Report
For each match: the tool, what it does, and `file:line`. Show the combo exactly as the config writes
it (e.g. `<C-h>`, `alt-shift-h`), then explain it in plain English (which keys, held vs tapped, in what
order), never just the raw notation on its own.

## 3. Multiple or no matches
More than one plausible match across tools → list all of them, don't guess which one I meant.
Nothing matches → say so plainly, don't invent a bind that isn't there.
