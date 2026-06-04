# Managed Zsh entry point. This file is sourced from the Managed Source Block.

typeset -g ZSH_DOTFILES_DIR="${ZSH_DOTFILES_DIR:-${${(%):-%N}:A:h:h}}"

for _zsh_dotfiles_module in \
  history \
  plugins \
  completion \
  tools \
  aliases \
  keybindings \
  prompt
do
  _zsh_dotfiles_module_path="${ZSH_DOTFILES_DIR}/zsh/${_zsh_dotfiles_module}.zsh"
  [[ -r "$_zsh_dotfiles_module_path" ]] && source "$_zsh_dotfiles_module_path"
done

unset _zsh_dotfiles_module _zsh_dotfiles_module_path
