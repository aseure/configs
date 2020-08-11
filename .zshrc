fpath=(
  "$HOME/.zfunctions"
  "$HOME/.zfunctions/pure"
  $fpath
)

autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U promptinit && promptinit
autoload -U public
autoload -U select-word-style && select-word-style bash
prompt pure

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:match:*' original only
zstyle ':prompt:pure:git:dirty' color 'blue'

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# Ensure that IntellJ doesn't use his own history file. See the source code
# of the terminal plugin of IntelliJ for more details:
# https://github.com/JetBrains/intellij-community/blob/master/plugins/terminal/resources/.zshrc
unset __INTELLIJ_COMMAND_HISTFILE__

export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8

export CCACHE_CPP2=yes
export EDITOR="vim"
export GOPATH="$HOME/go"
export GPG_TTY=$(tty)
export HISTFILE="$HOME/.history"
export HISTFILESIZE=10000
export HISTSIZE=10000
export MANPAGER="most"
export PAGER="most"
export SAVEHIST=10000

export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"

alias bat='bat --pager="less" --wrap=never'
alias j='fasd_cd -d'
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -FG'
alias rg="rg --smart-case --no-line-number"

export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="/Users/anthony.seure/.sdkman"

[ -f ~/.fzf.zsh                                   ] && source ~/.fzf.zsh
[ -f ~/.rvm/scripts/rvm                           ] && source ~/.rvm/scripts/rvm
[ -f ~/.sdkman/bin/sdkman-init.sh                 ] && source ~/.sdkman/bin/sdkman-init.sh
[ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ] && source /usr/local/opt/nvm/etc/bash_completion.d/nvm
[ -s /usr/local/opt/nvm/nvm.sh                    ] && source /usr/local/opt/nvm/nvm.sh

eval "$(fasd --init auto)"
eval "$(gh completion -s zsh)"
eval "$(pyenv init -)"
