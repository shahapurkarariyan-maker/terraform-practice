resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-test"
  engine                  = "mysql"
  engine_version          = "8.0.43"
  instance_class          = "db.t3.micro"
  username                = "aarya"
  password                = "Cloud@123"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0.43"

 
  backup_retention_period  = 2   # Retain backups for 2 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring 
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring.arn

  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true

  # Skip final snapshot
  skip_final_snapshot = true
}

# # IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

#IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = "AWSServiceRoleForRDS"
  policy_arn = "arn:aws:iam::312137309201:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
}





# with data source
data "aws_subnet" "subnet_1" {
  filter {
    name   = "sub-1"
    values = ["subnet-1"]
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "sub-2"
    values = ["subnet-2"]
  }
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}