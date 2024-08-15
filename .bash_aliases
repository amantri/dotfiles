alias ls="/bin/ls $LS_OPTIONS"
alias ll='ls -l'
alias lt='ls -ltr' # newest at the bottom
alias ltr='ls -lt' # oldest at the bottom
alias ld='ls -l | grep ^d'
alias less='less -imN'
alias grep='grep --color'
alias egrep='egrep --color'
alias hgrep='history | grep'

alias python='ipython'


#######################
# Some useful functions
#######################

# less the most recent file matching $1
# Usage: lessmr Ticket*
lessmr() { ls -t $@ | head -1 | xargs less -imNS; }

# cat the most recent file matching $1
# Usage: catmr Ticket*
catmr() { ls -t $@ | head -1 | xargs cat -n; }

# tail -f most recent file matching $1
# Usage: tailmr Ticket*
tailmr() { ls -t $@ | head -1 | xargs tail -f; }

# cd most recent dir matching $1
# Usage: cdmr *
cdmr() { cd $(ls -td ${@:-*} | head -1); }
