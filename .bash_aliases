alias ls="/bin/ls $LS_OPTIONS"
alias ll='ls -l'
alias lt='ls -ltr' # newest at the bottom
alias ltr='ls -lt' # oldest at the bottom
alias ld='ls -l | grep ^d'
alias less='less -i -m'
alias grep='grep --color'
alias egrep='egrep --color'
alias hgrep='history | grep'

alias python='ipython'


#######################
# Some useful functions
#######################

# less the most recent file matching $1
# Usage: lessmr Ticket*
lessmr() { ls -t $@ | head -1 | xargs less -NS; }

# Tail most recent file
# Usage: tailmr Ticket*
tailmr() { ls -t $@ | head -1 | xargs tail -f; }
