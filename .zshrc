fpath=(
  "$HOME/.zfunctions"
  "$HOME/.zfunctions/pure"
  "$HOME/.zsh"
  $fpath
)

autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U promptinit && promptinit
autoload -U public
autoload -U note_file
autoload -U note_new
autoload -U note_search
autoload -U select-word-style && select-word-style bash
prompt pure

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:match:*' original only
zstyle ':prompt:pure:git:dirty' color 'blue'

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^[^?" backward-kill-word
bindkey "^[b" backward-word
bindkey "^[f" forward-word

export EDITOR="vim"
export FZF_DEFAULT_COMMAND='fd --type f'
export GOPATH="$HOME/go"
export GPG_TTY=$(tty)
export HISTFILE="$HOME/.history"
export HISTFILESIZE=10000
export HISTSIZE=10000
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export MANPAGER="less -r"
export PAGER="less -r"
export SAVEHIST=10000
export NOTES_DIR="$HOME/icloud/notes"

export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"

alias bat='bat --pager="less" --wrap=never'
alias j='fasd_cd -d'
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -FG'
alias rg="rg --smart-case --no-line-number"
alias n="note_new"
alias ns="note_search"
alias nf="note_search"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fasd --init auto)"
eval "$(gh completion -s zsh)"
