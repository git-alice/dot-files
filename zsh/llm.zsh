# Lightweight terminal LLM helper. Provider/model configuration belongs to the llm CLI.

unalias @ii 2>/dev/null || true

@ii() {
  emulate -L zsh

  if ! command -v llm >/dev/null 2>&1; then
    print -u2 -- "@ii requires the llm CLI. Re-run the dotfiles installer or install it with: brew install llm"
    return 127
  fi

  if [[ $# -eq 0 && -t 0 ]]; then
    print -u2 -- "usage: @ii <request>"
    print -u2 -- "   or: some-command | @ii <request about stdin>"
    return 2
  fi

  local system_prompt
  system_prompt="You are a concise terminal assistant. Answer directly. If asked for a shell command, provide the command and mention destructive risks briefly. Do not claim to execute commands."

  local prompt
  if [[ -t 0 ]]; then
    prompt="$*"
  else
    local stdin_text
    stdin_text="$(cat)"
    if [[ $# -gt 0 ]]; then
      prompt="$*

Input:
$stdin_text"
    else
      prompt="$stdin_text"
    fi
  fi

  llm --system "$system_prompt" "$prompt"
}

alias @ii="noglob @ii"
