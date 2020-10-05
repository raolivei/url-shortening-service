module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  # count  = var.existing_ecs_cluster != null ? 0 : 1  # Terraform v0.13.0 beta program #25016 supports `count` and `for_each` for modules, enabling it to be optional.
}

module "url_shortening_service" {
  source       = "./modules/url-shortening-service"
  alb_name     = "url-shortening-alb"
  alb_internal = false
  ecs_cluster  = var.existing_ecs_cluster != null ? var.existing_ecs_cluster : module.ecs_cluster.ecs_cluster_id
  vpc_id       = var.vpc_id
}

module "url_shortening_service_test" {
  source           = "./modules/url-shortening-service-test"
  short_url_domain = var.short_url_domain
}
