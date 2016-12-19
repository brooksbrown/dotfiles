#!/bin/bash

current="$(date +%l)";

log_file="$HOME/.mybin/.logs/chime.sh.log"
log_path=$(dirname "${log_file}")

if [ ! -d "$log_path" ]; then
  mkdir -p "$log_path"
  touch $log_file
fi

MSG="Brooks, it's $current o'clock" 
/usr/bin/notify-send "$MSG"
espeak "$MSG" > $log_file 2>&1
