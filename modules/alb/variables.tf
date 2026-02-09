variable "name" {
    description = "The name of the Application Load Balancer"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "public_subnet_ids" {
    description = "The IDs of the public subnets"
    type        = list(string)
}

variable "container_port" {
    description = "The port on which the container is listening"
    type        = number
}