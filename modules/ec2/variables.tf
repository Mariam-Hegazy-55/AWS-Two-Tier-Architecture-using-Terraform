variable "ami" {
    type = string
    description = "the instance image"

}

variable "instance_type" {
    type = string
    description = "the type of instance ex. (t2.micro)"
  
}
variable "subnet_id" {
    type = string
    description = "the id of the subnet the instance will be launched in"
  
}

variable "sg_id" {
    type = list(string)
    description = "The list of the security groups atteched to the instance"
  
}

variable "key" {
    type = string
    description = "the name of the EC2 key pair that allows you to SSH into your instance"
  
}

variable "private_key_path" {
    
}
