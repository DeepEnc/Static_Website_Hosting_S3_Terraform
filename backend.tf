terraform {
  backend "s3" {
    bucket         = "terraform-state-file-sunil-testing-12345"   
    key            = "deepenc/terraform.tfstate"     
    region         = "us-east-1"            
  }
}

