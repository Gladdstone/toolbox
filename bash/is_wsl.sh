#!/bin/bash
# snippet to check if the current session is wsl
# or not

function check_wsl() {
  if grep -qi microsoft /proc/version > /dev/null 2>&1; then
    echo "true"
  fi

  echo "false"
}

if [[ "$(check_wsl)" == "false" ]]; then
  echo "not wsl"
fi

