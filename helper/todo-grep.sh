#!/bin/bash

options=$@

echo $options

dirs=" \
    $HOME/home \
    $HOME/.vim \
    "

ex_absolute=" \
    $HOME/.vim/pack \
    $HOME/.vim/tmp \
    "

ex_regex="tmp"
todo_keywords="todo\|FIXME"


excl=""
for s in $ex_absolute; do
    excl="$excl -path $s -prune -o"
done

find $dirs$excl -type f -print0 | xargs -0 grep -n -i $options $todo_keywords 
 

