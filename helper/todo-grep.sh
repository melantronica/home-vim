#!/bin/bash

options=$@

echo $options

## keywords we want to search for (grep-regexes)
todo_keywords="todo\|FIXME"

## dirs to include
dirs=" \
    $HOME/home \
    $HOME/.vim \
    "

dirs+=`find $HOME/work -maxdepth 10 -path "*doc/notes"`

## dirs to exclude
ex_dirs=" \
    $HOME/.vim/pack \
    $HOME/.vim/tmp \
    "
## files to exclude
ex_files="tmp tags cscope.out .git*"


## build options
exclude=""
for s in $ex_dirs; do
    exclude="$exclude -path $s -prune -o"
done

for s in $ex_files; do
    exclude="$exclude -name $s -prune -o"
done



find $dirs$exclude -type f -print0 | xargs -0 grep -n -i $options $todo_keywords
 

