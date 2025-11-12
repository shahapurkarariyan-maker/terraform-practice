
resource "aws_instance" "name" {
    ami = "00af95fa354fdb788"
    instance_type = "t3.micro"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "ec2-instance"
    }

}

resource "aws_s3_bucket" "name" {
    bucket = "hfdgjkjjjjjmffgk"
  

}


 