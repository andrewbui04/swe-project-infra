output "autoscaling_group_name" {
    description = "The name of the Auto Scaling Group"
    value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
    description = "The ARN of the Auto Scaling Group"
    value       = aws_autoscaling_group.this.arn
}

output "launch_template_id" {
    description = "The ID of the launch template"
    value       = aws_launch_template.this.id
}

output "security_group_id" {
    description = "The ID of the ASG security group"
    value       = aws_security_group.asg_sg.id
}
