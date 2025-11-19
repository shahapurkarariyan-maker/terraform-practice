locals {
  bucket-name = "${var.layer}-${var.env}-dkhdfnslsg-bucket"
  region = "ap-south-1"
  #provider = aws.oregon
}

resource "aws_s3_bucket" "my_bucket1" {
    # bucket = "web-dev-bucket"
    # bucket = "${var.layer}-${var.env}-dkhdfnslsg-bucket"
    bucket = local.bucket-name
    region = local.region
    #provider = local.provider
    tags = {
        # Name = "${var.layer}-${var.env}-dkhdfnslsg-bucket"
        Name = local.bucket-name
        Environment = var.env
    }
    

  
}

