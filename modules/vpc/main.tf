# Create the main VPC
resource "aws_vpc" "project_vpc" {
    cidr_block           = var.cidr                      
    enable_dns_support   = true                          
    enable_dns_hostnames = true                          
tags = {
      name = "project VPC"
      Name = "project VPC"
    }
}

# Create Public Subnet 1 in the first availability zone
resource "aws_subnet" "public1" {
    vpc_id            = aws_vpc.project_vpc.id
    cidr_block        = var.sub_pub[0]                   
    availability_zone = var.azs[0]                       
    tags = {
      name = "Public 1"
      Name = "Public 1"
    }
}

# Create Public Subnet 2 in the second availability zone
resource "aws_subnet" "public2" {
    vpc_id            = aws_vpc.project_vpc.id
    cidr_block        = var.sub_pub[1]                   
    availability_zone = var.azs[1]                       
    tags = {
      name = "Public 2"
      Name = "Public 2"
    }
}

# Create Private Subnet 1 in the first availability zone
resource "aws_subnet" "private1" {
    vpc_id            = aws_vpc.project_vpc.id
    cidr_block        = var.sub_priv[0]                  # CIDR block for private subnet 1
    availability_zone = var.azs[0]
    tags = {
      name = "Private 1"
      Name = "Private 1"
    }
}

# Create Private Subnet 2 in the second availability zone
resource "aws_subnet" "private2" {
    vpc_id            = aws_vpc.project_vpc.id
    cidr_block        = var.sub_priv[1]                  # CIDR block for private subnet 2
    availability_zone = var.azs[1]
    tags = {
      name = "Private 2"
      Name = "Private 2"
    }
}

# Create an Internet Gateway attached to the VPC
resource "aws_internet_gateway" "igw_project" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      name = "igw_project"
      Name = "IGW-Project"
    }
}

# Create a route table for public subnets, with default route to IGW
resource "aws_route_table" "project_route_table" {
    vpc_id = aws_vpc.project_vpc.id

    route {
        cidr_block = "0.0.0.0/0"                      # Route all internet traffic
        gateway_id = aws_internet_gateway.igw_project.id
    }

    tags = {
      name = "project route table"
      Name = "Project-RT"
    }
}

# Associate public subnet 1 with the route table to enable internet access
resource "aws_route_table_association" "associate1" {
    subnet_id      = aws_subnet.public1.id
    route_table_id = aws_route_table.project_route_table.id
}

# Associate public subnet 2 with the route table to enable internet access
resource "aws_route_table_association" "associate2" {
    subnet_id      = aws_subnet.public2.id
    route_table_id = aws_route_table.project_route_table.id
}

# Create a security group for instances in public subnets
resource "aws_security_group" "SG_project_pub" {
    name        = "SG_project_pub"
    description = "Security group for public subnet instances"
    vpc_id      = aws_vpc.project_vpc.id

    # Allow inbound HTTP traffic (port 80) from anywhere
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow inbound HTTPS traffic (port 443) from anywhere
    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow inbound SSH traffic (port 22) from anywhere (consider restricting this to your IP for security)
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow all outbound traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "SG_project_pub"
        Name = "SG_project_pub"
    }
}
