#!/usr/bin/env bash
# taken from https://github.com/ThePrimeagen/.dotfiles/blob/858cdd66cf35a7d9eec7567bbf0c543b26bbf586/bin/.local/bin/tmux-cht.sh
selected=`cat cheat-languages.txt cheat-commands.txt | sort | uniq | fzf`
read -p "Enter Query: " query

if grep -qs "$selected" cheat-languages.txt; then
    query=`echo $query | tr ' ' '+'`
    echo "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    echo "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
