data "aws_caller_identity" "current" {}

locals {
  tags = merge(var.tags, {
    Project = var.name
  })
}

module "network" {
  source = "./modules/network"
  name   = var.name
  tags   = local.tags
}

module "eks" {
  source             = "./modules/eks"
  name               = var.name
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids
  tags               = local.tags
}

module "ecr" {
  source = "./modules/ecr"
  name   = var.name
  tags   = local.tags
}

module "opensearch" {
  source             = "./modules/opensearch"
  name               = var.name
  vpc_id             = module.network.vpc_id
  private_subnet_ids = slice(module.network.private_subnet_ids, 0, 2)
  allowed_cidr       = module.network.vpc_cidr
  account_id         = data.aws_caller_identity.current.account_id
  tags               = local.tags
}

module "alerts" {
  source          = "./modules/alerts"
  name            = var.name
  opensearch_name = module.opensearch.domain_name
  account_id      = data.aws_caller_identity.current.account_id
  tags            = local.tags
}
