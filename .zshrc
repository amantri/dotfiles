# For profiling zsh startup times, set _profile_zshrc=true
_profile_zshrc=false
if $_profile_zshrc
then
  zmodload zsh/zprof
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source the given file it is accessible.
function source_if_accessible() {
  [ -r $1 ] && source $1
}

# Platform specific customizations
case "$OSTYPE" in
  darwin*)  # Mac (OSX)
    export LS_OPTIONS='--color=auto -h'
    #export LS_OPTIONS='-G -h'

    # https://stackoverflow.com/questions/10435117/ps1-env-variable-does-not-work-on-mac
    #alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

    ;;

  linux*)
    export LS_OPTIONS='--color=auto -h'

    ;;
esac

# Prompt
source_if_accessible /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
setopt PROMPT_SUBST; PROMPT='%B%F{blue}%~%f%b$(__git_ps1 " (%s)") %# '

# Autocompletions
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# For tab completions, show unambiguous prefix and the menu immediately after the first tab. The
# default behavior of zsh is to show the menu on the second tab.
setopt no_list_ambiguous

# Alias definitions
# All aliases are defined in a separate file: ~/.bash_aliases.
source_if_accessible ~/.bash_aliases

export PAGER="less -i -m"

# Returns the symlinked path for the current directory, if one is available.
#
# I have a number of convenient symlinks in my home dir that are useful for
# shortening the paths in the prompts. However, when starting a new shell, bash
# resolves the realpath of the directory. cd-ing into the symlinked dir
# re-shortens the path in the prompt.
function sub_symlink() {
  local dir=$(echo $PWD | sed -f <(ls -l $HOME | grep "^l" | sed -e "s|.* \(.*\) -> \(.*\)|s#$HOME/\2#$HOME/\1#|"))

  echo $dir
}
eval cd $(sub_symlink)

# History control: see `man zsh` and `man zshoptions`
export HISTSIZE=1000000 
export SAVEHIST=1000000
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY  # write to hist file immediately rather than waiting for shell to exit
setopt HIST_IGNORE_DUPS    # Do not enter command lines into the history list if they are duplicates of the previous event.

# fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add more directories to PATH
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin:/opt/homebrew/opt/postgresql@15/bin

# Key bindings
bindkey '\e[H'    beginning-of-line  # Home key
bindkey '\e[F'    end-of-line        # End key

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#############
# Work config

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# TODO: remove this from here
conda activate morphai

#############

if $_profile_zshrc
then
  zprof
fi

# Clean up the local vars and functions
unset _profile_zshrc
unfunction source_if_accessible sub_symlink
