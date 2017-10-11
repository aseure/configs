# ZSH loading
fpath=(
  ~/.zfunctions/pure
  $fpath
)
autoload -U compinit && compinit
autoload -U promptinit && promptinit
autoload -U select-word-style && select-word-style bash
autoload -U colors && colors

# ZSH completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# ZSH prompt (Pure)
PURE_CMD_MAX_EXEC_TIME=1
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL='$'
prompt pure

# ZSH History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.history

# General environment variables
export EDITOR="vim"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MANPAGER="most -s"
export PAGER="most"

# Path-related environment variables
export GCPPATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
export GOPATH="${HOME}/go"
export MSPATH="/opt/metasploit-framework/bin"
export OPENSSLPATH="/usr/local/opt/openssl/bin"
export PGPATH="/Library/PostgreSQL/9.6/bin"
export SCRIPTSPATH="${HOME}/.configs/scripts"
export ULBINPATH="/usr/local/bin"

# Define PATH environment variable
export PATH="${GCPPATH}:${GOPATH}/bin:${MSPATH}:${OPENSSLPATH}:${PGPATH}:${SCRIPTSPATH}:${ULBINPATH}:${PATH}"

# Aliases
case `uname` in
  Darwin)
    alias ls='ls -FG'
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    ;;
esac

alias kec='knife environment compare'
alias knl='knife node list'
alias kns='knife node show'
alias la='ls -al'
alias ll='ls -lh'
alias resource='source ~/.zshrc'
alias tree='tree -C'

# Misc

## Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
