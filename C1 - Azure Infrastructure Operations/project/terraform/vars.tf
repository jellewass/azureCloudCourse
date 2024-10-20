variable "prefix" {
  description = "assignmentMachine"
  default = "assignmentMachine"
}

variable "project_name" {
  description = "The name of the project for tagging"
  type        = string
  default     = "MyVritualMachine"
}

variable "location" {
  description = "East US"
  default = "East US"
}

variable "resource_group" {
  default = "Azuredevops"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 2 && var.instance_count <= 5
    error_message = "The instance_count must be between 2 and 5."
  }
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, test, prod)"
  type        = string
  default     = "dev"  # You can set a default value or leave it out
}

