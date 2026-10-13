#!/usr/bin/env bash
# Create lab/.env from lab/.env.example, replacing every "change-me"
# placeholder with a random secret. The file is gitignored and mode 600.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
template="$repo_root/lab/.env.example"
target="$repo_root/lab/.env"

if [[ -e "$target" && "${1:-}" != "--force" ]]; then
  echo "lab/.env already exists; rerun with --force to regenerate it." >&2
  exit 1
fi

umask 077
tmp="$(mktemp "$target.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ "$line" == *=change-me ]]; then
    printf '%s=%s\n' "${line%%=*}" "$(openssl rand -base64 33 | tr -d '/+=' | cut -c1-32)"
  else
    printf '%s\n' "$line"
  fi
done < "$template" > "$tmp"

mv "$tmp" "$target"
trap - EXIT
echo "Wrote lab/.env with fresh random secrets (mode 600)."
