#! /bin/bash

echo "> Current configuration files for Git, Vim, ZSH and iTerm2 will be overriden."
echo "> Press any key to continue or press ^C to abort"
read

git reset --hard HEAD

# Mac specific
PLATFORM=`uname`
if [[ $PLATFORM == "Darwin" ]]; then
  defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false
fi

# Reinstall Vim Plug
rm -f .vim/autoload/plug.vim
curl -fLo .vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Reinstall iTerm2 integration
rm -f .iterm2_shell_integration.zsh
curl -L https://iterm2.com/shell_integration/zsh -o .iterm2_shell_integration.zsh

# Prepare ZSH (Pure prompt)
rm -rf .zfunctions/pure
git clone git@github.com:sindresorhus/pure.git .zfunctions/pure

# Create relatives links
rm -f  ~/.gitconfig                    && ln -s $PWD/.gitconfig ~
rm -f  ~/.gitignore_global             && ln -s $PWD/.gitignore_global ~
rm -f  ~/.iterm2_shell_integration.zsh && ln -s $PWD/.iterm2_shell_integration.zsh ~
rm -f  ~/.zshrc                        && ln -s $PWD/.zshrc ~
rm -rf ~/.vim*                         && ln -s $PWD/.vim* ~
rm -rf ~/.zfunctions                   && ln -s $PWD/.zfunctions ~

cd
vim +PlugInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
