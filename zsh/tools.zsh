# Optional shell companions. Every integration is guarded so VPS support can stay lean.

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
elif command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height 40% --layout=reverse --border --inline-info}"
  export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:---sort --exact}"

  if command -v brew >/dev/null 2>&1; then
    _zsh_dotfiles_fzf_root="$(brew --prefix fzf 2>/dev/null)"
    [[ -r "${_zsh_dotfiles_fzf_root}/shell/key-bindings.zsh" ]] && source "${_zsh_dotfiles_fzf_root}/shell/key-bindings.zsh"
    [[ -r "${_zsh_dotfiles_fzf_root}/shell/completion.zsh" ]] && source "${_zsh_dotfiles_fzf_root}/shell/completion.zsh"
    unset _zsh_dotfiles_fzf_root
  fi
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
