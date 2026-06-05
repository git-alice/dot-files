# Terminal Dotfiles

Small macOS terminal setup for Zsh, tmux, Starship, shell companions, and quick LLM requests.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/git-alice/dot-files/main/install.sh | zsh
```

Installs missing Homebrew packages, clones the repo into `~/.config/zsh-dotfiles`, and adds managed blocks to `~/.zshrc` and `~/.tmux.conf`.

## Update

Rerun the install command.

## Main Points

- `@ii`: terminal LLM helper powered by the `llm` CLI.

```sh
@ii command to generate a secure password
cat error.log | @ii explain this error
```

- `tmux`: prefix is remapped from `Ctrl-b` to backtick.

```text
` then key
```

- Zsh: shared history, completions, syntax highlighting, autosuggestions, fzf, guarded `eza`/`bat`/`zoxide` integrations, and Starship prompt.

Configure `llm` separately, for example:

```sh
llm keys set openai
```
