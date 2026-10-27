# terraform-aws-ec2

Terraform stack that creates one EC2 instance from network that already exists.
Same shape as [terraform-aws-rds](https://github.com/lbrealdev/terraform-aws-rds): look up the network, then create the resource. This module does not create a VPC, subnet, or security group.

## Interface

| Variable | Required | Purpose |
|----------|----------|---------|
| `vpc_id` | yes | Existing VPC (`vpc-...`) |
| `subnet_id` | yes | Existing subnet in that VPC (`subnet-...`) |
| `security_group_id` | yes | Existing security group in that VPC (`sg-...`) |
| `name` | yes | `Name` tag of the instance |
| `user_data` | no | User data script. Sensitive. Omit to leave it unset |
| `ami` | yes | AMI ID (`ami-...`). No default image |
| `instance_type` | no | Defaults to `t3.micro` |
| `aws_region` | no | Defaults to `eu-central-1` |

## Commands

```bash
mise install
just use-config
# edit terraform.tfvars with the VPC, subnet, security group, AMI, and name
just init
just validate
just plan
just apply
```

`just use-config` copies `examples/ec2.tfvars.example` to `terraform.tfvars`. That file is gitignored. Terraform loads it automatically. `just plan` and `just apply` need AWS credentials for the account that owns those IDs. `just validate` does not.

## Layout

| Path | Purpose |
|------|---------|
| `examples/ec2.tfvars.example` | Committed placeholder values |
| `terraform.tfvars` | Local values, created by `just use-config`, not committed |
| `modules/ec2_networking_data` | Reads the VPC, subnet, and security group. Fails if the subnet or security group is not in `vpc_id` |
| `modules/ec2_instance` | Creates `aws_instance` |
