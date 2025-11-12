resource "aws_s3_bucket" "name" {
    bucket = "my-unique-bucket-name-12345"
  
}

resource "aws_instance" "name" {
    ami ="00af95fa354fdb788"
  
}
