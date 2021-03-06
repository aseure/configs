fpath=(
  "$HOME/.zfunctions"
  "$HOME/.zfunctions/pure"
  "$HOME/.zsh"
  $fpath
)

autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U bashcompinit && bashcompinit
autoload -U promptinit && promptinit
autoload -U public
autoload -U note_file
autoload -U note_new
autoload -U note_search
autoload -U select-word-style && select-word-style bash
prompt pure

complete -C '/usr/local/bin/aws_completer' aws

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

export ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'
export EDITOR="vim"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
export GO111MODULE="on"
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
export MANPAGER="most -S"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PAGER="less -S"
export SAVEHIST=10000
export SDKMAN_DIR="$HOME/.sdkman"
export NOTES_DIR="$HOME/icloud/notes"

export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.configs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/terraform@0.13/bin:$PATH"
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

[ -f $NVM_DIR/nvm.sh                     ] && source $NVM_DIR/nvm.sh
[ -f /usr/local/share/zsh/site-functions ] && source /usr/local/share/zsh/site-functions
[ -f ~/.fzf.zsh                          ] && source ~/.fzf.zsh
[ -f ~/.iterm2_shell_integration.zsh     ] && source ~/.iterm2_shell_integration.zsh
[ -f ~/.rvm/scripts/rvm                  ] && source ~/.rvm/scripts/rvm
[ -f ~/.sdkman/bin/sdkman-init.sh        ] && source ~/.sdkman/bin/sdkman-init.sh

eval "$(fasd --init auto)"
