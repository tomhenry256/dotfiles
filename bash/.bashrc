#!/bin/bash

# split config directory path
bash_files=~/dotfiles/bash

# include files
. $bash_files/function.bash
. $bash_files/alias.bash
. $bash_files/export.bash
. $bash_files/prompt.bash

# include local file
# attention ! need exec once following command
# $ source ~/.bashrc_local
if [ -e "~/.bashrc_local" ]; then
  source "~/.bashrc_local"
fi
