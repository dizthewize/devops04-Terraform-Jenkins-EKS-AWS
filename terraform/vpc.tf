provider "aws" {
  region = "us-west-1"
}

# Dynamically gets the AZs for the region which is defined in provider
data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = data.aws_availability_zones.azs.names

  # allows resources across different vpcs to privately
  # talk to each other
  enable_nat_gateway = true
  # creates shared common nat gateway for all private subnets
  single_nat_gateway = true
  # assigns public and private dns names of ec2 instances
  enable_dns_hostnames = true

  # helps K8s cloud controller manager detect and identify resources that
  # belong to this cluster
  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }

  # subnet tags are also used in the way to help vpc identify subnets and
  # between private and public
  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    # sets up cloud native elb on AWS for external load balancer
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
