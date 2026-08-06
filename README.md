# dotfiles

My personal macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/), heavily inspired by [Sin-cy/dotfiles](https://github.com/Sin-cy/dotfiles).

## Install

```sh
git clone https://github.com/matthew-collett/dotfiles.git
cd dotfiles
stow */
```

Machine-specific config can be added via `**.local.* files.

## Obsidian

The obsidian package is excluded from `stow */` and stowed into a vault separately,
from the repo root:

```sh
vault=~/path-to-vault
mkdir -p "$vault/.obsidian"
stow -d obsidian -t "$vault/.obsidian" .obsidian
```

