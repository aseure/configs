#! /bin/bash

echo "> Current configuration files for Git, Vim and ZSH will be overriden."
echo "> Press any key to continue or press ^C to abort"
read

# Set those variables to fit your configuration
GIT_CONFIG_NAME="Anthony Seure"
GIT_CONFIG_EMAIL="anthony.seure@gmail.com"

# Mac specific
PLATFORM=`uname`

git reset --hard HEAD

# Modify Git configuration
if [[ $PLATFORM == "Darwin" ]]; then
  sed -i '' "s/Anthony Seure/$GIT_CONFIG_NAME/g"              .gitconfig
  sed -i '' "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
  defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false
else
  sed -i    "s/Anthony Seure/$GIT_CONFIG_NAME/g"              .gitconfig
  sed -i    "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
fi

# Reinstall Vim Plug
rm -f .vim/autoload/plug.vim
curl -fLo .vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Prepare ZSH (Pure prompt)
rm -rf .zfunctions/pure
git clone git@github.com:sindresorhus/pure.git .zfunctions/pure

# Create relatives links
rm -f ~/.gitconfig        && ln -s $PWD/.gitconfig ~
rm -f ~/.gitignore_global && ln -s $PWD/.gitignore_global ~
rm -f ~/.vim*             && ln -s $PWD/.vim* ~
rm -f ~/.zshrc            && ln -s $PWD/.zshrc ~
rm -f ~/.zfunctions       && ln -s $PWD/.zfunctions ~
ln -s $PWD/pure/pure.zsh  ~/.zfunctions/pure/prompt_pure_setup
ln -s $PWD/pure/async.zsh ~/.zfunctions/pure/async

cd
vim +PlugInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
