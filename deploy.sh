#! /bin/bash

# Set those variables to fit your configuration
EPITA_LOGIN='login'
EPTIA_PASS_SOCKS='password'
COLOR_ONE='blue'
COLOR_TWO='yellow'

# Modify SOUL configuration
sed 's/login_x/$LOGIN/' .jogsoul/jogsoul.conf > .jogsoul_tmp
sed 's/password/$PASSWORD/' .jogsoul_tmp > .jogsoul/jogsoul.conf
rm .jogsoul_tmp

# Modify TMUX configuration
sed 's/blue/$COLOR_ONE/' .tmux.conf > .tmux.conf_tmp
mv .tmux.conf_tmp .tmux.conf

# Modify ZSH configuration
sed 's/fg[blue]/fg[$COLOR_ONE]/' .zshrc > .zshrc_tmp
sed 's/fg[yellow]/fg[$COLOR_TWO]/' .zshrc_tmp > .zshrc
rm .zshrc_tmp


# Mac specific
PLATFORM=`uname`
if [[ $platform == 'Darwin' ]]; then
  sed 's/ls --color=auto/ls -G/' .zshrc > .zshrc_tmp
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
