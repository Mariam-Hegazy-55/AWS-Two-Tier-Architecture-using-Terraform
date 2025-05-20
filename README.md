# AWS-Two-Tier-Architecture-using-Terraform
This AWS architecture deploys a highly available web app using Terraform. An ALB routes traffic to EC2 instances in public subnets across two AZs, which access private RDS databases. An S3 bucket offers object storage and stores the Terraform state securely within the same VPC.

# 🛠️ Project Structure
The project is organized as follows:

FINAL .../  
├── .terraform/    

├── terraform.tfstate  

├── modules/  
│   ├── ec2/  
│   │   ├── main.tf  
│   │   ├── output.tf  
│   │   └── variables.tf  
│   ├── load_balancer/  
│   │   ├── main.tf  
│   │   ├── output.tf  
│   │   └── variables.tf  
│   ├── rds/  
│   │   ├── main.tf  
│   │   ├── output.tf  
│   │   └── variables.tf  
│   └── vpc/  
│       ├── main.tf  
│       ├── output.tf  
│       └── variables.tf  

├── .terraform.lock.hcl  

├── backend.tf  

├── main.tf  

├── output.tf  

├── provider.tf  

├── terraform.tfvars  

└── variables.tf  
