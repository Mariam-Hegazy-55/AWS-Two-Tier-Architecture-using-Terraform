#VPC CIDR
variable "cidr" {
    type = string
}

# Public subnets CIDR
variable "sub_pub" {
    type = list(string)
  
}

# Private Subnets CIDR
variable "sub_priv" {
    type = list(string)
}

variable "azs" {
  description = "List of Availability Zones "
  type        = list(string)
}
