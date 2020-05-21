![Image of Parts Unlimited](parts-unlimited.jpg)

# HashiCorp Terraform CHIP - Parts Unlimited

## Drupal Application - Infrastructure Deployment With Terraform

### Notes

~~Primary Datacenter us-west-1~~
~~App Replica eu-central-1~~

APP
~~Single VPC in each of the two regions~~
~~VPC in all available Availability Zones~~
~~Subnet in each available AZ~~
~~VPC mesh between app VPCs~~
SSH NOT open externally
App accessible only via LB or API gateway which are open to internet
Drupal
~~Enforce deployment in US and EU only~~

Admin
~~Admin VPC in each region~~
~~VPC in only 2 available AZs~~ w/Bastion Host
~~Subnet in each of the 2 AZs~~
~~VPC peering connect admin VPCs together and regional admin VPC to regional APP VPC~~
SSH open to internet

Sentinel
Require Manager approval for deployments over $100

Joe - Global VP Infrastructure
* Uptime Goals and Budget
* Visibility
* Governance - thus region requirements
* **Control Cost** - development environments
* **Control deployment to insecure environments**
* **Compliance via push button**
* Wants demo

Bo - Security
Compliance app checklist
Drupal PCI compliant
Website cookie GDPR - No GDPR feature but Sentinel
Manager actions need to be logged permanently

Kim - System Admin
Manual deployment of Drupal application
Manual checklist of compliance
Cost Estimation
Use TF in DevOps way - No-one should know about TF

Docs - how TE supports goals cost estimation, monitoring options
Map how TF supports networking equipment providers (3000 switches and routers)

## Demonstration
* Show how Terraform Cloud/Enterprise is used to connect to Github and Perform DevOps actions automatically
* Show how to maintain Sentinel Policies
* Demonstrate the use of Sentinel Policies

## Documentation

### Infrastructure Deployment

1. Whenever possible reuse terraform modules which have already been created. These are located at the [Terraform Registry](https://registry.terraform.io/) where you can browse by provider. 
2. For Parts Unlimited create enterprise specifc modules for your workflows.

### Resources for Learning Terraform

1. Go through the exercises here: https://learn.hashicorp.com/terraform with your Cloud Provider of Choice
2. Get a Pluralsight subscription
  a. Go through the Terraform - Getting Started and Deep Dive - Terraform courses
3. When driving listen to Terraform youtubes at: https://www.youtube.com/channel/UC-AdvAxaagE9W2f0webyNUQ/search?query=terraform
4. The best book I have found for the technology is Manning's [Terraform in Action](https://www.manning.com/books/terraform-in-action). They frequently have sales on their products.
5. Review the official documenation at https://www.terraform.io/docs/index.html

### Resources for Learning Sentinel

1. Go through the web documentation for [Sentinel](https://www.terraform.io/docs/cloud/sentinel) located here [https://www.terraform.io/docs/cloud/sentinel](https://www.terraform.io/docs/cloud/sentinel)
