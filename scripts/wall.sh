#!/bin/sh
swaybg -i $(find ~/.wallpapers/. -type f | shuf -n1) -m fill &
OLD_PID=$!
while true; do
    sleep $((RANDOM % 301 + 300))
    swaybg -i $(find ~/.wallpapers/. -type f | shuf -n1) -m fill &
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done
