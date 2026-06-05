# Context Hub

This folder is a shared context hub used by both Claude Code and Cowork (Claude desktop).

## Every new session

Run this at the start of every session to load environment variables (GitHub token, PATH):

```bash
source ./load-env.sh
```

This sets `GH_TOKEN`, `GITHUB_TOKEN`, and adds `./bin` to your PATH so the local `gh` binary is available.

If `.env` is missing or stale, run `./save-env.sh` first (requires `gh` to be installed and authenticated on the host).
