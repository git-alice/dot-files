# Native Zsh completion with a persistent cache.

autoload -Uz compinit
zmodload zsh/complist 2>/dev/null || true

_zsh_dotfiles_completion_cache="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
mkdir -p "$_zsh_dotfiles_completion_cache" 2>/dev/null

zstyle ":completion:*" use-cache on
zstyle ":completion:*" cache-path "${_zsh_dotfiles_completion_cache}/zcompcache"
zstyle ":completion:*" menu select
zstyle ":completion:*" group-name ""
zstyle ":completion:*" verbose yes
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" "r:|[._-]=* r:|=*"
zstyle ":completion:*:descriptions" format "%F{yellow}-- %d --%f"
zstyle ":completion:*:messages" format "%F{purple}-- %d --%f"
zstyle ":completion:*:warnings" format "%F{red}-- no matches --%f"
zstyle ":completion:*:default" list-prompt "%S%M matches%s"
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*:*:*:*:processes" command "ps -u $USER -o pid,user,comm -w -w"

if [[ -n "${LS_COLORS:-}" ]]; then
  zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
fi

compinit -i -d "${_zsh_dotfiles_completion_cache}/zcompdump-${ZSH_VERSION}"

unset _zsh_dotfiles_completion_cache
