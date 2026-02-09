module "vpc" {
    source = "../../modules/vpc"
    
    name           = "swe-project-${var.env}-vpc"
    cidr_block     = var.vpc.cidr_block
    azns            = var.vpc.azns
    public_subnets  = var.vpc.public_subnets
    private_subnets = var.vpc.private_subnets
}

module "alb" {
    source = "../../modules/alb"
    
    name              = "swe-project-${var.env}-alb"
    vpc_id            = module.vpc.vpc_id
    public_subnet_ids = module.vpc.public_subnet_ids
    container_port    = 3000
}

module "asg" {
    source = "../../modules/asg"
    
    name                 = "swe-project-${var.env}-asg"
    ami_id               = var.ec2.ami_id
    instance_type        = var.ec2.instance_type
    min_size             = var.ec2.min_size
    max_size             = var.ec2.max_size
    desired_capacity     = var.ec2.desired_capacity

    vpc_id               = module.vpc.vpc_id
    private_subnet_ids   = module.vpc.private_subnet_ids
    target_group_arn     = module.alb.target_group_arn

    container_port       = 3000
}