# EC2 Networking Data Module

This Terraform module fetches an existing AWS VPC, subnet, and security groups using data sources. It provides a toggle switch to conditionally enable or disable lookups, and fails when the subnet or a security group is not in `vpc_id`.

## Usage

### Basic Usage

```hcl
module "ec2_networking" {
  source = "./modules/ec2_networking_data"

  enabled            = true
  vpc_id             = "vpc-0123456789abcdef0"
  subnet_id          = "subnet-0123456789abcdef0"
  security_group_ids = ["sg-0123456789abcdef0", "sg-0123456789abcdef1"]
}
```

### Conditional Usage with EC2 Instance

```hcl
module "ec2_networking" {
  source = "./modules/ec2_networking_data"

  enabled            = var.networking_enabled
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  enabled            = var.instance_enabled
  name               = "ec2-dev-instance"
  ami                = var.ami
  instance_type      = "t3.micro"
  subnet_id          = module.ec2_networking.subnet_id
  security_group_ids = module.ec2_networking.security_group_ids
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2 |
| aws | >= 6.0 |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `enabled` | Enable or disable the data lookups | `bool` | `true` | No |
| `vpc_id` | ID of the existing VPC | `string` | `null` | No |
| `subnet_id` | ID of the existing subnet. Must belong to vpc_id | `string` | `null` | No |
| `security_group_ids` | IDs of existing security groups to fetch. Each must belong to vpc_id | `list(string)` | `[]` | No |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the fetched VPC |
| `subnet_id` | ID of the fetched subnet |
| `security_group_ids` | IDs of the fetched security groups |
| `enabled` | Whether the module is enabled |

## Notes

- When `enabled` is set to `false`, scalar outputs return `null` and `security_group_ids` returns `[]`
- The module uses `count` and `for_each` with conditions to avoid errors when lookups are disabled
- Each security group is fetched individually so the VPC membership postcondition runs for every ID
- This module does not create a VPC, subnet, or security group

## License

MIT
