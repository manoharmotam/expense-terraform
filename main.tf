resource "aws_instance" "expense" {
  for_each      = var.instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  vpc_security_group_ids = [
    aws_security_group.common.id,
    aws_security_group.expense[each.key].id
  ]

  tags = merge(var.common_tags, {
  Name = "${var.project}-${var.environment}-${each.key}" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "expense" {
  for_each = var.instances
  name     = "${var.project}-${var.environment}-${each.key}-sg"

  tags = merge(var.common_tags, {
  Name = "${var.project}-${var.environment}-${each.key}" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "common" {
  name = "common-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  tags = {
  Name = "common-sg" }

  lifecycle {
    create_before_destroy = true
  }
}