# Cowork Context Hub

A reference setup that gives both **Claude Code** (terminal) and **Cowork** (Claude desktop) access to GitHub via a shared `.env` and a local `gh` binary in `./bin`.

## How it works

- `save-env.sh` — run in Claude Code; reads your authenticated `gh` token from the host keyring and writes `.env`
- `load-env.sh` — run in Cowork at the start of each session; sources `.env` to export `GH_TOKEN` and add `./bin` to `PATH`
- `bin/gh` — the `gh` binary installed by Cowork, persisted here so it survives sandbox resets

---

## First-time setup

### Step 1 — Open the folder in Claude Code

Clone or create this folder locally and open it in Claude Code.

Claude Code will read `CLAUDE.md` and know to source `load-env.sh` each session.

### Step 2 — Install and authenticate `gh` in Claude Code

In the Claude Code terminal, ask Claude:

> "Install gh CLI and walk me through authenticating it"

Claude will run the install and guide you through `gh auth login` interactively (browser-based OAuth).

### Step 3 — Run `save-env.sh` in Claude Code

Once `gh` is authenticated:

```bash
./save-env.sh
```

This writes `.env` with your token and the `./bin` path. The `.env` file is gitignored — it stays local only.

### Step 4 — Open the folder in Cowork

Open the Claude desktop app in Cowork mode and select this folder.

Tell Claude:

> "Install gh and save it to the local bin file"

Claude will download the `gh` binary for the sandbox architecture and save it to `./bin/gh`. This file is committed to the repo so it persists.

### Step 5 — Git init and initial commit

Tell Cowork:

> "Git init, add all files, and make an initial commit"

### Step 6 — Create the GitHub repo and push

Tell Cowork:

> "Create a private GitHub repo for this context hub and push to origin main"

Claude will use `gh repo create` with your loaded token to create the repo and push.

### Step 7 — Test it

Open a **new** Cowork chat in this project folder and ask:

> "Run load-env.sh and then do a git pull"

If it succeeds, your setup is working end-to-end.

---

## Daily use

**In Claude Code:** `CLAUDE.md` reminds Claude to source `load-env.sh` automatically.

**In Cowork:** At the start of each session, tell Claude:

> "Run load-env.sh"

Or Claude will do it automatically when it reads `CLAUDE.md`.

**Token rotation:** GitHub tokens expire periodically. When they do, open Claude Code and re-run:

```bash
./save-env.sh
```

---

## Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Instructs Claude (Code + Cowork) to load env on session start |
| `README.md` | This setup guide |
| `save-env.sh` | Writes `.env` from `gh auth token` — run in Claude Code |
| `load-env.sh` | Sources `.env` — run in Cowork each session |
| `bin/gh` | `gh` binary for Cowork's Linux sandbox (arm64) |
| `.env` | Generated, gitignored — contains your GitHub token |
