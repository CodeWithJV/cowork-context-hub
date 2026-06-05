#!/usr/bin/env bash
set -euo pipefail

# Pulls the current gh auth token from the host keyring and writes it to .env.
# Run this on the host (outside the container) whenever the token rotates.

cd "$(dirname "$0")"

if ! command -v gh >/dev/null 2>&1; then
  echo "error: gh CLI not found on PATH" >&2
  exit 1
fi

TOKEN="$(gh auth token)"
if [[ -z "$TOKEN" ]]; then
  echo "error: gh auth token returned empty — run 'gh auth login' first" >&2
  exit 1
fi

umask 077
cat > .env <<ENVEOF
GH_TOKEN=$TOKEN
GITHUB_TOKEN=$TOKEN
PATH=$(pwd)/bin:$PATH
ENVEOF

echo "wrote .env (GH_TOKEN, GITHUB_TOKEN, PATH)"
