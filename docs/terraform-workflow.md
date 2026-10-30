# Terraform workflow

Commands run from the repository root. This module does not use `-chdir`.

## Prerequisites

- Terraform installed (`>= 1.2`; see `versions.tf`)
- AWS credentials on the standard AWS credential chain (environment variables, shared config/credentials files, or an instance/container role). `plan`, `apply`, `output`, and `destroy` need credentials for the account that owns the VPC, subnet, and security groups.

## terraform.tfvars

Copy the example to `terraform.tfvars`. That file is gitignored (`*.tfvars`). `just tfvars` does the same copy and refuses to overwrite an existing file.

```bash
cp examples/ec2.tfvars.example terraform.tfvars
```

Replace the placeholders. Required inputs with no default: `vpc_id`, `subnet_id`, `security_group_ids`, `ami`. Then pass `-var-file=terraform.tfvars` to plan and destroy.

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
terraform plan -var-file=terraform.tfvars -out plan
```

## terraform apply

```bash
terraform apply plan
```

A saved plan already includes the tfvars values, so apply does not take `-var-file`.

## terraform output

```bash
terraform output
```

## terraform destroy

```bash
terraform plan -destroy -var-file=terraform.tfvars -out destroy
```

```bash
terraform apply destroy
```

## just equivalents

| Step | just recipe |
|------|-------------|
| copy example tfvars | `tfvars` |
| `terraform init` | `tf-init` |
| `terraform fmt` | `tf-lint` |
| `terraform validate` | `tf-check` |
| `terraform plan` | `tf-plan` |
| `terraform apply` | `tf-apply` |
| `terraform output` | — |
| `terraform destroy` | `tf-destroy` |

`terraform output` has no just recipe. Extra arguments on `tf-init`, `tf-plan`, `tf-apply`, and `tf-destroy` are forwarded to Terraform (`*var` in the justfile), for example `just tf-plan -var-file=terraform.tfvars`.
