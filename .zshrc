autoload -U colors && colors

# General
setopt prompt_subst
setopt glob_dots
setopt extendedglob
unsetopt beep
bindkey -e

# Completion
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
autoload -Uz compinit
compinit

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

# Aliases
case `uname` in
  Darwin)
    alias ls='ls -FG'
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    ;;
esac
alias ll='ls -lh'
alias la='ls -al'
alias ccat='vimcat'
alias tree='tree -C'
alias sl='ls -l `find . -maxdepth 1 -type l`'
alias we='weechat-curses'
alias grep='grep --color'
alias soul='~/.jogsoul/jogsoul.pl ~/.jogsoul/jogsoul.conf'
alias resource='source ~/.zshrc'
alias tmu='tmux'
alias ta='tmux a'

# Promt
export PROMPT="%{$fg[blue]%}%n%{$reset_color%}%{$fg[green]%} :: %{$reset_color%}%{$fg[blue]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} %{$fg[blue]%}%#%{$reset_color%} "
