resource "aws_db_instance" "default" {
  allocated_storage       = 12
  identifier              = "my-rds"
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0.43"
  instance_class          = "db.t3.micro"
  manage_master_user_password = true 
  username                    = "admin"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0.43"
  backup_retention_period  = 2 
  backup_window            = "02:00-03:00" 


  maintenance_window = "sun:04:00-sun:05:00"  
  deletion_protection = true
  skip_final_snapshot = true
 
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }
  
}
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
  
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "my-sub-net-group"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}