# Terraform workflow

Commands below run from the repository root. This module does not use `-chdir`.

## Prerequisites

- Terraform installed (`>= 1.2`; see `versions.tf`)
- AWS credentials available through the standard AWS credential chain (environment variables, shared config/credentials files, or an instance/container role). `plan`, `apply`, `output`, and `destroy` need credentials for the account that owns the VPC, subnet, and security groups.

Copy [`examples/ec2.tfvars.example`](../examples/ec2.tfvars.example) and replace the placeholder IDs before you apply.

## terraform init

```bash
terraform init
```

## terraform fmt and terraform validate

```bash
terraform fmt -write=true -recursive
```

```bash
terraform validate
```

## terraform plan

```bash
terraform plan -var-file=examples/ec2.tfvars.example -out plan
```

## terraform apply

```bash
terraform apply plan
```

## terraform output

```bash
terraform output
```

## terraform destroy

```bash
terraform plan -destroy -var-file=examples/ec2.tfvars.example -out destroy
```

```bash
terraform apply destroy
```

## just equivalents

| Step | just recipe |
|------|-------------|
| `terraform init` | `tf-init` |
| `terraform fmt` | `tf-lint` |
| `terraform validate` | `tf-check` |
| `terraform plan` | `tf-plan` |
| `terraform apply` | `tf-apply` |
| `terraform output` | — |
| `terraform destroy` | `tf-destroy` |

`terraform output` has no just recipe. Extra arguments on `tf-init`, `tf-plan`, `tf-apply`, and `tf-destroy` are forwarded to Terraform (`*var` in the justfile), for example `just tf-plan -var-file=examples/ec2.tfvars.example`.
