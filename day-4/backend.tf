terraform {
  backend "s3" {
    bucket = "terraform-bucket-state-file-storage"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "aarya" 
    encrypt = true
  }
}