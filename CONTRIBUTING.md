# Contributing

## First-time setup

```bash
git clone git@github.com:AurelienLgd/Project.git
cd Project
pip install pre-commit
pre-commit install          # runs gitleaks and other checks on every commit
```

Use SSH keys or a fine-grained personal access token, and enable two-factor
authentication on your GitHub account.

## Workflow

1. Create a branch from `main` (`feat/...`, `fix/...`, `docs/...`).
   Direct commits to `main` are blocked locally by pre-commit and on GitHub
   by branch protection.
2. Use [Conventional Commits](https://www.conventionalcommits.org/) for messages.
3. Open a pull request. It needs a green CI and the owner's review before merging.

## Secrets and data

Read [SECURITY.md](SECURITY.md) before your first commit. In short:

- never commit a password, token or key: use `lab/.env`, Ansible Vault or
  GitHub Actions secrets;
- for the lab, run `./scripts/generate-lab-env.sh` instead of typing passwords;
- use synthetic data only;
- if you leak a secret, rotate it first and tell the owner straight away.

## Local checks

```bash
pre-commit run --all-files
```
