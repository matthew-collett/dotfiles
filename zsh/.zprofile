# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# environment & path
typeset -U PATH
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/scripts"

# mason
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# editors
export EDITOR=nvim
export VISUAL=nvim

# better man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# machine-specific overrides
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"

