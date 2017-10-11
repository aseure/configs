#! /bin/bash

echo "> Your configurations files for Git, Tmux, Vim, ZSH and Pentadactyl will be erased."
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
  sed -i '' "s/Anthony Seure/$GIT_CONFIG_NAME/g" .gitconfig
  sed -i '' "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
else
  sed -i "s/Anthony Seure/$GIT_CONFIG_NAME/g" .gitconfig
  sed -i "s/anthony\.seure@gmail\.com/$GIT_CONFIG_EMAIL/g" .gitconfig
fi

# Prepare Vim
mkdir -p .vim/bundle && rm -rf .vim/bundle/*
git clone https://github.com/gmarik/Vundle.vim .vim/bundle/Vundle.vim

# Prepare ZSH (Pure prompt)
mkdir -p ~/.zfunctions/pure && rm -rf ~/.zfunctions/pure/*
git clone git@github.com:sindresorhus/pure.git

# Create relatives links
rm -f ~/.Xresources       && ln -s $PWD/.Xresources ~
rm -f ~/.gitconfig        && ln -s $PWD/.gitconfig ~
rm -f ~/.gitignore_global && ln -s $PWD/.gitignore_global ~
rm -f ~/.pentadactyl*     && ln -s $PWD/.pentadactyl* ~
rm -f ~/.tmux*            && ln -s $PWD/.tmux* ~
rm -f ~/.vim*             && ln -s $PWD/.vim* ~
rm -f ~/.zshrc            && ln -s $PWD/.zshrc ~
ln -s $PWD/pure/pure.zsh  ~/.zfunctions/pure/prompt_pure_setup
ln -s $PWD/pure/async.zsh ~/.zfunctions/pure/async

cd
vim +BundleInstall +qa!

echo
echo "> Configurations updated. Now just run \`source .zshrc\`"
