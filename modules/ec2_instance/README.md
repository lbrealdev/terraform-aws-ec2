# EC2 Instance Module

This Terraform module creates a single AWS EC2 instance with configurable networking, storage, and metadata settings.

## Usage

### Basic Usage

```hcl
module "ec2_instance" {
  source = "./modules/ec2_instance"

  enabled            = true
  name               = "ec2-dev-instance"
  ami                = "ami-0123456789abcdef0"
  instance_type      = "t3.micro"
  subnet_id          = "subnet-0123456789abcdef0"
  security_group_ids = ["sg-0123456789abcdef0"]
}
```

### Encrypted Root Volume and IMDSv2

```hcl
module "ec2_instance" {
  source = "./modules/ec2_instance"

  enabled            = true
  name               = "ec2-dev-instance"
  ami                = "ami-0123456789abcdef0"
  instance_type      = "t3.micro"
  subnet_id          = "subnet-0123456789abcdef0"
  security_group_ids = ["sg-0123456789abcdef0"]

  root_block_device = {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options = {
    http_tokens = "required"
  }

  monitoring                  = false
  associate_public_ip_address = false

  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

### Usage with Networking Data Module

```hcl
module "ec2_networking" {
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
  subnet_id          = module.ec2_networking.subnet_id
  security_group_ids = module.ec2_networking.security_group_ids
  iam_instance_profile = var.iam_instance_profile
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2 |
| aws | >= 6.0 |

## Variables

### Required Variables

| Name | Description | Type |
|------|-------------|------|
| `enabled` | Enable or disable the EC2 instance creation | `bool` |
| `name` | Name tag of the EC2 instance | `string` |
| `ami` | AMI ID for the instance | `string` |
| `instance_type` | EC2 instance type | `string` |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `subnet_id` | Subnet ID from the networking data module | `string` | `null` |
| `security_group_ids` | Security group IDs from the networking data module | `list(string)` | `[]` |
| `user_data` | User data script. Null leaves user data unset | `string` | `null` |
| `iam_instance_profile` | Name of an existing IAM instance profile. This module does not create the profile | `string` | `null` |
| `key_name` | Name of an existing EC2 key pair | `string` | `null` |
| `associate_public_ip_address` | Associate a public IP. Null uses the subnet setting | `bool` | `null` |
| `monitoring` | Enable detailed monitoring | `bool` | `false` |
| `root_block_device` | Root EBS volume settings (`volume_size` 30 GiB, `volume_type` gp3, `encrypted` true) | `object` | `{}` |
| `metadata_options` | Instance metadata options (`http_tokens` required) | `object` | `{}` |
| `tags` | A map of tags to add to all resources. Merged with `Name` | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | ID of the EC2 instance |
| `arn` | ARN of the EC2 instance |
| `private_ip` | Private IP of the EC2 instance |
| `public_ip` | Public IP of the EC2 instance, if assigned |
| `private_dns` | Private DNS name of the EC2 instance |
| `public_dns` | Public DNS name of the EC2 instance, if assigned |
| `availability_zone` | Availability zone of the EC2 instance |

## Notes

- **Enabled Toggle:** Set `enabled = false` to skip creating the instance. Outputs return `null`.
- **Security:** `user_data` is marked sensitive. Root volume encryption defaults to `true`. IMDSv2 is required by default (`http_tokens = required`).
- **Public IP:** `associate_public_ip_address` defaults to `null`, which follows the subnet `MapPublicIpOnLaunch` setting. Set `false` to deny a public IP.
- **Key pair:** `key_name` defaults to `null`. The instance can still be reached with SSM when an instance profile allows it.
- **IAM:** Pass the name of an existing instance profile. This module does not create IAM resources.
- **Tags:** Caller tags are merged with `Name = var.name`.

## License

MIT
