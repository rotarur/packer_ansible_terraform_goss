output "aws_nlb_dns_name" {
  description = "AWS NLB DNS name"
  value       = aws_lb.main.dns_name
}
