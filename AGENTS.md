# terraform-aws-ec2

Creates one EC2 instance in an existing VPC, subnet, and security groups. Do not create those resources or an IAM instance profile. Callers set root variables only.

## Toolchain

`mise.toml` pins versions and sets `auto_install = false`.

```bash
mise trust
mise install
```

## Before push

```bash
just fmt
just init
just tf-check
```

AWS credentials for the account that owns the VPC, subnet, and security groups (for example, `aws configure` or `AWS_PROFILE`).

Do not run `just tf-docs`. It overwrites `README.md`. Edit README and module READMEs by hand.

## Conventions

Never commit to `main`. Never force-push. Never commit secrets, `*.tfvars`, or `*.tfstate`.

Use conventional prefixes: `feat`, `fix`, `docs`, `refactor`, `chore`.

`just tfvars` copies `examples/ec2.tfvars.example` to gitignored `terraform.tfvars`. Required inputs with no default: `vpc_id`, `subnet_id`, `security_group_ids`, `ami`.
