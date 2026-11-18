#!/usr/bin/env bash
# Bygger mappen _site slik den skal ligge på hanshaugen.com.
# frontpage/ blir roten. smerteklinikkenoslo/ blir /smerteklinikkenoslo/.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dest="$root/_site"
clinic_repo="https://github.com/hanshaugen/smerteklinikkenoslo.git"
src="$root/smerteklinikkenoslo"

rm -rf "$dest"
mkdir -p "$dest"

cp -a "$root/frontpage/." "$dest/"

if [[ ! -f "$src/index.html" ]]; then
  echo "Henter $clinic_repo"
  if [[ -n "${CLINIC_TOKEN:-}" ]]; then
    git clone --depth 1 --branch main "https://x-access-token:${CLINIC_TOKEN}@github.com/hanshaugen/smerteklinikkenoslo.git" "$src"
  else
    git clone --depth 1 --branch main "$clinic_repo" "$src"
  fi
fi

mkdir -p "$dest/smerteklinikkenoslo"
while IFS= read -r -d '' file; do
  rel="${file#"$src"/}"
  case "$rel" in
    .git/*|.github/*|README.md|.gitignore) continue ;;
  esac
  mkdir -p "$dest/smerteklinikkenoslo/$(dirname "$rel")"
  cp -a "$file" "$dest/smerteklinikkenoslo/$rel"
done < <(find "$src" -type f \
  ! -path "$src/.git/*" \
  ! -path "$src/.github/*" \
  ! -name 'README.md' \
  ! -name '.gitignore' \
  -print0)

printf '%s\n' 'hanshaugen.com' > "$dest/CNAME"
touch "$dest/.nojekyll"
echo "Ferdig: $dest"
