# AWS_two_tier_architecture

# Two_tier_architecture 🏗 This repository is created to show how to deploy 2-tier application on AWS Cloud with the help of Terraform For CAFE WEBSITE
<a href="https://aws.amazon.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="aws" width="80" height="80"/> </a>  <a href="https://www.terraform.io/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="Terraform" width="80" height="80"/> 
# This Architecture contains: 
# 1.Web Tier 
# 2. Database Tier
## 🏠 Architecture of the application
![](https://github.com/Sanam02/AWS_two_tier_architecture/blob/main/images/2tierarchitecture.gif)
## 🖥️ Installation of Terraform
### Create S3 Backend Bucket
Create an S3 bucket to store the .tfstate file in the remote backend
**Warning** It is highly recommended that you `enable Bucket Versioning` on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.
**Note** We will need this bucket name in the later step
### Create a DynamoDB table for state file locking
- Give the table a name
- make sure to add a `Partition key` with name `LockID` and type as `String`

### Generate a public-private key pair for our instances
We need a public key and private key for our server so please follow the procedure I've included below.

```sh
cd modules/key/
ssh-keygen
```
The aove command asks for the key name and then gives `client_key` it will create pair of keys one public and one private. You can give any name you want but then you need to edit the Terraform file

Edit the blow file according to your configuration
```sh
vim root/backend.tf
```
Add the below code in root/backend.tf
```sh
terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    key    = "backend/FILE_NAME_TO_STORE_STATE.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamoDB_TABLE_NAME"
  }
}
```
### 🏠 Let's set up the variable for our Infrastructure
### 🔐 ACM certificate
Go to AWS console --> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status, if not , feel free to create one and use the domain name on which you are planning to host your application.
### 👨‍💻 Route 53 Hosted Zone
Go to AWS Console --> Route53 --> Hosted Zones and ensure you have a public hosted zone available, if not create one.

Add the below content into the `root/terraform.tfvars` file and add the values of each variable.
```javascript
region = ""
project_name = ""
vpc_cidr                = ""
public_subnet_1a        = ""
public_subnet_2b        = ""
private_subnet_3a        = ""
private_subnet_4b        = ""
private_subnet_5a        = ""
private_subnet_6b        = ""
db_username = ""
db_password = ""
certificate_domain_name = ""
additional_domain_name = ""

```

## ✈️ Now we are ready to deploy our application on the cloud ⛅
get into the project directory
```sh
cd root_module
```
👉 let install dependency to deploy the application 

```sh
terraform init
```

Type the below command to see the plan of the execution
```sh
terrafoem plan
```

✨Finally, HIT the below command to deploy the application...
```sh
terraform apply 
```

Type `yes`, and it will prompt you for approval..

**Thank you so much for reading..😅**
