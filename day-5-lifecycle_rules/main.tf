resource "aws_instance" "dev" {
    ami = "01760eea5c574eb86"
    instance_type = "t3.micro"
    tags = {
      Name = "ec2-test-dev"
    }

   
}