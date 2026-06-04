# Keybindings that depend on widgets loaded by plugins.

bindkey -e

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

zmodload zsh/terminfo 2>/dev/null || true

if zle -l history-substring-search-up >/dev/null 2>&1; then
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  [[ -n "${terminfo[kcuu1]:-}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [[ -n "${terminfo[kcud1]:-}" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char
