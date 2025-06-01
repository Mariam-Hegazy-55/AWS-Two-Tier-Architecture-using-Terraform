# AWS-Two-Tier-Architecture-using-Terraform
This AWS architecture deploys a highly available web app using Terraform. An ALB routes traffic to EC2 instances in public subnets across two AZs, which access private RDS databases. An S3 bucket offers object storage and stores the Terraform state securely within the same VPC.

![two tier project](https://github.com/user-attachments/assets/01a035f7-d3f8-4780-870c-50b21085fb9a)

---
## 📚 Table of Contents

1. [📌 Architecture Overview](#-architecture-overview)
2. [🚀 Features](#-features)
3. [🛠️ Tools & Technologies](#️-tools--technologies)
4. [📂 Folder Structure](#-folder-structure)
5. [📦 How to Deploy](#️-how-to-deploy)
6. [🌐 Accessing the Application](#-accessing-the-application)


---
## 📌 Architecture Overview

- **Region:** `eu-west-2 (London)`
- **VPC** with:
  - **2 Public Subnets** (eu-west-2a, eu-west-2b) for EC2 web servers
  - **2 Private Subnets** (eu-west-2a, eu-west-2b) for RDS
- **Internet Gateway (IGW)** for public access
- **Application Load Balancer (ALB)** for distributing incoming traffic
- **EC2 Instances** running web servers (Apache/PHP or NGINX)
- **Amazon RDS (MySQL)** in Multi-AZ mode
- **S3 Bucket** for storing `terraform.tfstate` file

---

## 🚀 Features

- ✅ High Availability across multiple Availability Zones
- ✅ Infrastructure as Code using Terraform
- ✅ Remote state management via S3
- ✅ Scalable and modular design
- ✅ Secure separation of public and private resources

---

## 🛠️ Tools & Technologies

| Tool        | Purpose                        |
|-------------|--------------------------------|
| Terraform   | Infrastructure provisioning    |
| AWS EC2     | Hosting web servers            |
| AWS RDS     | Managed MySQL database         |
| AWS S3      | Remote backend for tfstate     |
| ALB         | Load balancing incoming traffic|

---

## 📂 Folder Structure
The project is organized as follows:
``` bash
CLOUD-INFRA/
├── .terraform/                   # Terraform cache directory
│   └── plugins/                  # Provider plugins
├── modules/
│   ├── ec2/                      # Compute module
│   │   ├── templates/
│   │   │   └── user_data.sh.tpl  # Cloud-init template
│   │   ├── main.tf               # EC2 instances
│   │   ├── outputs.tf            # Instance outputs
│   │   └── variables.tf          # Size/AMI vars
│   │
│   ├── vpc/                      # Network module
│   │   ├── main.tf               # VPC/Subnets
│   │   ├── outputs.tf            # Network IDs
│   │   └── variables.tf          # CIDR vars
│   │
│   ├── rds/                      # Database module
│   │   ├── main.tf               # Aurora/MySQL
│   │   ├── outputs.tf            # Endpoints
│   │   └── variables.tf          # DB configs
│   │
│   └── lb/                       # Load Balancer
│       ├── main.tf               # ALB/NLB
│       ├── outputs.tf            # DNS names
│       └── variables.tf          # LB specs
│
├── main.tf                       # Core resources
├── providers.tf                  # AWS/Cloud config
├── variables.tf                  # Global variables
├── outputs.tf                    # Stack outputs
├── terraform.tfvars              # Env variables
└── backend.tf                    # S3 state config 
```

---

## 📦 How to Deploy

1. **Initialize Terraform**
   ```bash
   terraform init
   ```
2. **Preview the Plan**
   ```bash
   terraform plan
   ```
3. **Apply the Plan**
    ```bash
   terraform apply
   ```
---
## 🌐 Accessing the Application

After successful deployment:

- 🌍 **Web Access:**  
  Access the web application using the **DNS name of the Application Load Balancer (ALB)** provided in the Terraform output.


Example:
```bash
curl http://<alb_dns_name>
```
