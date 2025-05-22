# ===================================================
# EC2 Instance Resource - WordPress Web Server
# ===================================================
resource "aws_instance" "web-server" {
  # Launch an EC2 instance for each subnet specified in var.subnet_ids
  count = length(var.subnet_ids)
  ami                    = var.ami                     # AMI ID for the instance (e.g., Ubuntu or Amazon Linux)
  instance_type          = var.instance_type           # Instance type (e.g., t2.micro)
  subnet_id              = var.subnet_ids[count.index] # Assign each instance to a different subnet
  vpc_security_group_ids = [aws_security_group.ec2-sg.id] # Attach EC2 security group
  key_name               = var.key                     # SSH key for access
  associate_public_ip_address = true                   # Assign public IP to access the instance
  
  # Tags for the EC2 instance
  tags = {
    name= "WebServer-${(count.index)+1}"
    Name= "WebServer-${(count.index)+1}"
  }

  # User data to install and configure WordPress with database connection
  user_data = templatefile("${path.module}/templates/wordpress_userdata.sh.tpl", 
  {
    DB_NAME     = var.db_name,
    DB_USER     = var.db_user,
    DB_PASSWORD = var.db_password,
    DB_HOST     = var.db_host
  }
  )  

  
}


# ===================================================
# Security Group for EC2 Instances (web servers)
# ===================================================
resource "aws_security_group" "ec2-sg" {
  name        = "Web_SG"
  description = "enable http/https access on port 80 for alb sg"
  vpc_id      = var.vpc_id

  # Inbound rule: Allow HTTP (port 80) access from ALB
  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Inbound rule: Allow SSH (port 22) access from ALB
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Outbound rule: Allow all traffic (required for internet access and updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name="ec2-sg"
    Name="EC2-SG"
  }
}

# ===================================================
# Security Group for Application Load Balancer (ALB)
# ===================================================
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = var.vpc_id

  # Inbound rule: Allow HTTP traffic from anywhere
  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound rule: Allow HTTPS traffic from anywhere
  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Outbound rule: Allow all traffic (to reach EC2 instances and internet)
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    name="alb_sg"
    Name="ALB-SG"
  }
}













