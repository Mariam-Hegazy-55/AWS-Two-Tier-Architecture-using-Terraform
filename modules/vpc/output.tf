# Output the ID of the first public subnet
output "public1_id" {
  value = aws_subnet.public1.id
}

# Output the ID of the second public subnet
output "public2_id" {
  value = aws_subnet.public2.id
}

# Output the ID of the security group for public subnet instances
output "sg_id" {
  value = aws_security_group.SG_project_pub.id
}

# Output the ID of the created VPC
output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

# Output the ID of the first private subnet
output "private_subnet1" {
  value = aws_subnet.private1.id
}

# Output the ID of the second private subnet
output "private_subnet2" {
  value = aws_subnet.private2.id
}
