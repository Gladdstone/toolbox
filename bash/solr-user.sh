#!/bin/bash
# format credentials for solr's security.json
# with basic authentication
PW=$1
SALT=$2
echo "hash    : $(echo -n "$SALT$PW" | sha256sum -b | xxd -r -p | sha256sum -b | xxd -r -p | base64 -w 1024) $(echo -n "$SALT" | base64 -w1024)"

