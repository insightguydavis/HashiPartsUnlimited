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
Enforce deployment in US and EU only

Admin
~~Admin VPC in each region~~
~~VPC in only 2 available AZs~~ w/Bastion Host
~~Subnet in each of the 2 AZs~~
~~VPC peering connect admin VPCs together and regional admin VPC to regional APP VPC~~
SSH open to internet

Sentinel
Require Manager approval for deployments over $100

Joe - Global VP Infrastructure
Uptime Goals and Budget
Visibility
Governance - thus region requirements
Cost - development environments
Deployment to insecure environments
Compliance via push button

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
* Show how to maintain Sentinal Policies
* Demonstrate the use of Sentinel Policies
* Demonstrate an application change and deployment in Development

## Documentation


