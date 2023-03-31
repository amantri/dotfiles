# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/amantri/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/amantri/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/amantri/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/amantri/.fzf/shell/key-bindings.zsh"
