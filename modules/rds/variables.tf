variable "db_sub_name" {
  description = "Name for the RDS DB subnet group"
  type        = string
  default     = "db-subnet-a-b"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name to create in the RDS instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the resources will be created"
  type        = string
}

variable "sg-ec2-id" {
  description = "Security group ID attached to EC2 instances that need access to RDS"
  type        = string
}
