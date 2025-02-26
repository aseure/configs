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

export ASDF_DATA_DIR="$HOME/.asdf"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
export PATH="$HOME/anthony/configs/scripts:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/Applications/IntelliJ\ IDEA.app/Contents/jbr/Contents/Home/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
export PATH="$HOME/work/sonio-utils/scripts:$PATH"

export BAT_THEME="Nord"
export BUILDKIT_PROGRESS="plain"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="
    --color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
"
export GOPATH="$HOME/go"
export GPG_TTY=$(tty)
export HISTFILE="$HOME/.history"
export HISTFILESIZE="10000"
export HISTSIZE="10000"
export HOMEBREW_NO_ENV_HINTS='1'
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
alias vim='nvim'

_fzf_complete_git() {
  ARGS="$@"
  if [[ $ARGS == 'git cp'*          || \
        $ARGS == 'git cherry-pick'* || \
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
  elif [[ $ARGS == 'git co'* || \
          $ARGS == 'git checkout'* || \
          $ARGS == 'git br'* || \
          $ARGS == 'git branch'* ]]; then

    _fzf_complete "--reverse --multi" "$@" < <(
    git branch
  )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

_fzf_complete_git_post() {
  sed -e 's/^[^a-z0-9]*//' | awk '{print $1}'
}

eval "$(zoxide init --cmd j zsh)"

source /opt/homebrew/etc/profile.d/bash_completion.sh
source <(fzf --zsh)

ulimit -Sn 4096
