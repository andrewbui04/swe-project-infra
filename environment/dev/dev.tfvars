env = "dev"

vpc = {
    cidr_block     = "10.0.0.0/16"
    azns           = ["ap-southeast-1a", "ap-southeast-1b"] 
    public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
}

ec2 = {
    instance_type = "t3.small"
    desired_capacity = 1
    min_size = 1
    max_size = 2
}