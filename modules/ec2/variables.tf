# =============================
# EC2 Configuration Variables
# =============================

# Amazon Machine Image ID
variable "ami" {
  type        = string
  description = "AMI ID to use for the EC2 instance (e.g., ami-0abcdef1234567890)"
}

# EC2 Instance Type
variable "instance_type" {
  type        = string
  description = "Type of the EC2 instance (e.g., t2.micro)"
}

# List of Subnet IDs where EC2 instances will be launched
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for launching EC2 instances"
}

# Name of the EC2 Key Pair used for SSH access
variable "key" {
  type        = string
  description = "EC2 key pair name to SSH into the instance"
}

# Optional: Path to the private key file for local SSH access (useful for provisioners or remote-exec)
variable "private_key_path" {
  type        = string
  description = "Path to the private key file used to access the EC2 instance "
  default     = ""
}

# =============================
# RDS Database Configuration
# =============================

# Database name used by WordPress
variable "db_name" {
  type        = string
  description = "Name of the RDS database "
}

# Database master username
variable "db_user" {
  type        = string
  description = "Master username for the RDS database"
}

# Database master password
variable "db_password" {
  type        = string
  description = "Master password for the RDS database"
  sensitive   = true
}

# Endpoint/hostname of the RDS database
variable "db_host" {
  type        = string
  description = "The RDS endpoint (host) that the EC2 instances will connect to"
}

# =============================
# Networking
# =============================

# VPC ID where resources will be deployed
variable "vpc_id" {
  type        = string
  description = "VPC ID to which the security groups and subnets belong"
}
