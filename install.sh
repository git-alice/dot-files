#!/usr/bin/env zsh

emulate -L zsh
setopt ERR_EXIT PIPE_FAIL

readonly DOTFILES_REPO_URL="${DOTFILES_REPO_URL:-https://github.com/git-alice/dot-files.git}"
readonly DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"
readonly DOTFILES_INSTALL_DIR="${DOTFILES_INSTALL_DIR:-${HOME}/.config/zsh-dotfiles}"
readonly ZDOTFILES_ZSHRC="${ZDOTFILES_ZSHRC:-${HOME}/.zshrc}"
readonly ZDOTFILES_TMUX_CONF="${ZDOTFILES_TMUX_CONF:-${HOME}/.tmux.conf}"

readonly BLOCK_BEGIN="# >>> zsh-dotfiles >>>"
readonly BLOCK_END="# <<< zsh-dotfiles <<<"
readonly TMUX_BLOCK_BEGIN="# >>> zsh-dotfiles tmux >>>"
readonly TMUX_BLOCK_END="# <<< zsh-dotfiles tmux <<<"

log() {
  print -r -- "[zsh-dotfiles] $*"
}

die() {
  print -ru2 -- "[zsh-dotfiles] $*"
  exit 1
}

detect_os() {
  case "$(uname -s)" in
    Darwin) print -r -- "macos" ;;
    *) print -r -- "unsupported" ;;
  esac
}

find_brew() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    print -r -- /opt/homebrew/bin/brew
  elif [[ -x /usr/local/bin/brew ]]; then
    print -r -- /usr/local/bin/brew
  else
    return 1
  fi
}

install_macos_dependencies() {
  local brew_path
  brew_path="$(find_brew)" || die "Homebrew is required for v1. Install it from https://brew.sh, then rerun this command."

  eval "$("$brew_path" shellenv)"

  local packages=(
    git
    zsh
    fzf
    tmux
    llm
    starship
    ripgrep
    fd
    bat
    eza
    zoxide
  )

  local missing=()
  local package
  for package in "${packages[@]}"; do
    if ! brew list --formula "$package" >/dev/null 2>&1; then
      missing+=("$package")
    fi
  done

  if (( ${#missing[@]} > 0 )); then
    log "Installing Homebrew packages: ${missing[*]}"
    brew install "${missing[@]}"
  else
    log "Homebrew packages are already installed."
  fi
}

install_dependencies() {
  case "$(detect_os)" in
    macos) install_macos_dependencies ;;
    *) die "v1 supports macOS only. Linux/VPS support is planned for the next step." ;;
  esac
}

ensure_clean_repo() {
  local repo_dir="$1"
  local repo_status

  repo_status="$(git -C "$repo_dir" status --porcelain)"
  if [[ -n "$repo_status" ]]; then
    die "Local changes found in $repo_dir. Commit, stash, or remove them before rerunning the bootstrap."
  fi
}

sync_repo() {
  if [[ -d "$DOTFILES_INSTALL_DIR/.git" ]]; then
    log "Updating $DOTFILES_INSTALL_DIR"
    ensure_clean_repo "$DOTFILES_INSTALL_DIR"
    git -C "$DOTFILES_INSTALL_DIR" remote set-url origin "$DOTFILES_REPO_URL"
    git -C "$DOTFILES_INSTALL_DIR" fetch --prune origin "$DOTFILES_BRANCH"
    git -C "$DOTFILES_INSTALL_DIR" checkout "$DOTFILES_BRANCH"
    git -C "$DOTFILES_INSTALL_DIR" pull --ff-only origin "$DOTFILES_BRANCH"
    return
  fi

  if [[ -e "$DOTFILES_INSTALL_DIR" ]]; then
    die "$DOTFILES_INSTALL_DIR already exists but is not a Git repository."
  fi

  log "Cloning $DOTFILES_REPO_URL into $DOTFILES_INSTALL_DIR"
  mkdir -p "${DOTFILES_INSTALL_DIR:h}"
  git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO_URL" "$DOTFILES_INSTALL_DIR"
}

write_managed_source_block() {
  local tmp_file
  local backup_file
  local source_file="${DOTFILES_INSTALL_DIR}/zsh/init.zsh"

  mkdir -p "${ZDOTFILES_ZSHRC:h}"
  [[ -f "$ZDOTFILES_ZSHRC" ]] || : > "$ZDOTFILES_ZSHRC"

  tmp_file="${ZDOTFILES_ZSHRC}.tmp.$$"

  awk -v begin="$BLOCK_BEGIN" -v end="$BLOCK_END" '
    $0 == begin { skip = 1; next }
    $0 == end { skip = 0; next }
    !skip { lines[++n] = $0 }
    END {
      while (n > 0 && lines[n] == "") n--
      for (i = 1; i <= n; i++) print lines[i]
    }
  ' "$ZDOTFILES_ZSHRC" > "$tmp_file"

  if [[ -s "$tmp_file" ]]; then
    print -r -- "" >> "$tmp_file"
    print -r -- "" >> "$tmp_file"
  fi

  {
    print -r -- "$BLOCK_BEGIN"
    print -r -- "if [[ -f \"$source_file\" ]]; then"
    print -r -- "  source \"$source_file\""
    print -r -- "fi"
    print -r -- "$BLOCK_END"
  } >> "$tmp_file"

  if cmp -s "$ZDOTFILES_ZSHRC" "$tmp_file"; then
    rm -f "$tmp_file"
    log "Managed source block is already up to date in $ZDOTFILES_ZSHRC"
    return
  fi

  backup_file="${ZDOTFILES_ZSHRC}.backup.$(date +%Y%m%d-%H%M%S)"
  cp "$ZDOTFILES_ZSHRC" "$backup_file"
  mv "$tmp_file" "$ZDOTFILES_ZSHRC"
  log "Updated $ZDOTFILES_ZSHRC and saved backup to $backup_file"
}

write_managed_tmux_block() {
  local tmp_file
  local backup_file
  local source_file="${DOTFILES_INSTALL_DIR}/tmux/tmux.conf"

  mkdir -p "${ZDOTFILES_TMUX_CONF:h}"
  [[ -f "$ZDOTFILES_TMUX_CONF" ]] || : > "$ZDOTFILES_TMUX_CONF"

  tmp_file="${ZDOTFILES_TMUX_CONF}.tmp.$$"

  awk -v begin="$TMUX_BLOCK_BEGIN" -v end="$TMUX_BLOCK_END" '
    $0 == begin { skip = 1; next }
    $0 == end { skip = 0; next }
    !skip { lines[++n] = $0 }
    END {
      while (n > 0 && lines[n] == "") n--
      for (i = 1; i <= n; i++) print lines[i]
    }
  ' "$ZDOTFILES_TMUX_CONF" > "$tmp_file"

  if [[ -s "$tmp_file" ]]; then
    print -r -- "" >> "$tmp_file"
    print -r -- "" >> "$tmp_file"
  fi

  {
    print -r -- "$TMUX_BLOCK_BEGIN"
    print -r -- "if-shell \"test -f '$source_file'\" \"source-file '$source_file'\""
    print -r -- "$TMUX_BLOCK_END"
  } >> "$tmp_file"

  if cmp -s "$ZDOTFILES_TMUX_CONF" "$tmp_file"; then
    rm -f "$tmp_file"
    log "Managed tmux block is already up to date in $ZDOTFILES_TMUX_CONF"
    return
  fi

  backup_file="${ZDOTFILES_TMUX_CONF}.backup.$(date +%Y%m%d-%H%M%S)"
  cp "$ZDOTFILES_TMUX_CONF" "$backup_file"
  mv "$tmp_file" "$ZDOTFILES_TMUX_CONF"
  log "Updated $ZDOTFILES_TMUX_CONF and saved backup to $backup_file"
}

main() {
  install_dependencies
  sync_repo
  write_managed_source_block
  write_managed_tmux_block
  log "Done. Open a new Zsh session or run: source $ZDOTFILES_ZSHRC"
}

main "$@"
