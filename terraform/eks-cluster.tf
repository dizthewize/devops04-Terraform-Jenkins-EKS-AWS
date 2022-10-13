module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.0"
  # insert the 17 required variables here
  cluster_name = "myeks-eks-cluster"
  cluster_version = "1.23"

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id = module.myapp-vpc.vpc_id

  # self-managed=EC2 | semi-managed=Node Group |
  # managed=Fargate profiles
  eks_managed_node_groups = {
    dev = {
      min_size = 1
      max_size = 3
      desired_size = 3

      instance_type = "t2.micro"
    }
  }

  # tags here are not required but helps with reference
  tags = {
    environment = "development"
    application = "myeks"
  }
}
