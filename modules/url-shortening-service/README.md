# url-shortening-service

This is a Docker-based solution that uses Terraform to quickly setup a URL shortening service. 
Using a custom domain with AWS API Gateway, CloudFront, Lambda, Route 53 and S3.

Users should be able to supply the service with a URL and receive a unique, shortened, shareable URL as a response. When this new URL is visited it should forward the user to the original page.

It should be able to support a large user base expecting low-latency responses, from anywhere around the planet.

