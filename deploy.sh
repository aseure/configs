#! /bin/bash

echo "> Current configuration files for Git, Vim, ZSH and iTerm2 will be overriden."
echo "> Press any key to continue or press ^C to abort"
read

git reset --hard HEAD

# Mac specific
PLATFORM=`uname`
if [[ $PLATFORM == "Darwin" ]]; then
  defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false       # For IntelliJ
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
  # defaults delete -g ApplePressAndHoldEnabled                                    # If necessary, reset global default
fi

# Reinstall Vim Plug
rm -f .vim/autoload/plug.vim
curl -fLo .vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Prepare ZSH (Pure prompt)
rm -rf .zfunctions/pure
git clone git@github.com:sindresorhus/pure.git .zfunctions/pure

# Create relatives links
rm -f  ~/.git-completion.zsh           && ln -s $PWD/.git-completion.zsh ~
rm -f  ~/.gitconfig                    && ln -s $PWD/.gitconfig ~
rm -f  ~/.gitignore_global             && ln -s $PWD/.gitignore_global ~
rm -f  ~/.zshrc                        && ln -s $PWD/.zshrc ~
rm -rf ~/.vim*                         && ln -s $PWD/.vim* ~
rm -rf ~/.zfunctions                   && ln -s $PWD/.zfunctions ~

# Download Git completion for ZSH
mkdir -p ~/.zsh
curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

cd
vim +PlugInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
