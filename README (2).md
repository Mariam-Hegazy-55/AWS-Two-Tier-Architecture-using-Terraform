# AWS-Two-Tier-Architecture-using-Terraform
This AWS architecture deploys a highly available web app using Terraform. An ALB routes traffic to EC2 instances in public subnets across two AZs, which access private RDS databases. An S3 bucket offers object storage and stores the Terraform state securely within the same VPC.

![two tier project](https://github.com/user-attachments/assets/01a035f7-d3f8-4780-870c-50b21085fb9a)

! [two-tier-project] (two-tier-project.svg)

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

# 🧩 Architecture Components
Custom VPC: A virtual private cloud with defined CIDR blocks to host the infrastructure.

Subnets:
Public Subnets: Two subnets for the web server tier, each in a different Availability Zone (AZ) to ensure high availability.
Private Subnets: Two subnets for the RDS tier, also distributed across different AZs.

Route Tables:
Public Route Table: Associated with public subnets and connected to an Internet Gateway for external access.
Private Route Table: Associated with private subnets and connected to a NAT Gateway for secure outbound internet access.

Internet Gateway & NAT Gateway:
Internet Gateway: Allows internet access for resources in public subnets.

EC2 Instances:
Deployed in public subnets with Apache web servers installed via user data scripts.

RDS MySQL Instance:
Hosted in private subnets to store application data securely.

Security Groups:
Configured to allow HTTP traffic to web servers and MySQL traffic between web servers and the database.


Terraform Modules:
Used to organize and reuse code efficiently, promoting scalability and maintainability.



