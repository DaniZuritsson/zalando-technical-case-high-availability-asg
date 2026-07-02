output "alb_dns_name" {
  description = "The public URL of the Application Load Balancer to access the application"
  value       = aws_lb.external.dns_name
}