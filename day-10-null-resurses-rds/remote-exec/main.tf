# Example EC2 instance (replace with yours if already existing)
resource "aws_instance" "sql_runner" {
  ami                    = "00af95fa354fdb788" # Amazon Linux 2
  instance_type          = "t3.micro"
  key_name               = "my-key"                # Replace with your key pair name
  associate_public_ip_address = true
  user_data = "sudo yum install mariadb105-server -y"

  tags = {
    Name = "SQL Runner"
  }
}

# Deploy SQL remotely using null_resource + remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds, aws_instance.sql_runner]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/Arya.pem")   # Replace with your private key path
    host        = aws_instance.sql_runner.public_ip
  }

  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
        "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -pPassword123! dev < /tmp/init.sql"
    ]
  }

  triggers = {
    always_run = timestamp() #trigger every time apply 
  }
}



