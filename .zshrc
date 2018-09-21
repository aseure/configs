fpath=( 
  "$HOME/.zfunctions"
  $fpath
)

autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U promptinit && promptinit
autoload -U select-word-style && select-word-style bash

prompt pure

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:match:*' original only

export EDITOR="vim"
export GOPATH="$HOME/go"
export HISTFILE=~/.history
export HISTFILESIZE=100000
export HISTSIZE=100000
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MANPAGER="most -s"
export PAGER="most"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="${HOME}/.pyenv"

alias env="env | sort"
alias g++='g++-8'
alias gcc='gcc-8'
alias kec='knife environment compare'
alias knl='knife node list'
alias kns='knife node show'
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -FG'
alias rake='noglob rake -s'
alias resource='source ~/.zshrc'
alias rg='rg --smart-case'
alias tree='tree -C'

[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"
[ -f ~/.fzf.zsh                              ] && source ~/.fzf.zsh

eval "$(fasd --init auto)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#eval "$(rbenv init -)"

