#!/usr/bin/env bash
# Instala todas las skills de skills.json (global). Requiere node y jq.
set -e
URL="https://raw.githubusercontent.com/LordTobar/orlando-skills/main/skills.json"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -f "$DIR/skills.json" ]; then JSON=$(cat "$DIR/skills.json"); else JSON=$(curl -fsSL "$URL"); fi
echo "$JSON" | jq -r '.[] | .source as $s | .skills[] | "\($s) \(.)"' | while read -r src skill; do
  echo ">> $src :: $skill"
  npx skills@latest add "$src" --skill "$skill" -g -y
done
