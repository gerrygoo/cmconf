# shell.sh — shell framework, prompt, navigation

export ZSH="$HOME/.oh-my-zsh"
plugins=(git fzf)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias so='source ~/.zshrc'

# chezmoi shortcuts
alias dots='chezmoi status'
alias dotd='chezmoi diff'
alias dota='chezmoi apply -v'
alias dote='chezmoi edit'
alias dotra='chezmoi re-add'
