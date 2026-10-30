# terraform-aws-ec2

Terraform module stack that creates one EC2 instance from a VPC, subnet, and security groups that already exist. Look up the network, then create the resource. This module does not create a VPC, subnet, or security group.

## Table of Contents

- [Quickstart](#quickstart)
- [Configuration (Root Module)](#configuration-root-module)
- [When to Use](#when-to-use)
- [Modules Overview](#modules-overview)
- [Contributing](#contributing)

## Quickstart

> [!NOTE]
> This repo uses [mise](https://mise.jdx.dev) for the toolchain and [just](https://github.com/casey/just) for command shortcuts, but running the module only needs Terraform. See [docs/terraform-workflow.md](docs/terraform-workflow.md).

`mise.toml` pins tools and sets `auto_install = false`.

```bash
mise trust
mise install
```

1. Copy the example into gitignored `terraform.tfvars` and fill in the required IDs:

```bash
just tfvars
```

2. Run:

```bash
just init
just plan
# review plan
just apply
# later: just cleanup
```

`just plan` and `just apply` need AWS credentials. `just validate` does not.

### Minimal Example

```hcl
module "ec2_networking_data" {
  source = "./modules/ec2_networking_data"

  enabled            = true
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  enabled            = true
  name               = "ec2-dev-instance"
  ami                = var.ami
  instance_type      = "t3.micro"
  subnet_id          = module.ec2_networking_data.subnet_id
  security_group_ids = module.ec2_networking_data.security_group_ids

  root_block_device = {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options = {
    http_tokens = "required"
  }
}
```

See [`examples/ec2.tfvars.example`](examples/ec2.tfvars.example) for a full commented profile.

## Configuration (Root Module)

Key variables available in the root stack:

| Section | Variable | Description |
|---------|----------|-------------|
| **Global** | `aws_region` | AWS region for the provider (default `eu-central-1`) |
| **Global** | `prefix_name` | Prefix for resource names (default `dev`). Used as `ec2-<prefix>-instance` when `name` is unset |
| **Global** | `tags` | Extra tags merged with `Name` on the instance (default `{}`) |
| **Networking** | `networking_enabled` | Enable VPC/subnet/security group lookups (default `true`) |
| **Networking** | `vpc_id` | Existing VPC ID (`vpc-...`) |
| **Networking** | `subnet_id` | Existing subnet ID in that VPC (`subnet-...`) |
| **Networking** | `security_group_ids` | List of existing security group IDs (`sg-...`) |
| **Instance** | `instance_enabled` | Enable instance creation (default `true`) |
| **Instance** | `name` | Name tag override. Null uses `ec2-<prefix_name>-instance` |
| **Instance** | `ami` | AMI ID (`ami-...`). No default image |
| **Instance** | `instance_type` | Instance type (default `t3.micro`) |
| **Instance** | `key_name` | Existing key pair name. Null leaves SSH key unset |
| **Instance** | `associate_public_ip_address` | Associate a public IP. Null uses the subnet setting |
| **Instance** | `monitoring` | Detailed monitoring (default `false`) |
| **Instance** | `iam_instance_profile` | Name of an existing instance profile. This stack does not create the profile |
| **Instance** | `user_data` | User data script. Sensitive. Null leaves it unset |
| **Storage** | `root_block_device` | Root volume (`volume_size` default `30`, `volume_type` default `gp3`, `encrypted` default `true`) |
| **Metadata** | `metadata_options` | Instance metadata options (`http_tokens` default `required`) |

> [!TIP]
> For a full list of variables, see `variables.tf`.

## When to Use

- **Existing network**: Place one instance in a VPC, subnet, and security groups you already manage
- **Secure defaults**: Encrypted gp3 root volume and IMDSv2 (`http_tokens = required`) without extra configuration
- **Multi-environment**: Standalone deployments for `dev`, `staging`, or `production` via `prefix_name`
- **IaC governance**: Look up network IDs and fail when a subnet or security group is not in `vpc_id`

## Modules Overview

The stack is distributed across two core modules:

- **[ec2_networking_data](./modules/ec2_networking_data/README.md)**: Optional lookups for an existing VPC, subnet, and security groups, with postconditions that every ID belongs to the VPC.
- **[ec2_instance](./modules/ec2_instance/README.md)**: Provisioning of a single EC2 instance from those looked-up IDs.

## Contributing

Contributions are welcome. Please open an issue or submit a Pull Request following the standard repository workflow.

> [!NOTE]
> - **Development guide** — [`AGENTS.md`](./AGENTS.md) (conventions, workflow, command reference)
> - **Toolchain** — [`mise.toml`](./mise.toml) via [mise](https://mise.jdx.dev): `mise install`

## License

MIT
