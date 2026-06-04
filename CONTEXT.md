# Zsh Dotfiles

This context defines the language for a focused personal Zsh configuration repository.

## Language

**Zsh Dotfiles**:
A personal shell configuration repository scoped to Zsh startup files, shell behavior, completions, history, prompt, and related interactive shell tooling.
_Avoid_: Workstation setup, system setup, full dotfiles

**Bootstrap**:
The one-line entry point that prepares a machine to use the Zsh Dotfiles from a GitHub-hosted install script.
_Avoid_: Setup, installer, provisioning

**Managed Config Directory**:
The `$HOME/.config/zsh-dotfiles` directory where the Bootstrap stores the cloned Zsh Dotfiles repository on a machine.
_Avoid_: Dotfiles folder, install directory, config folder

**Managed Source Block**:
The clearly marked section in `~/.zshrc` that loads the Managed Config Directory and is the only part of `~/.zshrc` owned by the Bootstrap.
_Avoid_: Zshrc rewrite, shell takeover, injected config

**Shell History**:
The shared interactive command history used across Zsh terminal sessions, with timestamps and duplicate reduction.
_Avoid_: Command log, terminal history
