#!/bin/zsh

# WARNING - run this only once. Rerunning this might replace your files with symlinks,
# though you can recover from the git history.

# Assuming that the script is being from the `dotfiles` directory.
SOURCE=$HOME
DEST=$PWD

for file in .bash_aliases .bash_profile .bashrc .fzf.bash .fzf.zsh .gitconfig .tmux.conf .vimrc .zprofile .zshrc
do
  echo; echo $file
  mv $SOURCE/$file $DEST/$file
  ln -nfs $DEST/$file  $SOURCE/$file
done

echo To import gh aliases, run:
echo $ gh alias import gh_aliases.yaml
echo
echo On Macs: to set the correct key bindings for Home, End, etc.:
echo $ ln -nfs $PWD/DefaultKeyBinding.dict ~/Library/KeyBindings/
