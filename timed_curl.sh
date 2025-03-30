#!/bin/bash
#
# perform a timed ping on a url every x seconds. Default 5.
#

url=$1
sleep_timer=${2:-1}

while true; do
  curl -s $url

  sleep $sleep_timer
done

