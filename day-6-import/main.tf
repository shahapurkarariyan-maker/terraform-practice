resource "aws_instance" "name" {
  ami = "01760eea5c574eb86"
  instance_type = "t3.micro"
  tags = {
    Name = "test_instance"
  }

}
