# Zsh Dotfiles

Personal Zsh-only dotfiles with Zinit plugins, shared history, fzf search, native completions, guarded shell companion integrations, and a Starship prompt.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/git-alice/dot-files/main/install.sh | zsh
```

The bootstrap clones this repository into `~/.config/zsh-dotfiles`, installs missing macOS dependencies with Homebrew, backs up `~/.zshrc`, and adds a managed source block that loads `zsh/init.zsh`.

## Update

Rerun the install command. The bootstrap updates the managed repository and refreshes only its marked block in `~/.zshrc`. If local changes exist in `~/.config/zsh-dotfiles`, it stops before pulling.

## Local Development

```sh
for file in install.sh zsh/*.zsh; do zsh -n "$file"; done
```

To load the modules without fetching plugins:

```sh
ZSH_DOTFILES_DISABLE_PLUGINS=1 zsh -dfc 'source zsh/init.zsh'
```
