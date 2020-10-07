# url-shortening-service

This is a Docker-based solution that uses Terraform to quickly setup some of the resources to host a URL shortening service. 

Users will be able to supply the service with a URL and receive a unique, shortened, shareable URL as a response. When this new URL is visited it should forward the user to the original page.

## Overview:
This solution provides essential components for the URL-shortening-service project:
* **Application Load Balancer** and it related components
* The core **ECS service** that the tasks are going to run on
* **ECS task** for the **database** application (Redis) and its related components

I decided to split the services into 3 modules because:
 - It can be instantiated multiple times (e.g: replication in different regions)
 - ECS service module can be reused in other services
 - ECS task module can be reused in other services

The folder hierarchy follows the format `modules/<microservice_name>` so that it can be incorporated into other existing modules.

The ECS service lies behind an internet-facing Application Load Balancer configured to receive requests from the public and distribute it to our ECS service.
The ECS service is composed of two decoupled tasks that can be independently scaled up/down  _(being the database the only one covered in this project)_:
* container running Django serving as front-end
* container running Redis service as a distributed, in-memory key–value database

The whole solution would involve many more components, such as route53 domain and hosted zones, ACM certificates (for the ALB) for a more secure transmission (HTTPS), IAM role permission for AutoScaling on ECS, the creation of KMS keys for encrypted data transmission in and out of Redis, creation of extra security group for the database layer, etc.

## Prerequisites

### Software prerequisites
* Terraform v0.12.28+

### Deployment prerequisites

* Setup Domain and Hosted Zones in Route 53 accordingly for the domain that is going to host the url shortening service.

* You must authenticate with AWS. This can be done in different forms. I would suggest:
	*  [`aws-vault`](https://github.com/99designs/aws-vault) with MFA enabled for login using IAM roles; or
	*  exporting `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to environment variables.

_We are setting up an ECS cluster, ECS service and an ECS task with a docker image for `redis:6.0.8` which I have pushed to my own public repo. The full deployment would require docker credentials to be passed to ECS (this can be achieved in many ways), which I am not covering in this project._

* Initialize the backend. Ideally we would be using a private S3 bucket to store the state. E.g:
```
$ terraform init -backend-config "bucket=<your_terraform_state_bucket>"
```

## Deploy

### Module instantiation

#### `prod.tf`
The following modules will be instantiated by `prod.tf`:

* `module "ecs_cluster"`
* `module "url_shortening_service"`

Each of those modules will call resources/sub-modules to deploy a new ECS cluster, ECS service, ECS task, Application Load Balancer, and its related components.

Use terraform to apply the infrastructure change needed deploy run this project:

```
$ terraform apply
```

You'll be prompted for the following variables (which can be provided previously in a `terraform.tfvars` file in the root dir):

* `region`: AWS Region to deploy the solution
* `short_url_domain`: The DNS domain registered for the URL shortening service. 
* `vpc_id`: Where resources will be assigned to.
* `existing_ecs_cluster` (Optional): If an ECS cluster already exists, its ARN must be provided. If not, a new cluster will be created.
* `public_subnets`: For the application load balancer

### Observations

**Terraform v0.13.0 beta program** now supports `count` and `for_each` for modules. It will enable `ecs_cluster`module creation to be optional [hashicorp/terraform #25016](https://github.com/hashicorp/terraform/issues/25016).
As an alternative, use `terraform import module.ecs_cluster.aws_ecs_cluster.production <cluster_name>` to import the existing cluster to this project.