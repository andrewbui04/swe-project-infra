variable "name" {
    description = "The name of the Auto Scaling Group"
    type        = string
}

variable "min_size" {
    description = "The minimum number of instances in the ASG"
    type        = number
}

variable "max_size" {
    description = "The maximum number of instances in the ASG"
    type        = number
}

variable "desired_capacity" {
    description = "The desired number of instances in the ASG"
    type        = number
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "private_subnet_ids" {
    description = "The IDs of the private subnets"
    type        = list(string)
}

variable "target_group_arn" {
    description = "The ARN of the ALB target group"
    type        = string
}

variable "instance_type" {
    description = "The EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "ami_id" {
    description = "The AMI ID for the instances"
    type        = string
}

variable "container_port" {
    description = "The port on which the container is listening"
    type        = number
}