# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  kubectl
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
export STARSHIP_CONFIG="$HOME/.config/starship.generated.toml"
if [[ ! -e $STARSHIP_CONFIG ]] \
  || [[ $HOME/.config/starship.toml -nt $STARSHIP_CONFIG ]] \
  || [[ $HOME/.config/starship.local.toml -nt $STARSHIP_CONFIG ]]; then
  cat $HOME/.config/starship.toml $HOME/.config/starship.local.toml(N) > $STARSHIP_CONFIG
fi
eval "$(starship init zsh)"

# next level ls
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"

# lstr
alias lstr="lstr --icons"

# misc
alias c="clear"
alias e="exit"
alias vim="nvim"

# functions
awsp() {
  local p=${1:-$(aws configure list-profiles | fzf --height=40% --reverse)}
  [[ -n $p ]] || return
  export AWS_PROFILE=$p
  aws sso login --profile "$p"
}
klfd() { kubectl logs -f "deployments/$1" "${@:2}"; }
stern() {
  if [[ $# -eq 1 ]]; then
    command stern "$1" -c "$1"
  else
    command stern "$@"
  fi
}
ctx() { starship module kubernetes; starship module aws; starship module azure; starship module gcloud; echo }

# machine-specific overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
