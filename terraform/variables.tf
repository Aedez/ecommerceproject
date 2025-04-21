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
  default = "ecom_user"
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

variable "app_server_ip" {
  description = "The IP address allowed to access RDS (with /32 CIDR)"
  type        = string
  sensitive   = true
} # This should be the public IP of your app server
