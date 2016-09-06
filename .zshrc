###############################################################################
#                                                                     General #
###############################################################################

setopt prompt_subst
setopt glob_dots
setopt extendedglob
unsetopt beep
bindkey -e

# Completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
autoload -Uz compinit && compinit

fpath=(/usr/local/share/zsh-completions $fpath)

# Stop `backward-kill-word` on directory delimiter
autoload -U select-word-style && select-word-style bash

# Colors
autoload -U colors && colors

# History
HISTSIZE=1000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=1000

setopt inc_append_history
setopt share_history

###############################################################################
#                                                                     Aliases #
###############################################################################

case `uname` in
  Darwin)
    alias ls='ls -FG'
    alias sed='gsed'
    alias strace='sudo dtruss'
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    ;;
esac

alias ccat='vimcat'
alias la='ls -al'
alias ll='ls -lh'
alias resource='source ~/.zshrc'
alias sl='ls -l `find . -maxdepth 1 -type l`'
alias ta='tmux a'
alias tmu='tmux'
alias tree='tree -C'
alias we='weechat-curses'

###############################################################################
#                                                       Environment variables #
###############################################################################

export GOPATH="$HOME/go"
export GEMPATH="$HOME/.rbenv/bin:$HOME/.gem/ruby/2.3.0/bin"
export SCRIPTSPATH="$HOME/.configs/scripts"
export PATH="$GEMPATH:$SCRIPTSPATH:$GOPATH/bin:$PATH"

export HOMEBREW_GITHUB_API_TOKEN="869e36494440c684507e6834b293806f8019e209"
export MANPAGER="most -s"
export PAGER="most"

###############################################################################
#                                                                  Completion #                                                                        #
###############################################################################

# Autocomplete hosts from ~/.ssh/{config,known_hosts}
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
#if [[ -r ~/.ssh/known_hosts ]]; then
  #h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
#fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  #zstyle ':completion:*:slogin:*' hosts $h
fi

###############################################################################
#                                                               Own functions #
###############################################################################

fpath=( ~/.configs/.zfuncs "${fpath[@]}" )
autoload -Uz prompt && prompt
