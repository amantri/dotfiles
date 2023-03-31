# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source the given file it is accessible.
function source_if_accessible() {
  [ -r $1 ] && source $1
}

# Source global definitions
source_if_accessible /etc/bashrc

export PS1="${debian_chroot:+($debian_chroot)}\[\e[32m\]\u@\h:\[\e[1;34m\]\w\[\e[0;35m\] \[\e[0;1m\]\$\[\e[0m\] "
if echo $TERM | egrep -iq 'xterm|vt100'; then
  # Display the path in the title
  export  PS1='\[\033]0;\w\007\]'$PS1

  # Display the command in the title in parentheses
  trap 'echo -ne "\033]0;(${BASH_COMMAND})\007" > /dev/stderr' DEBUG
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
