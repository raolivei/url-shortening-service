module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  # count  = var.existing_ecs_cluster != null ? 0 : 1  # hashicorp/terraform #25016: v0.13.0 beta program now supports `count` and `for_each` for modules.
}

module "url_shortening_service" {
  source          = "./modules/url-shortening-service"
  region          = var.region
  environment     = var.environment
  name            = "url-shortening"
  front_end_image = ""
  redis_image     = ""
  db_image        = "longshin/postgres:13.0"
  alb_internal    = false
  ecs_cluster     = var.existing_ecs_cluster != null ? var.existing_ecs_cluster : module.ecs_cluster.ecs_cluster_id
  vpc_id          = var.vpc_id
  alb_subnets     = var.public_subnets
}

module "url_shortening_service_test" {
  source           = "./modules/url-shortening-service-test"
  short_url_domain = var.short_url_domain
}

