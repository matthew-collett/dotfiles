# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  # zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# completions
source <(sp completion zsh)

# vi mode
bindkey -v

# ctrl-p / ctrl-n cycle history
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search

# atuin
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' atuin-search-viins

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"
source ~/scripts/fzf-git.sh

# starship prompt
eval "$(starship init zsh)"

# next level ls
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"

# lstr
alias lstr="lstr --icons"

# misc
alias c="clear"
alias e="exit"
alias vim="nvim"

# machine-specific overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
