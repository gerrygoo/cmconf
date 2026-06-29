# git.sh — git aliases and helpers

alias gs='git status'
alias gpp='git pull --prune'
alias gyolopush='git commit -a --amend --no-edit && git push -f'

# PR
alias ghprcd='gh pr create --draft --title'
alias ghprw='gh pr checks --watch'

# Interactive staging with fzf
alias gai="git status --porcelain | fzf -m --preview 'git diff --color=always {+2}' --preview-window=right:60% | awk '{print \$2}' | xargs git add"
