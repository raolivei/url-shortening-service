module "url_shortening_service" {
  source       = "./modules/url-shortening-service"
  alb_name     = "url-shortening-alb"
  alb_internal = false
  ecs_cluster  = module.ecs_cluster.ecs_cluster_id != null ? module.ecs_cluster.ecs_cluster_id : var.ecs_cluster
  vpc_id       = var.vpc_id
}

module "ecs_cluster" {
  source                   = "./modules/ecs_cluster"
  existing_ecs_cluster_arn = null
}

module "url_shortening_service_test" {
  source           = "./modules/url-shortening-service-test"
  short_url_domain = var.short_url_domain
}
