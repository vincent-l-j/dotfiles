#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
VSCODE="$HOME/Library/Application Support/Code/User"

FILES=(
  ".gitconfig"
  ".gitignore_global"
  ".zsh_aliases"
)

for f in "${FILES[@]}"; do
  [ -f "$HOME/$f" ] && mv "$HOME/$f" "$HOME/$f.bak"
  ln -sf "$DOTFILES/$f" "$HOME/$f"
done

[ -f "$VSCODE/settings.json" ] && mv "$VSCODE/settings.json" "$VSCODE/settings.json.bak"
ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE/settings.json"

echo "Done. Existing files backed up with .bak extension."
