# AWS_two_tier_architecture

# Two_tier_architecture 🏗 This repository is created to show how to deploy 2-tier application on AWS Cloud with the help of Terraform
<a href="https://aws.amazon.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="aws" width="80" height="80"/> </a>  <a href="https://www.terraform.io/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="Terraform" width="80" height="80"/> 
# This Architecture contains: 1.Web Tier 2. Database Tier
## 🏠 Architecture ![Arhitecture of the application](https://github.com/Sanam02/AWS_two_tier_architecture/blob/main/images/2tierarchitecture.gif)
## 🖥️ Installation of Terraform
### Create S3 Backend Bucket
Create an S3 bucket to store the .tfstate file in the remote backend
**Warning** It is highly recommended that you `enable Bucket Versioning` on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.
**Note** We will need this bucket name in the later step
### Create a DynamoDB table for state file locking
- Give the table a name
- make sure to add a `Partition key` with name `LockID` and type as `String`
