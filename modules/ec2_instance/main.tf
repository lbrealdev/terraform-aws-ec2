resource "aws_instance" "this" {
  count = var.enabled ? 1 : 0

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.monitoring

  root_block_device {
    volume_size = var.root_block_device.volume_size
    volume_type = var.root_block_device.volume_type
    encrypted   = var.root_block_device.encrypted
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}
