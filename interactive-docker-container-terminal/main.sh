#!/usr/bin/env bash

set -euo pipefail

if docker ps >/dev/null 2>&1; then
  container=$(docker ps | awk '{if (NR!=1) print $1 ": " $(NF)}' | fzf --height 40%)
  
  if [[ -n $container ]]; then
    container_id=$(echo "$container" | awk -F ': ' '{print $1}')
    
    docker exec -it "$container_id" /bin/bash // docker exec -it "$container_id" /bin/sh
  else
    echo "You haven't selected any container"
  fi
else
  echo "Docker daemon is not running. Try sudo systemctl status docker to check the daemon"
fi