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

# Aliases
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -al'
alias tree='tree -C'
alias sl='ls -l `find . -maxdepth 1 -type l`'
alias we='weechat-curses'
alias grep='grep --color'
alias soul='~/.jogsoul/jogsoul.pl ~/.jogsoul/jogsoul.conf'
alias resource='source ~/.zshrc'
alias tmu='tmux'
alias ta='tmux a'

# Exports
export PAGER='most'
export EDITOR='vim'

# Prompt
export PROMPT="%{$fg[blue]%}%n%{$reset_color%}%{$fg[green]%} :: %{$reset_color%}%{$fg[blue]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%} %{$fg[blue]%}%#%{$reset_color%} "
