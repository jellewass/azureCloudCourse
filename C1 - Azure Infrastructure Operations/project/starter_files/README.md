# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Customize `vars.tf` and `server.json` files

3. Create Infrastructure as a Code

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
#### 1. Customize vars.tf and server.json file
The `vars.tf` file is used to define variables that can be customized to suit your specific needs. 
In Github, edit the file such that it is in accordance with your resources. 
For example, change the `location` to be one that is closest to you: 
`
variable "location" {
  description = "East US"
  default = "East US"
}`

In the `server.json` file, add the following based on your customized information:
`"client_id": "{{env `ARM_CLIENT_ID`}}",
 "client_secret": "{{env `ARM_CLIENT_SECRET`}}",
 "subscription_id": "{{env `ARM_SUBSCRIPTION_ID`}}"`

#### 2. Build the Server Image
Use Packer to build the server image.
`packer build server.json`
** Expected Output **
`Build 'amazon-ebs' finished.`
Expect the output to contain something similar as above.

#### 3. Initialize Terraform
Initialize the Terraform working directory
`terraform init`
** Expected Output **
`Terraform has been successfully initialized!`
Expect the output to contain something similar as above.

#### 4. Plan the Terraform Deployment
Generate and save an execution plan
`terraform plan -out solution.plan`
** Expected Output **
`Plan: 1 to add, 0 to change, 0 to destroy.`
Expect the output to contain something similar as above.

#### 5. Destory Resources
Then, when done, safely destroy everything with: 
`terraform-destroy` 
This will destory all your resources! 

