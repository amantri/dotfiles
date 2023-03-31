#!/bin/zsh

# WARNING - run this only once. Rerunning this might replace your files with symlinks


SOURCE="/Users/amantri"
DEST="/Users/amantri/gDrive/code/dotfiles_mac"

for file in .bash_aliases .bash_profile .bashrc .fzf.bash .fzf.zsh .gitconfig .vimrc .zprofile .zshrc
do
  echo; echo $file
  mv $SOURCE/$file $DEST/$file
  ln -nfs $DEST/$file  $SOURCE/$file
done

