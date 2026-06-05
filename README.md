# dotfiles

Personal dotfiles for macOS and Linux (including devcontainers).

## Setup

Clone this repo to `~/dotfiles` and run the install script:

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script:

- Symlinks `.gitconfig`, `.gitignore_global`, `.vimrc`, and `.config/starship.toml` into `$HOME`
- Appends `source ~/dotfiles/.aliases.zsh` to `~/.zshrc` (zsh) or `~/.bashrc` (bash), if not already present
- Symlinks `vscode/settings.json` to the VS Code user settings directory (skipped if VS Code isn't installed)

Existing files are backed up with a `.bak` suffix before being replaced.

## macOS extras

1. Install [Starship](https://starship.rs/guide/#step-1-install-starship) and add `eval "$(starship init zsh)"` to your `~/.zshrc`
2. Install the [Nerd Font](https://www.nerdfonts.com/) used in `terminal.integrated.fontFamily` in VS Code (see [vscode/settings.json](vscode/settings.json)).
3. Add a Finder shortcut to open folders in VS Code: [instructions](https://stackoverflow.com/questions/64040393/how-to-open-a-folder-in-vs-code-from-finder-on-macos)
