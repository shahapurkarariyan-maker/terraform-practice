# VPC
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "trvpc"
    }
  
}
# Subnets
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "subnet-1-public"
    }
}

resource "aws_subnet" "name-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "subnet-2-private"
    }
  
}
# internet gateway

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
  
}
# route table

resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id

   route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id

   }
}
# subnet association

resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
  
}
# security group
resource "aws_security_group" "my_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "my-security-group"
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  

# EC2 Instances 

resource "aws_instance" "public" {
    ami = "00af95fa354fdb788"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [ aws_security_group.my_sg.id ]
    associate_public_ip_address = true
    tags = {
      Name = "public-ec2"
    }
  
}
resource "aws_instance" "pvt" {
    ami = "00af95fa354fdb788"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name-2.id
    vpc_security_group_ids = [ aws_security_group.my_sg.id ]
    
    tags = {
      Name = "private-ec2"
    }
}

