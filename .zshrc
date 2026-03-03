# Disable visual bell on completion
unsetopt LIST_BEEP

# Enable mouse support in less by default.
# -R option to keep ANSI colors
export LESS='--mouse -R'

# Editor
export EDITOR='micro'

# Aliases
alias du='du -h'
alias d='du -d 0 *'
alias df='df -h'
alias t='tree --dirsfirst --noreport -L 1'
alias tt='t -L 2'
alias ttt='t -L 3'

# Docker
alias dps='docker ps'
alias dsh='docker exec -it'
