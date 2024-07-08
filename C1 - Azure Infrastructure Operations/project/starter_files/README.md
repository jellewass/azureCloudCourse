# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
Run `terraform plan -out <FILE>` to run the terraform files. Then, descriptions can be added to the necessary variables. Then, run `terraform apply` to apply our changes. 

### Output
`terraform show` will show the results and the expected output looks much the same as the main.tf file with filled in variables. Then, after doing this, `terraform-destroy` will destory all our resources. 

