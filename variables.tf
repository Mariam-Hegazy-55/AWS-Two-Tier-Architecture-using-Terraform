# AWS region where resources will be deployed
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

# Database username for RDS instance
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  sensitive   = true
}

# Database password for RDS instance
variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

# Name of the DB subnet group
variable "db_sub_name" {
  description = "Name of the RDS DB subnet group"
  type        = string
  default     = "db-subnet-a-b"
}

# Name of the database to create on the RDS instance
variable "db_name" {
  description = "The initial database name to create inside RDS"
  type        = string
  default     = "mydatabase"
}

# VPC CIDR block (default is a private class A range)
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "20.0.0.0/16"
}

# List of public subnet CIDR blocks
variable "sub_pub" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

# List of private subnet CIDR blocks
variable "sub_priv" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# List of availability zones to deploy subnets
variable "azs" {
  description = "List of availability zones to create subnets in"
  type        = list(string)
}
