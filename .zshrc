fpath=(
  "$HOME/.zfunctions/pure"
  "$HOME/.zsh"
  $fpath
)

autoload -U bashcompinit && bashcompinit
autoload -U colors && colors
autoload -U compinit compdef && compinit
autoload -U promptinit && promptinit
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
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word
bindkey -e

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.configs/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.krew/bin:$PATH"
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="/Applications/IntelliJ\ IDEA.app/Contents/jbr/Contents/Home/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/curl)/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt)/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm)/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

export BAT_THEME="Nord"
export BUILDKIT_PROGRESS="plain"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"
export EDITOR="vim"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1 --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1 --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
export GOPATH="$HOME/go"
export GPG_TTY=$(tty)
export HISTFILE="$HOME/.history"
export HISTFILESIZE="10000"
export HISTSIZE="10000"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export MANPAGER="most -S"
export MANPATH="/opt/hombrew/opt/coreutils/libexec/gnuman:$MANPATH"
export NVM_DIR="$HOME/.nvm"
export PAGER="less -S"
export SAVEHIST="10000"
export ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'

alias gui='gitui'
alias k='kubectl'
alias la='ls -al'
alias ll='ls -lh'
alias ls='ls -F --color=auto'
alias rg='rg --smart-case --no-line-number'
alias tok='tokei'

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

eval "$(zoxide init --cmd j zsh)"
#eval "$(kubectl completion zsh)"
#source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
#source "/opt/homebrew/opt/nvm/nvm.sh"
#source "$HOME/.cargo/env"
source "$HOME/.cloudflare.zsh"
source "$HOME/.fzf.zsh"
