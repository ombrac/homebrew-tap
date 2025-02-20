#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
FORMULA_PATH="$REPO_ROOT/ombrac.rb"

echo "Fetching latest release from GitHub..."
LATEST_TAG=$(curl -s https://api.github.com/repos/ombrac/ombrac/releases/latest | grep -o '"tag_name": *"[^"]*"' | sed 's/"tag_name": *"//;s/"//g')

if [[ -z "$LATEST_TAG" ]]; then
  echo "Error: Could not fetch latest release tag."
  exit 1
fi

VERSION="${LATEST_TAG#v}"
echo "Latest version: $VERSION"

declare -A PLATFORMS_MAP=(
  ["x86_64-apple-darwin"]="x86_64-apple-darwin"
  ["aarch64-apple-darwin"]="aarch64-apple-darwin"
  ["x86_64-unknown-linux-gnu"]="x86_64-unknown-linux-gnu"
  ["aarch64-unknown-linux-gnu"]="aarch64-unknown-linux-gnu"
)

declare -A SHA256_MAP

for PLATFORM in "${!PLATFORMS_MAP[@]}"; do
  GITHUB_FORMAT="${PLATFORMS_MAP[$PLATFORM]}"
  GITHUB_FILENAME="ombrac-${GITHUB_FORMAT}.tar.gz"
  SUM_URL="https://github.com/ombrac/ombrac/releases/download/${LATEST_TAG}/${GITHUB_FILENAME}.sha256sum"
  
  echo "Downloading SHA256 checksum for $PLATFORM from $SUM_URL"
  SHA256_CONTENT=$(curl -s -L "$SUM_URL")
  
  if [[ -z "$SHA256_CONTENT" ]]; then
    echo "Error: Could not download SHA256 for $PLATFORM"
    exit 1
  fi

  SHA256=$(echo "$SHA256_CONTENT" | awk '{print $1}')
  
  if [[ -z "$SHA256" || ${#SHA256} -ne 64 ]]; then
    echo "Error: Invalid SHA256 format for $PLATFORM: $SHA256_CONTENT"
    exit 1
  fi
  
  echo "$PLATFORM: $SHA256"
  SHA256_MAP["$PLATFORM"]="$SHA256"
done

echo "Updating formula file..."
sed -i.bak -E "s/version \"[0-9]+\.[0-9]+\.[0-9]+\"/version \"$VERSION\"/" "$FORMULA_PATH"

for PLATFORM in "${!SHA256_MAP[@]}"; do
  SHA256="${SHA256_MAP[$PLATFORM]}"
  sed -i.bak -E "s/when \"$PLATFORM\" then \"[a-f0-9]+\"/when \"$PLATFORM\" then \"$SHA256\"/" "$FORMULA_PATH"
done

rm "${FORMULA_PATH}.bak"

if ! grep -q "version \"$VERSION\"" "$FORMULA_PATH"; then
  echo "Error: Failed to update version in formula file."
  exit 1
fi

for PLATFORM in "${!SHA256_MAP[@]}"; do
  SHA256="${SHA256_MAP[$PLATFORM]}"
  if ! grep -q "when \"$PLATFORM\" then \"$SHA256\"" "$FORMULA_PATH"; then
    echo "Error: Failed to update SHA256 for $PLATFORM in formula file."
    exit 1
  fi
done

echo "Formula updated successfully to version $VERSION."
