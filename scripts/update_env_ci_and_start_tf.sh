#!/bin/bash

set -e

echo "🌍 Fetching your public IP..."
IP=$(curl -s ifconfig.me)

echo "📝 Updating app_server_ip in terraform.tfvars..."
# Remove old line and replace it
sed -i.bak '/^app_server_ip *=/d' ../terraform/terraform.tfvars
echo "app_server_ip = \"$IP/32\"" >> ../terraform/terraform.tfvars

cd ..

echo "🚀 Running terraform apply..."
cd terraform
#terraform init
terraform apply -auto-approve

echo "📤 Extracting outputs ..."
DB_HOST=$(terraform output -raw db_endpoint)
DB_NAME=$(terraform output -raw db_name)
DB_USER="ecom_user"
DB_PASS="3etyhrh367hhddrip"  # 🔐 Optional: make dynamic later

cd ..

echo "🔐 Updating .env..."
cat > scripts/.env <<EOF
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASS=$DB_PASS
EOF

echo "🔐 Pushing GitHub secrets..."
echo "$DB_HOST" | gh secret set DB_HOST
echo "$DB_NAME" | gh secret set DB_NAME
echo "$DB_USER" | gh secret set DB_USER
echo "$DB_PASS" | gh secret set DB_PASS


echo "✅ Terraform + Secrets sync complete!"
