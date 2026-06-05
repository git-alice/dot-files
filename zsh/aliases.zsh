# Small, conservative aliases and helper functions.

alias reload-zsh="source ~/.zshrc"
alias path="print -l \$path"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --group-directories-first"
  alias ll="eza -lah --group-directories-first --git"
  alias la="eza -a --group-directories-first"
  alias lt="eza --tree --level=2 --group-directories-first"
else
  alias ll="ls -lah"
  alias la="ls -A"
fi

mkcd() {
  mkdir -p "$1" && cd "$1"
}
