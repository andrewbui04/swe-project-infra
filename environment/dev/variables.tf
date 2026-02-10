variable "env" {
    description = "The environment for which the infrastructure is being deployed"
    type        = string
}

variable "vpc" {
    type = object({
        cidr_block = string
        azns        = list(string)
        public_subnets  = list(string)
        private_subnets = list(string)
    })
}

variable "ec2" {
    type = object({
        instance_type    = string
        min_size         = number
        max_size         = number
        desired_capacity = number
    })
  
}

variable "docker_username" {
    description = "Docker Hub username"
    type        = string
    sensitive   = true
}

variable "docker_password" {
    description = "Docker Hub password or token"
    type        = string
    sensitive   = true
}

variable "docker_image" {
    description = "Docker image with tag"
    type        = string
}


