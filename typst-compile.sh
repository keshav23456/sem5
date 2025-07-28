#!/bin/bash

# Get list of .typ files in current dir and its subdirectories (1 level deep)
files=$(find . -maxdepth 2 -type f -name "*.typ" | sed 's|^\./||')

# Check if there are any .typ files
if [ -z "$files" ]; then
  echo "❌ No .typ files found in this folder or its subdirectories."
  exit 1
fi

# Let user pick one using fuzzy dropdown
selected=$(echo "$files" | gum filter --placeholder "Select a .typ file to compile")

# If user cancels or input is empty
if [ -z "$selected" ]; then
  echo "❌ No file selected. Aborting."
  exit 1
fi

# Get filename without extension
filename=$(basename "$selected" .typ)

# Output path
output="pdfs/${filename}.pdf"

# Ensure output directory exists
mkdir -p pdfs

# Compile using typst
typst c "$selected" "$output"

# Notify
echo "✅ Compiled '$selected' → '$output'"
