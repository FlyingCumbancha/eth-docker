#!/usr/bin/env bash

APP_NAME=$1
TIMEOUT=${2:-60}  # Default timeout is 60 seconds if not provided

# Give service a chance to start, and also to go into "Restarting" status
sleep "${TIMEOUT}"

STATUS=$(docker-compose ps --services --filter "status=running" | grep "${APP_NAME}")

if [ -n "$STATUS" ]; then
    echo "$APP_NAME is running."
    exit 0
fi

echo "$APP_NAME is either not started or restarting"
docker-compose ps | grep "${APP_NAME}"
exit 1
