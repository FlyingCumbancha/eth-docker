#!/usr/bin/env bash

__service=$1

__containerID=$(docker-compose ps -q "${__service}")

__restart_count=$(docker inspect --format '{{ .RestartCount }}' "$__containerID")
__running=$(docker inspect --format '{{ .State.Running }}' "$__containerID")

if [ "$__running" != "true" ] || [ "$__restart_count" -gt 0 ]; then
  echo "$__service is either not running or continuously restarting"
  docker-compose ps "${__service}"
  docker-compose logs "${__service}"
  exit 1
else
  echo "$__service is running"
  docker-compose ps "${__service}"
  exit 0
fi
