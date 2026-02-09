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
        ami_id           = string
        key_name         = string
        min_size         = number
        max_size         = number
        desired_capacity = number
    })
  
}



