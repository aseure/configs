#!/bin/bash

echo "> Current configuration files for Git, Vim, ZSH and iTerm2 will be overriden."
echo "> Press any key to continue or press ^C to abort"
read

git reset --hard HEAD

# Mac specific
PLATFORM=$(uname)
if [[ $PLATFORM == "Darwin" ]]; then
  defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false       # For IntelliJ
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
  # defaults delete -g ApplePressAndHoldEnabled                                    # If necessary, reset global default
fi

# Prepare ZSH (Pure prompt)
rm -rf .zfunctions/pure
git clone git@github.com:sindresorhus/pure.git .zfunctions/pure

# Create relatives links
mkdir -p ~/.config ~/.claude
rm -f ~/.gitconfig && ln -s $PWD/.gitconfig ~
rm -f ~/.gitignore_global && ln -s $PWD/.gitignore_global ~
rm -f ~/.tokeirc && ln -s $PWD/.tokeirc ~
rm -f ~/.zshrc && ln -s $PWD/.zshrc ~
rm -rf ~/.config/nvim* && ln -s $PWD/nvim* ~/.config
rm -rf ~/.zfunctions && ln -s $PWD/.zfunctions ~
rm -rf ~/.config/ripgreprc && ln -s $PWD/ripgreprc ~/.config/.ripgreprc
rm -f ~/.wezterm.lua && ln -s $PWD/.wezterm.lua ~
rm -f ~/.claude/CLAUDE.md && ln -s $PWD/agents/CLAUDE.md ~/.claude/CLAUDE.md

# Link agent skills into Claude Code.
#
# Skills are linked one by one rather than linking the whole directory, as
# Claude Code installs the skills coming from plugins right next to ours and
# replacing the whole directory with a symlink would wipe them out.
link_skills() {
  local target=~/.claude/skills
  local skill name

  mkdir -p "$target"

  # Drop symlinks pointing back at this repository so renamed and deleted
  # skills don't linger. Anything else in the directory is left untouched.
  for skill in "$target"/*; do
    if [[ -L $skill && $(readlink "$skill") == $PWD/agents/skills/* ]]; then
      rm -f "$skill"
    fi
  done

  for skill in agents/skills/*/; do
    [[ -d $skill ]] || continue # No skill at all: the glob stayed unexpanded
    name=$(basename "$skill")
    rm -rf "${target:?}/$name" && ln -s "$PWD/agents/skills/$name" "$target/$name"
  done
}

link_skills

# Download Git completion for ZSH
mkdir -p ~/.zsh
curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

cd

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
