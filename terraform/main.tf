resource "aws_db_instance" "ecommerce" {
  allocated_storage    = var.db_allocated_storage
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = var.db_instance_class
  db_name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  storage_encrypted    = true
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = true
  backup_retention_period = 7
  deletion_protection  = true

  # Add subnet_group_name and vpc_security_group_ids if needed
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
    
    # Add tags for better management
  tags = {
    Name        = "ecommerce-db"
    Environment = "production"
    Project     = "ecommerce"
    Owner       = "Aedez"
    CreatedBy   = "Terraform"
    CreatedOn   = timestamp()
    UpdatedOn   = timestamp()
    Version     = "1.0"
    Description = "E-commerce database instance"
  }
}
