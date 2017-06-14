###############################################################################
#                                                                     General #
###############################################################################

source ~/.bashenv

HISTSIZE=1000000
HISTFILESIZE=1000000

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

for f in /usr/local/etc/bash_completion.d/*; do
  . $f
done

###############################################################################
#                                                                      Colors #
###############################################################################

c_reset="\[\e[0m\]"
c_red="\[\e[31m\]"
c_green="\[\e[32m\]"
c_yellow="\[\e[33m\]"
c_blue="\[\e[34m\]"

###############################################################################
#                                                                   Functions #
###############################################################################

function alg_app() {
  url="https://www.algolia.com/api/internal/1/applications/$1"
  curl -s -H "Authorization: Basic ${ALGOLIA_WEB_API_TOKEN}" "${url}" | jq .
}

function alg_cluster() {
  url="https://www.algolia.com/api/internal/1/applications?cluster=$1&fields=application_id"
  curl -s -H "Authorization: Basic ${ALGOLIA_WEB_API_TOKEN}" "${url}" | jq -r '.[].application_id' | sort
}

function prompt() {
  main_color=${c_green}
  reset_color=${c_blue}

  # Regular prompt
  time_prompt="${main_color}\t${reset_color}"
  host_prompt="${main_color}\h${reset_color}"
  path_prompt="${main_color}\w${reset_color}"

  # Git prompt
  git_prompt_ref=`git symbolic-ref HEAD 2> /dev/null`
  if [[ ${git_prompt_ref} != "" ]]; then
    git_prompt_branch=`echo ${git_prompt_ref} | cut -d'/' -f3,4`
    git diff-files --quiet
    if [[ $? == 0 ]]; then
      git_untracked_files=`git ls-files --others --exclude-standard`
      if [[ ${git_untracked_files} != "" ]]; then
        git_prompt_color=${c_yellow}
      else
        git_prompt_color=${c_green}
      fi
    else
      git_prompt_color=${c_red}
    fi

    git_prompt="${git_prompt_color}(${git_prompt_branch})${reset_color}"
  else
    unset git_prompt
  fi

  export PS1="${reset_color}:: ${time_prompt} :: ${host_prompt} :: ${path_prompt} ${git_prompt}\n:: ${c_reset}"
}

###############################################################################
#                                                       Environment variables #
###############################################################################

export GOPATH="${HOME}/go"
export JOURNAL_PATH="${HOME}/Google Drive/journal/"
export MANPAGER="most -s"
export PAGER="most"
export PATH="${GOPATH}/bin:/usr/local/bin:${PATH}"
export PROMPT_COMMAND=prompt

###############################################################################
#                                                                     Aliases #
###############################################################################

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
alias ta='tmux a'
alias tmu='tmux'
alias tree='tree -C'
