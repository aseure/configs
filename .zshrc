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
export PAGER="less -S"
export SAVEHIST=10000
export NOTES_DIR="$HOME/icloud/notes"
export BAT_THEME="Nord"
export PROJECT_HOME="$HOME/kmtx"

export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.configs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

alias bat='bat --pager="less" --wrap=never'
alias tok='tokei'
alias j='fasd_cd -d'
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -FG'
alias k='kubectl'
alias rg="rg --smart-case --no-line-number"
alias gui='gitui'

function source_if_exists () {
  [ -f "$1" ] && source "$1"
}

source_if_exists /usr/local/share/zsh/site-functions
source_if_exists ~/.fzf.zsh
source_if_exists ~/.iterm2_shell_integration.zsh
source_if_exists ~/.cargo/env

_fzf_complete_git() {
  ARGS="$@"
  if [[ $ARGS == 'git cp'*          || \
        $ARGS == 'git cherry-pick'* || \
        $ARGS == 'git co'*          || \
        $ARGS == 'git checkout'*    || \
        $ARGS == 'git show'*        || \
        $ARGS == 'git diff'*        || \
        $ARGS == 'git ds'*          || \
        $ARGS == 'git reset'* ]]; then
    _fzf_complete "--reverse --multi" "$@" < <(
      git log \
        --graph \
        --all \
        --abbrev-commit \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
  )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

_fzf_complete_git_post() {
  sed -e 's/^[^a-z0-9]*//' | awk '{print $1}'
}

eval "$(fasd --init auto)"
eval "$(kubectl completion zsh)"
