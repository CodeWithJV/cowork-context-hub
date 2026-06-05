# Cowork Context Hub — Reference Setup

This is a **reference repo**. Read this README to set up your own context hub folder — don't copy this repo wholesale. Your hub only needs a handful of files (listed below).

---

## What you're building

A local folder that gives both **Claude Code** (terminal) and **Cowork** (Claude desktop) access to GitHub, via a shared `.env` and a local `gh` binary in `./bin`.

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Tells Claude to source `load-env.sh` on every session start |
| `save-env.sh` | Reads your `gh` token from the host keyring and writes `.env` — run in Claude Code |
| `load-env.sh` | Sources `.env` to export `GH_TOKEN` and add `./bin` to `PATH` — run in Cowork |
| `bin/gh` | `gh` binary for Cowork's Linux sandbox (arm64), saved here to survive sandbox resets |
| `.env` | Generated, gitignored — contains your GitHub token, never committed |

---

## Setup

### Step 1 — Create your context hub folder

Make a new empty folder on your machine (e.g. `~/my-context-hub`). You'll open this in both Claude Code and Cowork.

Copy `CLAUDE.md`, `load-env.sh`, and `save-env.sh` from this repo into it.

### Step 2 — Open the folder in Claude Code

Open the folder in Claude Code. It will read `CLAUDE.md` and know to source `load-env.sh` each session.

### Step 3 — Install and authenticate `gh` in Claude Code

Ask Claude:

> "Install gh CLI and walk me through authenticating it"

Claude will install `gh` and guide you through `gh auth login` interactively (browser-based OAuth).

### Step 4 — Run `save-env.sh` in Claude Code

Once `gh` is authenticated:

```bash
./save-env.sh
```

This writes `.env` with your GitHub token and `./bin` on the PATH.

### Step 5 — Open the folder in Cowork

Open the Claude desktop app in Cowork mode and select your context hub folder.

Tell Claude:

> "Install gh and save it to the local bin file"

Claude will download the `gh` binary for the sandbox and save it to `./bin/gh`.

### Step 6 — Commit and push to a private repo

Tell Cowork:

> "Git init, add all files, commit, then create a private GitHub repo for this context hub and push to origin main"

### Step 7 — Test it

Open a **new** Cowork chat in your context hub folder and ask:

> "Run load-env.sh and then do a git pull"

If it succeeds, you're set up end-to-end.

---

## Daily use

**In Claude Code:** `CLAUDE.md` reminds Claude to source `load-env.sh` automatically.

**In Cowork:** At the start of each session tell Claude "run load-env.sh", or it picks it up from `CLAUDE.md`.

**Token rotation:** When your token expires, open Claude Code and re-run `./save-env.sh`.
