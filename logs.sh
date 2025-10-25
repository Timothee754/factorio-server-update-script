#!/bin/bash

current_dir=$(pwd)
LOG_FILE="factorio_logs.json"
full_path="${current_dir}/$LOG_FILE"

declare -A log_levels=( [FATAL]=0 [ERROR]=3 [WARNING]=4 [INFO]=6 [DEBUG]=7)

json_logger() {
  log_level=$1
  message=$2
  level=${log_levels[$log_level]}
  timestamp=$(date --iso-8601=seconds)

  jq -n \
    --arg msg "$message" \
    '{
      level: '$level',
      timestamp: "'$timestamp'",
      message: $msg
    }' >> "$full_path"
}
