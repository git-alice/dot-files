# Terminal Dotfiles

Personal terminal dotfiles with Zsh configuration, Zinit plugins, shared history, fzf search, native completions, guarded shell companion integrations, a Starship prompt, and tmux prefix settings.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/git-alice/dot-files/main/install.sh | zsh
```

The bootstrap clones this repository into `~/.config/zsh-dotfiles`, installs missing macOS dependencies with Homebrew, backs up `~/.zshrc` and `~/.tmux.conf`, and adds managed source blocks that load `zsh/init.zsh` and `tmux/tmux.conf`.

## Update

Rerun the install command. The bootstrap updates the managed repository and refreshes only its marked blocks in `~/.zshrc` and `~/.tmux.conf`. If local changes exist in `~/.config/zsh-dotfiles`, it stops before pulling.

## Local Development

```sh
for file in install.sh zsh/*.zsh; do zsh -n "$file"; done
tmux -f /dev/null source-file tmux/tmux.conf
```

To load the modules without fetching plugins:

```sh
ZSH_DOTFILES_DISABLE_PLUGINS=1 zsh -dfc 'source zsh/init.zsh'
```
