output "db_host" {
  value       = trimspace(split(":", aws_db_instance.ecommerce.endpoint)[0])  # Split + trim for safety
  description = "RDS endpoint hostname without port"
}

output "db_name" {
  value = aws_db_instance.ecommerce.db_name
}
