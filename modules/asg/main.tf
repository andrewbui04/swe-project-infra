resource "aws_security_group" "asg_sg" {
    name        = "${var.name}-sg"
    description = "Security group for EC2 instances created from ASG"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = var.container_port
        to_port     = var.container_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = [var.alb_security_group_id]  # Allow from ALB'
    }

     # Allow SSH from bastion/your IP (change 0.0.0.0/0 to your IP for security)
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name}-sg"
    }
}

resource "aws_launch_template" "this" {
    name_prefix   = "${var.name}-"
    image_id      = var.ami_id
    instance_type = var.instance_type
    key_name = "swe-project-debug"

    user_data = base64encode(templatefile("${path.module}/user_data.sh", 
    {
        docker_username = var.docker_username
        docker_password = var.docker_password
        docker_image    = var.docker_image
        container_port  = var.container_port
    }))

    network_interfaces {
        associate_public_ip_address = false
        security_groups             = [aws_security_group.asg_sg.id]
        delete_on_termination       = true
    }

    tag_specifications {
        resource_type = "instance"

        tags = {
            Name = var.name
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "this" {
    name                = var.name
    vpc_zone_identifier = var.private_subnet_ids
    target_group_arns   = [var.target_group_arn]
    health_check_type   = "ELB"
    health_check_grace_period = 300

    min_size         = var.min_size
    max_size         = var.max_size
    desired_capacity = var.desired_capacity

    launch_template {
        id      = aws_launch_template.this.id
        version = "$Latest"
    }

    tag {
        key                 = "Name"
        value               = var.name
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}