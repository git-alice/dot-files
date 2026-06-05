# Terminal Dotfiles

Fast terminal setup for macOS.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/git-alice/dot-files/main/install.sh | zsh
```

Installs missing Homebrew packages, clones the repo into `~/.config/zsh-dotfiles`, and adds managed blocks to `~/.zshrc` and `~/.tmux.conf`.

## Main Points

- `@ii`: terminal LLM helper powered by the `llm` CLI.

```sh
@ii command to generate a secure password
cat error.log | @ii explain this error
```

Configure `llm` separately:

```sh
llm keys set openai
```

- `tmux`: prefix is remapped from `Ctrl-b` to backtick.

```text
` then key
```

## Update

Rerun the install command.

## Used

[Zsh](https://www.zsh.org/) / [Zinit](https://github.com/zdharma-continuum/zinit) / [Starship](https://starship.rs/) / [tmux](https://github.com/tmux/tmux) / [llm](https://llm.datasette.io/) / [fzf](https://github.com/junegunn/fzf) / [fd](https://github.com/sharkdp/fd) / [ripgrep](https://github.com/BurntSushi/ripgrep) / [eza](https://github.com/eza-community/eza) / [bat](https://github.com/sharkdp/bat) / [zoxide](https://github.com/ajeetdsouza/zoxide)
