#!/bin/bash

target='.'
image_name=""
detached=false

while getopts "dn:t:" opt; do
  case $opt in
    d)
      detached=true
      ;;
    n)
      name=$OPTARG
      ;;
    t)
      target=$OPTARG
      ;;
    *)
      exit 1
      ;;
  esac
done

docker build -t $image_name $target && docker images -q $image_name

if [ detached ]; then
  docker run -d $image_name
else
  docker run $image_name
fi

