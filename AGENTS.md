# terraform-aws-ec2

One EC2 instance from an existing VPC, subnet, and security group. Do not add VPC, subnet, or security group resources.

## Interface

Root variables are the only caller inputs: `vpc_id`, `subnet_id`, `security_group_id`, `name`, `user_data`, `ami`, `instance_type`, `aws_region`.

`just use-config` copies `examples/ec2.tfvars.example` to gitignored `terraform.tfvars`. Terraform loads that file on `plan` and `apply`. Do not commit it.

`modules/ec2_networking_data` looks up those IDs and checks the subnet and security group belong to the VPC. `modules/ec2_instance` creates the instance from the looked-up IDs.

## Rules

- Never commit to `main`. Branch, then open a PR.
- Never commit secrets, `*.tfvars`, or `*.tfstate`.
- Terraform `>= 1.2`, AWS provider `>= 6.0`.
- Run `just fmt` before committing.
- `just plan` / `just apply` need AWS credentials. Offline checks are `just init` and `just validate`.
