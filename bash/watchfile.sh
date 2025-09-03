#!/bin/sh

file=$1
cmd=$2

start_time=$(echo stat -c $file)
while [ true ]; do
    if [ "$start_time" -ne "$(stat -c %Y $file)" ]; then
        source $cmd
        break
    fi
done;

