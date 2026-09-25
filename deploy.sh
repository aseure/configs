#!/bin/bash

confirm_overwrite() {
  echo "> Current configuration files for Git, Vim, ZSH and iTerm2 will be overriden."
  echo "> Press any key to continue or press ^C to abort"
  read
}

reset_repository() {
  git reset --hard HEAD
}

configure_macos() {
  [[ $(uname) == "Darwin" ]] || return 0

  defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false       # For IntelliJ
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
  # defaults delete -g ApplePressAndHoldEnabled                                    # If necessary, reset global default
}

install_pure_prompt() {
  rm -rf .zfunctions/pure
  git clone git@github.com:sindresorhus/pure.git .zfunctions/pure
}

link() {
  local source=$1
  local target=$2

  rm -rf "$target" && ln -s "$PWD/$source" "$target"
}

link_configs() {
  mkdir -p ~/.config ~/.claude

  link .gitconfig ~/.gitconfig
  link .gitignore_global ~/.gitignore_global
  link .tokeirc ~/.tokeirc
  link .zshrc ~/.zshrc
  link .zfunctions ~/.zfunctions
  link .wezterm.lua ~/.wezterm.lua
  link nvim ~/.config/nvim
  link ripgreprc ~/.config/.ripgreprc
  link agents/CLAUDE.md ~/.claude/CLAUDE.md
}

prune_stale_skills() {
  local target=$1
  local skill

  for skill in "$target"/*; do
    if [[ -L $skill && $(readlink "$skill") == $PWD/agents/skills/* ]]; then
      rm -f "$skill"
    fi
  done
}

link_skills() {
  local target=~/.claude/skills
  local skill name

  mkdir -p "$target"
  prune_stale_skills "$target"

  for skill in agents/skills/*/; do
    [[ -d $skill ]] || continue
    name=$(basename "$skill")
    link "agents/skills/$name" "$target/$name"
  done
}

install_git_completion() {
  mkdir -p ~/.zsh
  curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
}

print_next_steps() {
  echo
  echo "> Configurations updated. Now just run \`source .zshrc\`"
}

main() {
  confirm_overwrite
  reset_repository
  configure_macos
  install_pure_prompt
  link_configs
  link_skills
  install_git_completion
  print_next_steps
}

main
