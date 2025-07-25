# RDS compartilhado entre Users, Products e Orders
resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = module.vpc.private_subnets
  description = "Subnets para o RDS"
}

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rds_pg" {
  identifier         = "app-postgres"
  engine             = "postgres"
  engine_version     = "14"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = var.db_username
  password           = var.db_password
  skip_final_snapshot = true
  publicly_accessible = false
  multi_az           = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 7
  storage_encrypted      = true
  deletion_protection    = true
}
