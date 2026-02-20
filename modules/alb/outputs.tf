output "alb_dns_name" {
    description = "The DNS name of the Application Load Balancer"
    value       = aws_lb.this.dns_name
}   

output "target_group_arn" {
    description = "The ARN of the ALB Target Group"
    value       = aws_lb_target_group.this.arn
}

output "security_group_id" {
    description = "The ID of the ALB security group"
    value       = aws_security_group.alb_sg.id
}