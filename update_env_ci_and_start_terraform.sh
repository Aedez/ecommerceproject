#!/bin/bash

set -e

echo "🌍 Fetching your public IP..."
IP=$(curl -s ifconfig.me)

echo "📝 Updating app_server_ip in terraform.tfvars..."
sed -i.bak '/^app_server_ip *=/d' ../terraform/terraform.tfvars
echo "app_server_ip = \"$IP/32\"" >> ../terraform/terraform.tfvars


echo "🚀 Running terraform apply..."
cd terraform
#terraform init # Uncomment if you want to reinitialize
terraform apply -auto-approve

echo "📤 Extracting outputs ..."
DB_HOST=$(terraform output -raw db_host)
DB_NAME=$(terraform output -raw db_name)
DB_USER="ecom_user"
#EMAIL="1@gamil.com" # 🔐 Optional: maybe make dynamic later

echo "🔐 Generating secure random DB password..."
DB_PASS=$(openssl rand -base64 18)

echo "🔐 Updating terraform.tfvars..."
sed -i.bak '/^db_pass *=/d' ../terraform/terraform.tfvars
echo "db_pass = \"$DB_PASS\"" >> ../terraform/terraform.tfvars

cd ..

echo "🔐 Updating .env..."
cat > scripts/.env <<EOF
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASS=$DB_PASS
EOF
#EMAIL=$EMAIL

echo "🔐 Pushing GitHub secrets..."
echo "$DB_HOST" | gh secret set DB_HOST
echo "$DB_NAME" | gh secret set DB_NAME
echo "$DB_USER" | gh secret set DB_USER
echo "$DB_PASS" | gh secret set DB_PASS
#echo "$EMAIL" | gh secret set ALERT_EMAIL


echo "✅ Terraform + Secrets sync complete!"
