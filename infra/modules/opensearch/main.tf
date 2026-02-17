resource "aws_security_group" "os" {
  name   = "${var.name}-opensearch-sg"
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_security_group_rule" "ingress_https_from_vpc" {
  type              = "ingress"
  security_group_id = aws_security_group.os.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.allowed_cidr]
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.os.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

locals {
  # Sanitize domain name to meet AWS requirements:
  # - Must start with lowercase letter
  # - Can only contain a-z, 0-9, and hyphens
  # - Must be 3-28 characters total
  domain_name = lower(substr("${var.name}-logs", 0, 28))
}

resource "aws_opensearch_domain" "this" {
  domain_name    = local.domain_name
  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type          = "t3.medium.search"
    instance_count         = 2
    zone_awareness_enabled = true
    zone_awareness_config {
      availability_zone_count = 2
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp3"
    volume_size = 50
  }

  vpc_options {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.os.id]
  }

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.account_id}:root"
      }
      Action   = "es:*"
      Resource = "arn:aws:es:*:${var.account_id}:domain/${local.domain_name}/*"
    }]
  })

  tags = var.tags
}

output "endpoint" {
  value       = aws_opensearch_domain.this.endpoint
  description = "OpenSearch domain endpoint"
}

output "domain_name" {
  value       = aws_opensearch_domain.this.domain_name
  description = "OpenSearch domain name"
}
