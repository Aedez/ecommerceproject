output "db_endpoint" {
  value = aws_db_instance.ecommerce.endpoint
}

output "db_name" {
  value = aws_db_instance.ecommerce.db_name
}
