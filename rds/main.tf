# Creates a subnet group for the RDS instance,
# specifying the private subnets in which RDS can be launched.
resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_name          # Custom name for the subnet group
  subnet_ids = var.subnet_ids           # List of private subnet IDs
  tags = {
    Name = "RDS Subnet Group"
    name = "RDS Subnet Group"
  }
}

# Creates the RDS MySQL database instance
resource "aws_db_instance" "db" {
  identifier              = "db-instance"      # Unique identifier for the RDS instance
  engine                  = "mysql"            # Database engine
  engine_version          = "8.0"              # MySQL version
  instance_class          = "db.t3.micro"      # Instance type (low-cost for testing/dev)
  allocated_storage       = 10                 # Storage size in GB
  username                = var.db_username    # Master DB username
  password                = var.db_password    # Master DB password
  db_name                 = var.db_name        # Name of the initial database
  multi_az                = false              # Single-AZ deployment (not highly available)
  storage_type            = "gp2"              # General Purpose SSD storage
  storage_encrypted       = false              # No encryption for the DB
  publicly_accessible     = false              # Restrict access from the internet
  skip_final_snapshot     = true               # Skip snapshot when deleting (not for production)
  backup_retention_period = 0                  # No backups (not recommended for production)

  vpc_security_group_ids  = [aws_security_group.sg_db.id]         # DB security group
  db_subnet_group_name    = aws_db_subnet_group.db-subnet.name    # Subnet group for DB placement

  tags = {
    name = "web_db"
    Name = "Web-DB"
  }
}

# Security group for the RDS DB instance
resource "aws_security_group" "sg_db" {
  description = "Allow MySQL access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL access from EC2 instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.sg-ec2-id]    # Allow traffic from EC2's security group
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "db-sg"
    Name = "DB-SG"
  }
}
