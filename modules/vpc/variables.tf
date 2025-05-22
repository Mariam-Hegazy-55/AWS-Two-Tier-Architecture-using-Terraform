# VPC CIDR block
variable "cidr" {
  type = string
}

# List of CIDR blocks for public subnets
variable "sub_pub" {
  type = list(string)
}

# List of CIDR blocks for private subnets
variable "sub_priv" {
  type = list(string)
}

# List of Availability Zones where subnets will be created
variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}
