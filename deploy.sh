#! /bin/bash

echo "> Your configurations files for Git, Tmux, Vim and ZSH will be erased."
echo "> Press any key to continue or press ^C to abort"
read

# Set those variables to fit your configuration
COLOR_ONE="blue"
COLOR_TWO="green"
GIT_CONFIG_NAME="Anthony Seure"
GIT_CONFIG_EMAIL="anthony.seure@gmail.com"

# Remove existing files and checkout the current Git repository on HEAD
rm -rf ~/.tmux*
rm -rf ~/.vim*
rm -rf ~/.zsh*
rm -f ~/.gitconfig
rm -f ~/.gitignore_global
git reset --hard HEAD

# Modify Git configuration
sed -i '' -e "s/Anthony Seure/$GIT_CONFIG_NAME/g" .gitconfig
sed -i '' -e "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig

# Modify ZSH configuration
sed -i '' -e "s/fg\[blue\]/fg[$COLOR_ONE]/g" .zshrc
sed -i '' -e "s/fg\[green\]/fg[$COLOR_TWO]/g" .zshrc

# Prepare Vim
mkdir -p .vim/bundle
rm -rf .vim/bundle/*
git clone https://github.com/gmarik/Vundle.vim .vim/bundle/Vundle.vim

# Mac specific
PLATFORM=`uname`
if [[ $PLATFORM == "Darwin" ]]; then
  sed -i '' -e "s/ls --color=auto/ls -G/" .zshrc
fi

# Create relatives links
ln -s `echo $PWD`/.tmux* ~
ln -s `echo $PWD`/.vim* ~
ln -s `echo $PWD`/.zsh* ~
ln -s `echo $PWD`/.gitconfig ~
ln -s `echo $PWD`/.gitignore_global ~

cd
vim +BundleInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
