# url-shortening-service

This is a Docker-based solution that uses Terraform to quickly setup a URL shortening service. 

Users should be able to supply the service with a URL and receive a unique, shortened, shareable URL as a response. When this new URL is visited it should forward the user to the original page.

It should be able to support a large user base expecting low-latency responses, from anywhere around the planet.


The folder hierarchy is following the format modules/microservices so that it can be incorporated into other existing microservices.


### prod.tf
The solution is split into two modules that are instantiated by `prod.tf`.
If the ECS cluster already exists, its ARN must be provided (usually in `terraform.tfvars` file), which will be passed to the ECS service and tasks.


## Approach

For this module we are instantiating the services components at `prod.tf`. I decided to split the services into 3 modules:
 - It can be instantiated multiple times
 - ECS service module can be reused in other services
 - ECS task module can be reused in other services


## Prerequisites

#### software
* Terraform v0.12.28+

#### deployment

Setup Hosted Zones in Route 53 accordingly for the domain that is going to host the url shortening service.


## Deploy
Initialize the backend. Ideally we would be using a private S3 bucket to store the state. E.g:
```
$ terraform init -backend-config "bucket=<your_terraform_state_bucket>"
```

Use terraform to apply the infrastructure change needed to run this url-shortener-service:

```
$ terraform apply
```

# Obs

The whole solution would involve many more components, such as route53 domain and hosted zones, the caching system (Redis) resource, the creation of KMS encryption  
