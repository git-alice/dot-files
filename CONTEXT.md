# Terminal Dotfiles

This context defines the language for a focused personal terminal configuration repository.

## Language

**Terminal Dotfiles**:
A personal terminal configuration repository scoped to interactive shell and terminal multiplexer behavior.
_Avoid_: Workstation setup, system setup, full dotfiles

**Zsh Dotfiles**:
A personal shell configuration area scoped to Zsh startup files, shell behavior, completions, history, prompt, and related interactive shell tooling.
_Avoid_: Shell setup, terminal setup

**Tmux Config**:
The tmux configuration loaded from the Managed Config Directory to define terminal multiplexer behavior such as the prefix key.
_Avoid_: Tmux setup, terminal config

**Bootstrap**:
The one-line entry point that prepares a machine to use the Terminal Dotfiles from a GitHub-hosted install script.
_Avoid_: Setup, installer, provisioning

**Managed Config Directory**:
The `$HOME/.config/zsh-dotfiles` directory where the Bootstrap stores the cloned Terminal Dotfiles repository on a machine.
_Avoid_: Dotfiles folder, install directory, config folder

**Managed Source Block**:
The clearly marked section in `~/.zshrc` that loads the Managed Config Directory and is the only part of `~/.zshrc` owned by the Bootstrap.
_Avoid_: Zshrc rewrite, shell takeover, injected config

**Managed Tmux Block**:
The clearly marked section in `~/.tmux.conf` that loads the Tmux Config and is the only part of `~/.tmux.conf` owned by the Bootstrap.
_Avoid_: Tmux rewrite, tmux takeover

**Shell History**:
The shared interactive command history used across Zsh terminal sessions, with timestamps and duplicate reduction.
_Avoid_: Command log, terminal history
