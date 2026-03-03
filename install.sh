DOTFILES_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Git
git config --global --add include.path "$DOTFILES_PATH/.gitconfig"

# Zsh
echo "\n# Dotfiles\nsource $DOTFILES_PATH/.zshrc\n" >> "$HOME/.zshrc"

# Tmux
echo "\nsource-file $DOTFILES_PATH/.tmux.conf\n" >> "$HOME/.tmux.conf"
