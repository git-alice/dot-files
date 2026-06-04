# Prompt setup.

if [[ "${TERM:-}" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="${STARSHIP_CONFIG:-${ZSH_DOTFILES_DIR}/starship/starship.toml}"
  eval "$(starship init zsh)"
fi
