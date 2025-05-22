output "rds-endpoint" {
    value= aws_db_instance.db.address
    description = "This will output the RDS instance's endpoint (DNS name)"  
} 
