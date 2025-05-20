output "public1_id" {
    value = aws_subnet.public1.id
  
}

output "public2_id" {
    value = aws_subnet.public2.id
  
}

output "sg_id" {
    value = aws_security_group.SG_project_pub.id
  
}

output "vpc_id" {
    value = aws_vpc.project_vpc.id
  
}
output "private_subnet1" {
    value = aws_subnet.private1.id
}

output "private_subnet2" {
    value = aws_subnet.private2.id
}