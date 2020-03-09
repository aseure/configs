fpath=(
  "$HOME/.zfunctions"
  "$HOME/.zfunctions/pure"
  $fpath
)

autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U promptinit && promptinit
autoload -U select-word-style && select-word-style bash

prompt pure

# Ensure that IntellJ doesn't use his own history file...
# See the source code of the terminal plugin of IntelliJ for more details:
# https://github.com/JetBrains/intellij-community/blob/master/plugins/terminal/resources/.zshrc
unset __INTELLIJ_COMMAND_HISTFILE__

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:match:*' original only
zstyle ':prompt:pure:git:dirty' color 'blue'

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
export JAVA_HOME_11=`/usr/libexec/java_home -v 11`
export JAVA_HOME_8=`/usr/libexec/java_home -v 1.8`
export JAVA_HOME="$JAVA_HOME_8"
export MANPAGER="most"
export PAGER="most"
export SAVEHIST=10000

export PATH="/Library/TeX/texbin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

alias bat='bat --pager="less" --wrap=never'
alias j='fasd_cd -d'
alias java11="export JAVA_HOME=$JAVA_HOME_11"
alias java8="export JAVA_HOME=$JAVA_HOME_8"
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -FG'
alias rg="rg --smart-case"

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "

  export FZF_DEFAULT_COMMAND="
    fd --type f --hidden --follow --exclude .git
  "
}
_gen_fzf_default_opts

[ -f ~/.zfunctions/note.zsh          ] && source ~/.zfunctions/note.zsh
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ -f ~/.fzf.zsh                      ] && source ~/.fzf.zsh
[ -f ~/.rvm/scripts/rvm              ] && source ~/.rvm/scripts/rvm

eval "$(fasd --init auto)"
eval "$(pyenv init -)"

[ -f /Users/anthony.seure/.travis/travis.sh ]                                          && source /Users/anthony.seure/.travis/travis.sh
[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc ] && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ]       && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
