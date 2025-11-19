provider "aws" {
    region = "ap-south-1"
  
}
provider "aws" {
    region = "ap-northeast-3"
    alias = "oregon"
  
}