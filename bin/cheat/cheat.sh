#!/usr/bin/env bash
# taken from https://github.com/ThePrimeagen/.dotfiles/blob/858cdd66cf35a7d9eec7567bbf0c543b26bbf586/bin/.local/bin/tmux-cht.sh
languages_file=~/.dotfiles/bin/cheat/cheat-languages.txt
commands_file=~/.dotfiles/bin/cheat/cheat-commands.txt
selected=`cat $languages_file $commands_file | sort | uniq | fzf`
read -p "Enter Query: " query

query=`echo $query | tr ' ' '+'`

if grep -qs "$selected" $languages_file; then
    tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
