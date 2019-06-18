# split config directory path
zsh_files=~/dotfiles/zsh

# include files
if [ -e "$zsh_files/etc.zsh" ]; then
    . $zsh_files/etc.zsh
fi
if [ -e "$zsh_files/export.zsh" ]; then
    . $zsh_files/export.zsh
fi
if [ -e "$zsh_files/function.zsh" ]; then
    . $zsh_files/function.zsh
fi
if [ -e "$zsh_files/alias.zsh" ]; then
    . $zsh_files/alias.zsh
fi
if [ -e "$zsh_files/prompt.zsh" ]; then
    . $zsh_files/prompt.zsh
fi

# include local file
# attention ! need exec once following command
# $ source ~/.zshrc_local
if [ -e "~/.zshrc_local" ]; then
  source "~/.zshrc_local"
fi
