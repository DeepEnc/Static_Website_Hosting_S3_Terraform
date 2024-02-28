terraform {
  backend "s3" {
    bucket         = "terraform-state-file-deepenc-testing-12345"   
    key            = "deepenc/terraform.tfstate"     
    region         = "us-east-1"            
  }
}

