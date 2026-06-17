#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
OS=$(uname -s)
SHELL_NAME=$(basename "$SHELL")

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
  echo "Linked: $dest"
}

FILES=(
  ".gitconfig"
  ".gitignore_global"
  ".vimrc"
  ".config/starship.toml"
)

for f in "${FILES[@]}"; do
  backup_and_link "$DOTFILES/$f" "$HOME/$f"
done

# VS Code settings — path differs by OS, skip if not installed
case "$OS" in
  Darwin) VSCODE="$HOME/Library/Application Support/Code/User" ;;
  Linux)  VSCODE="$HOME/.config/Code/User" ;;
esac
if [ -n "$VSCODE" ] && [ -d "$(dirname "$VSCODE")" ]; then
  backup_and_link "$DOTFILES/vscode/settings.json" "$VSCODE/settings.json"
fi

# Append a source line to the shell config — idempotent
SOURCE_LINE="source \"$DOTFILES/.aliases.zsh\""
case "$SHELL_NAME" in
  zsh)  SHELL_RC="$HOME/.zshrc" ;;
  bash) SHELL_RC="$HOME/.bashrc" ;;
  *)    SHELL_RC="" ;;
esac

if [ -n "$SHELL_RC" ] && ! grep -qE '^\s*source\s+.*\.aliases\.zsh' "$SHELL_RC" 2>/dev/null; then
  echo "" >> "$SHELL_RC"
  echo "# dotfiles" >> "$SHELL_RC"
  echo "$SOURCE_LINE" >> "$SHELL_RC"
  echo "Added to $SHELL_RC"
elif [ -n "$SHELL_RC" ]; then
  echo "Already sourced in $SHELL_RC"
fi

echo "Done."
