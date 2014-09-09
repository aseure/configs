#! /bin/bash

echo "> Your configurations files for Jogsoul, Tmux, Vim and ZSH will be erased."
echo "> Press any key to continue or press ^C to abort"
read

# Set those variables to fit your configuration
EPITA_LOGIN="login_x"
EPITA_PASS_SOCKS="password"
COLOR_ONE="blue"
COLOR_TWO="yellow"

# Remove existing files and checkout the current Git repository on HEAD
rm -rf ~/.jogsoul*
rm -rf ~/.tmux*
rm -rf ~/.vim*
rm -rf ~/.zsh*
git reset --hard HEAD

# Modify SOUL configuration
sed -i '' -e "s/login_x/$EPITA_LOGIN/" .jogsoul/jogsoul.conf
sed -i '' -e "s/password/$EPITA_PASS_SOCKS/" .jogsoul/jogsoul.conf

# Modify TMUX configuration
sed -i '' -e "s/yellow/$COLOR_TWO/" .tmux.conf

# Modify ZSH configuration
sed -i '' -e "s/fg\[blue\]/fg[$COLOR_ONE]/g" .zshrc
sed -i '' -e "s/fg\[yellow\]/fg[$COLOR_TWO]/g" .zshrc

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
ln -s `echo $PWD`/.jogsoul* ~
ln -s `echo $PWD`/.tmux* ~
ln -s `echo $PWD`/.vim* ~
ln -s `echo $PWD`/.zsh* ~

cd
vim +BundleInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
