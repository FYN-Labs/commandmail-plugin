#!/bin/sh
# Build the ZIP for the OpenAI plugin portal from the portable package only.
# Claude Code and Gemini manifests stay in the repository but out of the upload.
# The portal keeps the package name of the plugin it first created; an update
# must repeat it (plugin_name_mismatch). The repository keeps "command-mail" for
# Codex and Claude installs, so the upload copy gets the portal's name.
set -eu

OPENAI_PLUGIN_NAME=${OPENAI_PLUGIN_NAME:-app-6abc17910330819187a8b3791d7912d6}

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
stage=$(mktemp -d)
cp -R plugin.json mcp.json skills assets LICENSE "$stage"/
python3 - "$stage/plugin.json" "$OPENAI_PLUGIN_NAME" <<'PY'
import json, sys
path, name = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as handle:
    manifest = json.load(handle)
manifest["name"] = name
with open(path, "w", encoding="utf-8") as handle:
    json.dump(manifest, handle, ensure_ascii=False, indent=2)
    handle.write("\n")
PY
(cd "$stage" && zip -X -r "$out" plugin.json mcp.json skills assets LICENSE -x '.*' '*/.*')
unzip -l "$out"
