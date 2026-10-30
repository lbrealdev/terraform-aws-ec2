# terraform-aws-ec2 — Development Guide

## Project

Reusable Terraform module stack that creates one EC2 instance from an
existing VPC, subnet, and security groups:

- **Looked-up network** — VPC, subnet, and security group IDs are validated;
  this stack does not create those resources
- **Secure defaults** — encrypted gp3 root volume and IMDSv2 required

Root stack plus two modules: `ec2_networking_data`, `ec2_instance`.
Root variables are the only caller inputs. `iam_instance_profile` is the
name of an existing profile; do not create the profile.

## Workflow

Issue → Branch → Implement → PR → Review → Merge to main

## Conventions

### Branches & commits

| Prefix | Branch | Commit |
|--------|--------|--------|
| `feat` | `feat/imdsv2-defaults` | `feat(instance): require IMDSv2` |
| `fix` | `fix/sg-lookup` | `fix: validate every security group belongs to the VPC` |
| `docs` | `docs/quickstart` | `docs: document use-config` |
| `refactor` | `refactor/networking` | `refactor: count-gate networking lookups` |
| `chore` | — | `chore: bump provider version` |

### Rules

- Never commit to `main`
- Never force-push
- Never commit secrets, `*.tfvars`, or state files (`*.tfstate`)
- Use `git` for version control, `gh` for GitHub operations

### Code style

- Terraform `>= 1.2`, AWS provider `>= 6.0`
- Run `just fmt` before committing
- Networking is looked up, not created — assume VPC/subnet/SGs pre-exist
- Follow the patterns in the module you're editing

## Commands

```bash
mise trust         # trust mise.toml (once per machine)
mise install       # install the toolchain (mise.toml)
just use-config ec2  # scaffold gitignored terraform.tfvars
just init          # terraform init (providers + modules)
just validate      # validate configuration
just fmt           # format .tf files
just plan          # plan (needs AWS creds + existing network)
just apply         # apply
just cleanup       # remove local Terraform artifacts (prompts; does not destroy cloud resources)
```

## Cloud agent environments

Automated environments install the toolchain via `mise` (`mise.toml`). `plan`
and `apply` need real AWS credentials plus a pre-existing VPC, subnet, and
security groups — the provider validates credentials via STS even during
`plan` — so agents can only run the offline loop (`just init`, `just validate`,
`just fmt`) without AWS access.

Per-platform setup lives with its own config; Cursor Cloud is in
[`.cursor/rules/cloud-agent-environment.mdc`](.cursor/rules/cloud-agent-environment.mdc).
