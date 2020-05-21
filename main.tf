provider "aws" {
  region = "east-us-1"
  access_key = "AKIARRMB547SKGEGSACX"
  secret_key = "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"
}

provider "aws" {
  region     = "eu-central-1"
  alias      = "eu-central-1"
}

provider "aws" {
  region     = "us-west-1"
  alias      = "us-west-1"
}

# provider "aws" {
#   region     = "ap-east-1"
#   alias      = "ap-east-1"
#   access_key = "AKIARRMB547SKGEGSACX"
#   secret_key = "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"
# }

data "aws_availability_zones" "eu-azs" {
  provider = aws.eu-central-1
  state    = "available"
}

data "aws_availability_zones" "west-azs" {
  provider = aws.us-west-1
  state    = "available"
}

module "west-app-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "west-app-vpc"
  cidr = "10.0.0.0/16"

  # Grab entire set of names if needed from data source
  azs = data.aws_availability_zones.west-azs.names

  # Use cidrsubnet function with for_each to create the right number of subnets
  public_subnets = [for i, num in data.aws_availability_zones.west-azs.names : cidrsubnet("10.0.0.0/16", 8, 101+i)]

  providers = {
    aws = aws.us-west-1
  }
}

module "eu-app-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eu-app-vpc"
  cidr = "10.1.0.0/16"

  # Grab entire set of names if needed from data source
  azs = data.aws_availability_zones.eu-azs.names

  # Use cidrsubnet function with for_each to create the right number of subnets
  public_subnets = [for i, num in data.aws_availability_zones.eu-azs.names : cidrsubnet("10.1.0.0/16", 8, 101+i)]

  providers = {
    aws = aws.eu-central-1
  }
}

module "eu-admin-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eu-admin-vpc"
  cidr = "10.2.0.0/16"

  # Grab entire set of names if needed from data source
  azs = data.aws_availability_zones.eu-azs.names

  # Use cidrsubnet function with for_each to create the right number of subnets
  public_subnets = [for num in [0, 1]: cidrsubnet("10.2.0.0/16", 8, 110+num)]

  providers = {
    aws = aws.eu-central-1
  }
}

module "west-admin-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "west-admin-vpc"
  cidr = "10.3.0.0/16"

  # Grab entire set of names if needed from data source
  azs = data.aws_availability_zones.west-azs.names

  # Use cidrsubnet function with for_each to create the right number of subnets
  public_subnets = [for num in [0, 1]: cidrsubnet("10.3.0.0/16", 8, 130+num)]

  providers = {
    aws = aws.us-west-1
  }
}

resource "aws_vpc_peering_connection" "app-peer" {
  provider    = aws.us-west-1
  vpc_id      = module.west-app-vpc.vpc_id
  peer_vpc_id = module.eu-app-vpc.vpc_id
  peer_region = "eu-central-1"
  auto_accept = false
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "app-peer" {
  provider                  = aws.eu-central-1
  vpc_peering_connection_id = aws_vpc_peering_connection.app-peer.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection" "admin-peer" {
  provider    = aws.us-west-1
  vpc_id      = module.west-admin-vpc.vpc_id
  peer_vpc_id = module.eu-admin-vpc.vpc_id
  peer_region = "eu-central-1"
  auto_accept = false
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "admin-peer" {
  provider                  = aws.eu-central-1
  vpc_peering_connection_id = aws_vpc_peering_connection.admin-peer.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection" "west-admin-peer" {
  provider    = aws.us-west-1
  vpc_id      = module.west-admin-vpc.vpc_id
  peer_vpc_id = module.west-app-vpc.vpc_id
  peer_region = "us-west-1"
  auto_accept = false
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "west-admin-peer" {
  provider                  = aws.us-west-1
  vpc_peering_connection_id = aws_vpc_peering_connection.west-admin-peer.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection" "eu-admin-peer" {
  provider    = aws.eu-central-1
  vpc_id      = module.eu-admin-vpc.vpc_id
  peer_vpc_id = module.eu-app-vpc.vpc_id
  peer_region = "eu-central-1"
  auto_accept = false
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "eu-admin-peer" {
  provider                  = aws.eu-central-1
  vpc_peering_connection_id = aws_vpc_peering_connection.eu-admin-peer.id
  auto_accept               = true
}
