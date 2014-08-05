#! /bin/bash

# Set those variables to fit your configuration
EPITA_LOGIN="seure-_a"
EPITA_PASS_SOCKS="toto"
COLOR_ONE="green"
COLOR_TWO="red"

# Modify SOUL configuration
sed "s/login_x/$EPITA_LOGIN/" .jogsoul/jogsoul.conf > .jogsoul_tmp
sed "s/password/$EPITA_PASS_SOCKS/" .jogsoul_tmp > .jogsoul/jogsoul.conf
rm .jogsoul_tmp

# Modify TMUX configuration
sed "s/blue/$COLOR_ONE/" .tmux.conf > .tmux.conf_tmp
mv .tmux.conf_tmp .tmux.conf

# Modify ZSH configuration
sed "s/fg\[blue\]/fg[$COLOR_ONE]/" .zshrc > .zshrc_tmp
sed "s/fg\[yellow\]/fg[$COLOR_TWO]/" .zshrc_tmp > .zshrc
rm .zshrc_tmp

# Prepare Vim
mkdir -p .vim/bundle
git clone https://github.com/gmarik/Vundle.vim .vim/bundle/Vundle.vim
vim +BundleInstall +qa!

# Mac specific
PLATFORM=`uname`
if [[ $platform == "Darwin" ]]; then
  sed "s/ls --color=auto/ls -G/" .zshrc > .zshrc_tmp
  mv .zshrc_tmp .zshrc
fi

## Remove existing files
#rm -rf ~/.jogsoul*
#rm -rf ~/.tmux*
#rm -rf ~/.vim*
#rm -rf ~/.zsh*

## Create relatives links
#ln -s `echo $PWD`/.jogsoul* ~
#ln -s `echo $PWD`/.tmux* ~
#ln -s `echo $PWD`/.vim* ~
#ln -s `echo $PWD`/.zsh* ~
