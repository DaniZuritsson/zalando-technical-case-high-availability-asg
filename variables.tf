variable "aws_region" {
  description = "The AWS region where the infrastructure will be deployed"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "The main CIDR block for the production VPC (e.g., 10.0.0.0/16)"
  type        = string
  # No default values: Define your main corporate CIDR block
}

variable "public_subnet_cidrs" {
  description = "List of 2 CIDR blocks for the public subnets hosting the ALB"
  type        = list(string)
  # No default value: Dynamically specified via tfvars depending on client's IP schema
}

variable "private_subnet_cidrs" {
  description = "List of 2 CIDR blocks for the private subnets hosting the EC2 instances"
  type        = list(string)
  # No default value: Dynamically specified via tfvars depending on client's IP schema
}

variable "instance_type" {
  description = "The EC2 instance type for the application servers"
  type        = string
  default     = "t3.micro" 
}