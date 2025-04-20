variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_profile" {
  default = "default"
}

variable "db_name" {
  default = "ecommercedb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "Master password for RDS"
  sensitive   = true
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "alert_email" {
  description = "Email address to receive CloudWatch alerts"
  type        = string
}
