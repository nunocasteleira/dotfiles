#!/bin/sh
[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions ] && git clone https://github.com/zsh-users/zsh-completions\
 ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
echo "installed zsh-completions"
