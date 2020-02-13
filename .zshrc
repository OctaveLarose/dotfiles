HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

export ZSH="/home/octavel/.oh-my-zsh"

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


### UTILITIES

# Auto-setting terminal title
DISABLE_AUTO_TITLE="false"

# To disable marking untracked files under VCS as dirty. Much faster for large repositories
DISABLE_UNTRACKED_FILES_DIRTY="false"

# history format : "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or man strftime
HIST_STAMPS="dd/mm/yyyy"

# To set another custom folder than $ZSH/custom
# ZSH_CUSTOM=/path/to/new-custom-folder


### PLUGINS

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh


### ALIASES
readfile() {
    cat $@ | less
}

cs() {
    cd $1 && ls
}

reb () {
    # lastcmd=$( tail -2 ~/.zsh_history | head -1 | egrep -o ';.*$' | cut -c2- )
    lastcmd=$(fc -nl | tail -1)
    args=$(echo $lastcmd | egrep -o ' .*$')
    args="${args:1}"
    $@ $args
}

alias ne="emacs -nw"
alias hibernate="sudo systemctl hibernate"
alias q="exit"
alias rm="gio trash"
alias weather-report="curl wttr.in/$CITY" # v2.wttr.in/${CITY} for v2
alias please="sudo" # Politeness
alias psview="pscircle --output=/tmp/proc.png ; gwenview -f /tmp/proc.png"
alias dnf="sudo dnf"
alias re="cd .."
alias duc="du -sh * | sort -h"
