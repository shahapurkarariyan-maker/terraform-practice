resource "aws_instance" "name" {
  ami= "00af95fa354fdb788"
  instance_type = "t3.micro"

}

resource "aws_s3_bucket" "name" {
    bucket = "tybuwbdsjbcscdfdkuhfnj"
    provider = aws.oregon
  
}