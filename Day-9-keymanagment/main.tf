# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/aarya.pub")
}


resource "aws_instance" "server" {
  ami                         = "ami-0bdd88bd06d16ba03" #
  instance_type               = "t.micro"
  key_name                    = aws_key_pair.example.key_name
  
}# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/id_ed25519.pub")
}


resource "aws_instance" "server" {
  ami                         = "ami-0261755bbcb8c4a84" # Ubuntu AMI
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.example.key_name
  
}