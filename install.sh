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
  echo "↷ (already configured)"
}

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

# --- Tmux ---
TMUX_LINE="source-file \"$DOTFILES_PATH/.tmux.conf\""
step "Configuring tmux"
if ! grep -Fqx "$TMUX_LINE" "$HOME/.tmux.conf" 2>/dev/null; then
  printf '\n%s\n' "$TMUX_LINE" >> "$HOME/.tmux.conf"
  ok
else
  skip
fi

echo
echo "✨ Dotfiles installation complete."
echo
