#!/bin/bash

# Get list of .typ files in current dir and subdirectories (1 level deep)
file_list=$(find . -maxdepth 2 -type f -name "*.typ" | sed 's|^\./||')

# Check if there are any .typ files
if [ -z "$file_list" ]; then
  echo "❌ No .typ files found in this folder or its subdirectories."
  exit 1
fi

# Add "Compile all" as first option
files=$(echo -e "[Compile all]\n$file_list")

# Let user pick one using fuzzy dropdown
selected=$(echo "$files" | gum filter --placeholder "Select a .typ file or 'Compile all'")

# If user cancels or input is empty
if [ -z "$selected" ]; then
  echo "❌ No file selected. Aborting."
  exit 1
fi

# Ensure output directory exists
mkdir -p pdfs

if [ "$selected" = "[Compile all]" ]; then
  echo "📦 Compiling all .typ files..."
  while IFS= read -r file; do
    filename=$(basename "$file" .typ)
    output="pdfs/${filename}.pdf"
    typst c "$file" "$output"
    echo "✅ $file → $output"
  done <<<"$file_list"
else
  # Single file case
  filename=$(basename "$selected" .typ)
  output="pdfs/${filename}.pdf"
  typst c "$selected" "$output"
  echo "✅ Compiled '$selected' → '$output'"
fi
