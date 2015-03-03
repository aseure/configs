#! /bin/bash

echo "> Your configurations files for Git, Tmux, Vim, ZSH and Pentadactyl will be erased."
echo "> Press any key to continue or press ^C to abort"
read

# Set those variables to fit your configuration
COLOR_ONE="blue"
COLOR_TWO="green"
GIT_CONFIG_NAME="Anthony Seure"
GIT_CONFIG_EMAIL="anthony.seure@gmail.com"

# Mac specific
PLATFORM=`uname`

# Remove existing files and checkout the current Git repository on HEAD
rm -rf ~/.tmux*
rm -rf ~/.vim*
rm -rf ~/.zsh*
rm -f ~/.gitconfig
rm -f ~/.gitignore_global
rm -f ~/.pentadactyl*
git reset --hard HEAD

# Modify Git configuration
if [[ $PLATFORM == "Darwin" ]]; then
  sed -i '' "s/Anthony Seure/$GIT_CONFIG_NAME/g" .gitconfig
  sed -i '' "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
else
  sed -i "s/Anthony Seure/$GIT_CONFIG_NAME/g" .gitconfig
  sed -i "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
fi

# Modify ZSH configuration
if [[ $PLATFORM == "Darwin" ]]; then
  sed -i '' "s/fg\[blue\]/fg[$COLOR_ONE]/g" .zshrc
  sed -i '' "s/fg\[green\]/fg[$COLOR_TWO]/g" .zshrc
else
  sed -i "s/fg\[blue\]/fg[$COLOR_ONE]/g" .zshrc
  sed -i "s/fg\[green\]/fg[$COLOR_TWO]/g" .zshrc
fi

# Prepare Vim
mkdir -p .vim/bundle
rm -rf .vim/bundle/*
git clone https://github.com/gmarik/Vundle.vim .vim/bundle/Vundle.vim

# Mac specific
if [[ $PLATFORM == "Darwin" ]]; then
  sed -i '' "s/ls --color=auto/ls -G/" .zshrc
fi

# Create relatives links
ln -s `echo $PWD`/.tmux* ~
ln -s `echo $PWD`/.vim* ~
ln -s `echo $PWD`/.zsh* ~
ln -s `echo $PWD`/.gitconfig ~
ln -s `echo $PWD`/.gitignore_global ~
ln -s `echo $PWD`/.pentadactyl* ~

cd
vim +BundleInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
