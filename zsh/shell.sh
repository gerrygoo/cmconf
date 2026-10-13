# shell.sh — shell framework, prompt, navigation
# Each tool is optional: a fresh machine without them gets a plain shell, not errors.

export ZSH="$HOME/.oh-my-zsh"
plugins=(git fzf)
[[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

alias so='source ~/.zshrc'

# chezmoi shortcuts
alias dots='chezmoi status'
alias dotd='chezmoi diff'
alias dota='chezmoi apply -v'
alias dote='chezmoi edit'
alias dotra='chezmoi re-add'
