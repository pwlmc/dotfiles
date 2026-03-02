DOTFILES_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
git config --global --add include.path "$DOTFILES_PATH/.gitconfig"
echo "\n# Dotfiles env\nsource $DOTFILES_PATH/.zshrc\n" >> "$HOME/.zshrc"
