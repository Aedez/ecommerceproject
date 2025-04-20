#!/bin/bash

# Usage
# This script is a wrapper for Terraform commands to manage the infrastructure for an ecommerce application.
# ./manage.sh init      # Terraform init
# ./manage.sh apply     # Launch infrastructure
# ./manage.sh destroy   # Tear everything down


# Wrapper script for Terraform workflows
set -e

TF_DIR="terraform"

echo "======================================="
echo "  Ecommerce DMS Terraform Manager"
echo "======================================="

show_help() {
  echo "Usage: ./manage.sh [command]"
  echo
  echo "Commands:"
  echo "  init      - Initialize Terraform"
  echo "  apply     - Apply infrastructure"
  echo "  destroy   - Destroy infrastructure"
  echo "  plan      - Show plan"
  echo "  output    - Show outputs"
  echo
}

cd $TF_DIR || {
  echo "Error: Terraform directory not found."
  exit 1
}

case "$1" in
  init)
    echo "[+] Initializing Terraform..."
    terraform init
    ;;
  apply)
    echo "[+] Applying infrastructure..."
    terraform apply -auto-approve
    ;;
  destroy)
    echo "[!] Destroying infrastructure..."
    terraform destroy -auto-approve
    ;;
  plan)
    echo "[+] Generating execution plan..."
    terraform plan
    ;;
  output)
    terraform output
    ;;
  *)
    show_help
    ;;
esac
