# .bash_profile executed at the time of login

# read .bashrc
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
