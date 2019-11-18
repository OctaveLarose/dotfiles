
# Path to your oh-my-zsh installation.
export ZSH="/home/octavel/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# RANDOM
# ZSH_THEME="random" # to know which specific one was loaded, run: echo $RANDOM_THEME
# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


### COMPLETION FLAGS
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="false"
ENABLE_CORRECTION="true"


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
    cd $1 ; ls
}
alias ne="emacs -nw"
alias hibernate="sudo systemctl hibernate"
alias q="exit"
alias rm="gio trash"
alias weather-report="curl wttr.in/${CITY}" # v2.wttr.in/${CITY} for v2
alias please="sudo" # Politeness
alias psview="pscircle --output=/tmp/proc.png ; gwenview /tmp/proc.png"
alias dnf="sudo dnf"
