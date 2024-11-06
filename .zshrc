HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
#ZSH_THEME="random" # to know which specific one was loaded, run: echo $RANDOM_THEME


### COMPLETION FLAGS
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="false"
ENABLE_CORRECTION="false"


### AUTO UPDATE
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=15


### Dot extension code I stole from SO. Idea is to support TAB suggestions when using the mutli-dot "..." = "../.." type aliases 
function expand-dots() {
    local MATCH
    if [[ $LBUFFER =~ '\.\.\.+' ]]; then
        LBUFFER=$LBUFFER:fs%\.\.\.%../..%
    fi
}

function expand-dots-then-expand-or-complete() {
    zle expand-dots
    zle expand-or-complete
}

#function expand-dots-then-accept-line() {
#    zle expand-dots
#    zle accept-line
#}

zle -N expand-dots
zle -N expand-dots-then-expand-or-complete
#zle -N expand-dots-then-accept-line
bindkey '^I' expand-dots-then-expand-or-complete
#bindkey '^M' expand-dots-then-accept-line

### UTILITIES

# Auto-setting terminal title
DISABLE_AUTO_TITLE="false"

# To disable marking untracked files under VCS as dirty. Much faster for large repositories
DISABLE_UNTRACKED_FILES_DIRTY="false"

# history format : "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or man strftime
HIST_STAMPS="dd/mm/yyyy"

# To set another custom folder than $ZSH/custom
# ZSH_CUSTOM=/path/to/new-custom-folder

# Changing the sudo password prompt to a rofi generated window
# export SUDO_ASKPASS="$HOME/bin/askpass-rofi"
# alias sudo="sudo -A"

# less(1) syntax highlighting 
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s" 
export LESS=' -R '

### PLUGINS

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions colored-man-pages)

source $ZSH/oh-my-zsh.sh


### ALIASES

cs() {
    cd $1 && ls
}

reb () {
    # lastcmd=$( tail -2 ~/.zsh_history | head -1 | egrep -o ';.*$' | cut -c2- )
    lastcmd=$(fc -nl | tail -1)
   
    if [ $(echo $lastcmd | wc -w) != "1" ]
    then
        args=$(echo $lastcmd | egrep -o ' .*$')
        args="${args:1}"
    else
        args=$lastcmd
    fi

    $@ $args
}

commit() {
    git commit -m "$*"
}

function gb() {
  current=$(git rev-parse --abbrev-ref HEAD)
  branches=$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
  for branch in $branches; do
    desc=$(git config branch.$branch.description)
    if [ $branch == $current ]; then
      branch="* \033[0;32m$branch\033[0m"
     else
       branch="  $branch"
     fi
     echo -e "$branch \033[0;36m$desc\033[0m"
  done
}

alias hibernate="sudo systemctl hibernate"
alias rm="gio trash"
alias rmf="/bin/rm"
alias weather-report="curl wttr.in/$CITY" # v2.wttr.in/${CITY} for v2
alias please="sudo" # Politeness
alias psview="pscircle --output=/tmp/proc.png ; gwenview -f /tmp/proc.png"
alias duc="du -sh * | sort -h"
alias duca="du -sh * .* | sort -h"
alias push="git push"

#eval $(thefuck --alias)

eval "$(pyenv init -)"

[ -f "/home/octavel/.ghcup/env" ] && source "/home/octavel/.ghcup/env" # ghcup-env

eval "$(atuin init --disable-up-arrow zsh)"
eval "$(zoxide init zsh)"
