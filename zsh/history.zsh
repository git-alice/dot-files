# Shared, timestamped history across interactive Zsh sessions.

export HISTFILE="${HISTFILE:-${XDG_STATE_HOME:-${HOME}/.local/state}/zsh/history}"
mkdir -p "${HISTFILE:h}" 2>/dev/null

export HISTSIZE="${HISTSIZE:-100000}"
export SAVEHIST="${SAVEHIST:-100000}"

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history

unsetopt hist_beep
unsetopt inc_append_history
