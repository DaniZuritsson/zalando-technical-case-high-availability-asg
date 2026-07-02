terraform {
  # S3 Backend infrastructure must be pre-provisioned by the organization
  backend "s3" {
    bucket         = "YOUR-COMPANY-TERRAFORM-STATE-BUCKET" 
    key            = "production/zalando-asg.tfstate"       
    region         = "eu-central-1"                         
    dynamodb_table = "YOUR-COMPANY-LOCK-TABLE"             
    encrypt        = true                                   
  }
}