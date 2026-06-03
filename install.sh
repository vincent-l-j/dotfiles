#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
VSCODE="$HOME/Library/Application Support/Code/User"

# Back up an existing file/symlink to <path>.bak, then symlink it to the source.
backup_and_link() {
  local src="$1" dest="$2"
  if [ "$(readlink "$dest")" = "$src" ]; then
    echo "Already linked: $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak"
    echo "Backed up: $dest -> $dest.bak"
  fi
  ln -sf "$src" "$dest"
}

FILES=(
  ".gitconfig"
  ".gitignore_global"
  ".vimrc"
)

for f in "${FILES[@]}"; do
  backup_and_link "$DOTFILES/$f" "$HOME/$f"
done

backup_and_link "$DOTFILES/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
backup_and_link "$DOTFILES/vscode/settings.json" "$VSCODE/settings.json"

echo "Done."
