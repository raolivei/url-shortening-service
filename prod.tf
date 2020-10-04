# module "url_shortening_service" {
#   source           = "./modules/url-shortening-service"
#   short_url_domain = "raolivei.net"
# }

module "prod_ecs_cluster" {
  source = "./modules/ecs_cluster"
}

module "url_shortening_service_test" {
  source           = "./modules/url-shortening-service-test"
  short_url_domain = "raolivei.net"
  alb_internal     = false
}
