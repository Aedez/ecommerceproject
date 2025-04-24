#!/bin/bash
# Usage
# This script is a wrapper for Terraform commands to manage the infrastructure for an ecommerce application.
# ./safe_destroy.sh
set -e

echo "=================================="
echo "🔥 Safe Terraform Teardown Script"
echo "=================================="

cd terraform

# Step 1: Destroy dependent services first
echo "[1/4] Destroying RDS instance..."
terraform destroy -target=aws_db_instance.ecommerce -auto-approve || true

echo "[2/4] Destroying RDS Subnet Group..."
terraform destroy -target=aws_db_subnet_group.rds_subnet_group -auto-approve || true

echo "[3/4] Destroying NAT Gateways..."
terraform destroy -target=aws_nat_gateway.nat_1 -target=aws_nat_gateway.nat_2 -auto-approve || true

echo "[4/4] Destroying everything else..."
terraform destroy -auto-approve

echo "✅ Teardown complete."
