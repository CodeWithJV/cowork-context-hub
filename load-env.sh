#!/usr/bin/env bash
# Source this file to export the vars from .env into the current shell:
#   source ./load-env.sh
#
# Inside a container you can also pass the file directly:
#   docker run --env-file .env ...

_env_file="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)/.env"

if [[ ! -f "$_env_file" ]]; then
  echo "error: $_env_file not found — run ./save-env.sh first" >&2
  return 1 2>/dev/null || exit 1
fi

set -a
# shellcheck disable=SC1090
source "$_env_file"
set +a

echo "loaded GH_TOKEN / GITHUB_TOKEN from $_env_file"
