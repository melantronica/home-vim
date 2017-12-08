#!/bin/bash

options=$@


options=$@
#grep -Pzo "abc(.|\n)*efg" /tmp/tes*
#grep -Pzl "abc(.|\n)*efg" /tmp/tes*
## keywords we want to search for (grep-regexes)
todo_keywords="(todo|FIXME)(.|\\n)*<<.*>>"
#todo_keywords="<<.*>>"

## dirs to include
dirs=" \
    $HOME/home \
    $HOME/.vim \
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


#grep -Pzl '(?s)abc.*\n.*efg' <your list of files>


find $dirs$exclude -type f -print0 | xargs -0 grep -Pzoi $options $todo_keywords |xargs echo foo  





#~/.vim/helper/todo-grep.sh -A 1 | grep \<\< | sort -t\< -k2,2n -k3 | while read -r x;do
#    foo=$(echo "$x" | cut -d '-' -f 2)
##    echo $foo
##    echo $(($foo - 1))
#    ~/.vim/helper/todo-grep.sh -A 1 | grep -B 1 \<\< | grep -B 1 "\-$foo\-"
#    echo "--"
#done


