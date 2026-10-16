#!/usr/bin/env bash
set -euo pipefail

DOTFILES_PATH="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"

echo
echo "🔧 Installing dotfiles from: $DOTFILES_PATH"
echo

# Helper function
step() {
  printf "  ▸ %s... " "$1"
}

ok() {
  echo "✓"
}

skip() {
  echo "↷ (already ${1:-configured})"
}

# --- Dependencies ---
require_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required to install missing dependencies: https://brew.sh" >&2
    exit 1
  fi
}

ensure_command() {
  local command_name="$1"
  local formula="$2"

  step "Installing $command_name"
  if command -v "$command_name" >/dev/null 2>&1; then
    skip installed
    return
  fi

  echo
  require_brew
  brew install "$formula"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "$command_name is still unavailable after installing $formula" >&2
    exit 1
  fi
  ok
}

ensure_command git git
ensure_command tree tree
ensure_command tmux tmux
ensure_command emacs emacs
ensure_command oh-my-posh jandedobbeleer/oh-my-posh/oh-my-posh
ensure_command npm node
ensure_command npx node

step "Installing branch-safe-name"
if command -v branch-safe-name >/dev/null 2>&1; then
  skip installed
else
  echo
  npm install --global branch-safe-name
  if ! command -v branch-safe-name >/dev/null 2>&1; then
    echo "branch-safe-name is still unavailable after npm installation" >&2
    exit 1
  fi
  ok
fi

step "Installing Fira Code Nerd Font"
require_brew
if brew list --cask font-fira-code-nerd-font >/dev/null 2>&1; then
  skip installed
else
  echo
  brew install --cask font-fira-code-nerd-font
  ok
fi

# --- Git ---
step "Configuring git include"
if ! git config --global --get-all include.path | grep -Fxq "$DOTFILES_PATH/.gitconfig"; then
  git config --global --add include.path "$DOTFILES_PATH/.gitconfig"
  ok
else
  skip
fi

# --- Zsh ---
ZSH_LINE="source \"$DOTFILES_PATH/.zshrc\""
step "Configuring zsh"
if ! grep -Fqx "$ZSH_LINE" "$HOME/.zshrc" 2>/dev/null; then
  printf '\n# Dotfiles\n%s\n' "$ZSH_LINE" >> "$HOME/.zshrc"
  ok
else
  skip
fi

# --- Oh My Posh ---
printf -v POSH_LINE 'eval "$(oh-my-posh init zsh --config "%s")"' "$DOTFILES_PATH/theme.omp.json"
step "Configuring Oh My Posh"
if ! grep -Fqx "$POSH_LINE" "$HOME/.zshrc" 2>/dev/null; then
  printf '%s\n' "$POSH_LINE" >> "$HOME/.zshrc"
  ok
else
  skip
fi

# --- Tmux ---
TMUX_LINE="source-file \"$DOTFILES_PATH/.tmux.conf\""
step "Configuring tmux"
if ! grep -Fqx "$TMUX_LINE" "$HOME/.tmux.conf" 2>/dev/null; then
  printf '\n%s\n' "$TMUX_LINE" >> "$HOME/.tmux.conf"
  ok
else
  skip
fi

# --- Emacs ---
EMACS_LINE="(load \"~/dotfiles/.emacs\")"
step "Configuring emacs"
if ! grep -Fqx "$EMACS_LINE" "$HOME/.emacs" 2>/dev/null; then
    printf '\n%s\n' "$EMACS_LINE" >> "$HOME/.emacs"
    ok
else
    skip
fi

echo
echo "✨ Dotfiles installation complete."
echo
