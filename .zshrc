# Set locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Disable visual bell on completion
unsetopt LIST_BEEP

# Enable mouse support in less by default.
# -R option to keep ANSI colors
export LESS='--mouse -R'

# Upgrade terminal colors
if [[ "$TERM" == "xterm" ]]; then
  export TERM="xterm-256color"
fi
export COLORTERM="truecolor"

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
dsh() {
  docker exec -it "$1" zsh
}

# Devcontainers
alias dev='devcontainer'
alias devup='devcontainer up --workspace-folder .'
devx() { devcontainer exec "$@"; }

portinfo() {
  local port="$1"
  local pid

  pid=$(lsof -nP -iTCP:"$port" -sTCP:LISTEN -t | head -n1)

  if [[ -z "$pid" ]]; then
    echo "Port $port is free"
    return 0
  fi

  echo "Port: $port"
  echo "PID:  $pid"
  echo "CMD:  $(ps -p "$pid" -o comm= | xargs)"
  echo "DIR:  $(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')"
}
