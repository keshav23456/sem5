#!/bin/bash

PID_FILE=".tinymist.pid"

# Function to stop existing preview process
stop_existing_preview() {
  if [ -f "$PID_FILE" ]; then
    if kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo "🛑 Stopping existing tinymist preview..."
      kill "$(cat "$PID_FILE")"
    fi
    rm -f "$PID_FILE"
  fi
}

# Find .typ files (max 1 level deep)
file_list=$(find . -maxdepth 2 -type f -name "*.typ" | sed 's|^\./||')

# Check if any found
if [ -z "$file_list" ]; then
  echo "❌ No .typ files found in this folder or its subdirectories."
  exit 1
fi

# Add "Stop preview" as an option
files=$(echo -e "[Stop preview]\n$file_list")

# Let user pick
selected=$(echo "$files" | gum filter --placeholder "Select a .typ file to preview or stop")

# If user cancels or input is empty
if [ -z "$selected" ]; then
  echo "❌ No selection made. Aborting."
  exit 1
fi

if [ "$selected" = "[Stop preview]" ]; then
  stop_existing_preview
  echo "✅ Preview stopped."
  exit 0
fi

# Stop any existing preview
stop_existing_preview

# Start selected preview in background
echo "🔍 Starting preview for $selected..."
nohup tinymist preview "$selected" --invert-colors=auto >/dev/null 2>&1 &
echo $! >"$PID_FILE"
echo "✅ Preview started in background for $selected"
