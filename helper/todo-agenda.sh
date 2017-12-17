#!/bin/bash

options=$@

## keywords we want to search for (grep-regexes)
todo_keywords='(todo|fixme)'

## dirs to include
dirs=" \
    $HOME/doc \
    $HOME/.vim \
    "

dirs+=`find $HOME/work -maxdepth 10 -type d -path "*doc/notes"`

dirfilter=" \
    *doc/notes
    "

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


agstring="$todo_keywords.*\n.*<<.*>>" 
find $dirs$exclude -type f -print0 \
    | xargs -0 ag $agstring  | sed 'N; s/\(.*:[0-9]*:\)\(.*\)\n.*<<\(.*\)>>/\1 \3: \2/' \
    | sort -b -k 2 -k 3 
