#Create the VPC
resource "aws_vpc" "project_vpc" {
    cidr_block = var.cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      name = "project VPC"
    }
  
}

# Create Public Subnet 1
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub_pub[0]
    availability_zone       = var.azs[0]
    tags = {
      name = "Public 1"
    }

}

# Create Public Subnet 2
resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub_pub[1]
    availability_zone       = var.azs[1]
    tags = {
      name = "Public 2"
    }

}

# Create Private Subnet 1
resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub_priv[0]
    availability_zone       = var.azs[0]
    tags = {
      name="Private"
    }
  
}   



# Create Private Subnet 2
resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = var.sub_priv[1]
    availability_zone       = var.azs[1]
    tags = {
      name="Private"
    }
  
}


# Create IGW (Internet GateWay)
resource "aws_internet_gateway" "igw_project" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      name = "igw_project"
    }
}

#Create the route table
resource "aws_route_table" "project_route_table" {
    vpc_id = aws_vpc.project_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id= aws_internet_gateway.igw_project.id
    }

    tags = {
      name = "project route table"
    }

}

#Associate public subnet 1 
resource "aws_route_table_association" "associate1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.project_route_table.id
  
}

#Associate public subnet 2
resource "aws_route_table_association" "associate2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.project_route_table.id
  
}

# Create security Group for the Instances
resource "aws_security_group" "SG_project_pub" {
    name = "SG_project_pub"
    description = "The SG of public subnets"
    vpc_id = aws_vpc.project_vpc.id
    # permit inbound traffic ( HTTP, HTTPS,SSH)
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # permit all otbound traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"  # all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "SG_project_pub"
    }

}
