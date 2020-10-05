
variable "vpc_id" {}
variable "short_url_domain" {}

module "url_shortening_service" {
  source       = "./modules/url-shortening-service"
  alb_name     = "url-shortener-alb"
  alb_internal = false
  ecs_cluster  = module.ecs_cluster.ecs_cluster_id
  vpc_id       = var.vpc_id
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"
}

module "url_shortening_service_test" {
  source           = "./modules/url-shortening-service-test"
  short_url_domain = var.short_url_domain
}
