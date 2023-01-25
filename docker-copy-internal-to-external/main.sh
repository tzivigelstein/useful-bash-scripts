#!/usr/bin/env bash

set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Error: 2 arguments are required."
  exit 1
else
    if docker ps >/dev/null 2>&1; then
    	container=$(docker ps | awk '{if (NR!=1) print $1 ": " $(NF)}' | fzf --height 40%)

    	if [[ -n $container ]]; then
    		container_id=$(echo "$container" | awk -F ': ' '{print $1}')

    		sudo docker cp $container_id:$1 $2
    	else
    		echo "You haven't selected any container"
    	fi
    else
    	echo "Docker daemon is not running"
    fi
fi