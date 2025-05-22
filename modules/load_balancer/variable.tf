# List of subnet IDs where the Application Load Balancer (ALB) will be deployed.
# These should be public subnets to allow external access.
variable "subnets" {
  type        = list(string)
  description = "The subnets where the ALB will be placed."
}

# VPC ID where the ALB and target group reside.
# Ensures the resources are created within the same virtual network.
variable "vpc_id" {
  type        = string
  description = "The VPC where the target group exists."
}

# List of EC2 instance IDs to be registered with the ALB's target group.
# These instances receive the incoming traffic from the ALB.
variable "instances" {
  type        = list(string)
  description = "The target instance IDs to register with the ALB target group."
}

# Security Group ID to associate with the ALB.
# Controls inbound/outbound traffic rules for the load balancer.
variable "alb_sg_id" {
  type        = string
  description = "The ALB security group ID."
}
