# Zinit-managed plugins. Keep this simple first; add lazy loading only when needed.

[[ "${ZSH_DOTFILES_DISABLE_PLUGINS:-0}" == "1" ]] && return

typeset -g ZINIT_HOME="${ZINIT_HOME:-${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git}"

if [[ ! -r "${ZINIT_HOME}/zinit.zsh" ]]; then
  if command -v git >/dev/null 2>&1; then
    mkdir -p "${ZINIT_HOME:h}"
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  else
    return
  fi
fi

source "${ZINIT_HOME}/zinit.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"

zinit ice depth"1"
zinit light zsh-users/zsh-completions

zinit ice depth"1"
zinit light zsh-users/zsh-autosuggestions

zinit ice depth"1"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth"1"
zinit light zsh-users/zsh-history-substring-search
