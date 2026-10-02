#!/bin/sh
# Build the ZIP for the OpenAI plugin portal from the portable package only.
# Claude Code and Gemini manifests stay in the repository but out of the upload.
set -eu

if [ "$#" -ne 1 ]; then
  echo "usage: $0 /path/to/commandmail-plugin.zip" >&2
  exit 2
fi
case "$1" in
  /*) out=$1 ;;
  *) out=$(pwd)/$1 ;;
esac
if [ -e "$out" ]; then
  echo "refusing to overwrite $out" >&2
  exit 1
fi

cd "$(dirname "$0")/.."
mkdir -p "$(dirname "$out")"
zip -X -r "$out" plugin.json mcp.json skills assets LICENSE -x '.*' '*/.*'
unzip -l "$out"
