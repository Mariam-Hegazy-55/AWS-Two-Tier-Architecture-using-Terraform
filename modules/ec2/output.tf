# ===================================================
# Outputs
# ===================================================

# Output the list of EC2 instance IDs created by the web-server resource
output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [for instance in aws_instance.web-server : instance.id]
}

# Output the ID of the ALB security group
output "alb_sg_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}
