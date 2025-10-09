DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.config"
ln -sfi "$DOTFILES/nvim"              "$HOME/.config/nvim"
ln -sfi "$DOTFILES/tmux/.tmux.conf"   "$HOME/.tmux.conf"
ln -sfi "$DOTFILES/git/.gitconfig"    "$HOME/.gitconfig"
ln -sfi "$DOTFILES/zsh/.zshrc"        "$HOME/.zshrc"

echo "✅ Dotfiles linked successfully from: $DOTFILES"
