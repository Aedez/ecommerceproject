# 🛒 Ecommerce Database Management System (DMS)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A cloud-native ecommerce backend database system designed for scalability, high availability, and production-ready deployment on AWS using Infrastructure as Code (IaC).

---

## 📌 Project Goals

This project demonstrates best practices in modern cloud database management:
- Schema modeling and normalization
- Infrastructure provisioning using Terraform
- Sample data generation with Python + Faker
- Schema migrations with Alembic
- Automated testing and CI/CD
- Monitoring with CloudWatch

---

## 📦 Features

### ✅ Functional Requirements
- Product catalog (name, price, category)
- User accounts and profiles (login, addresses)
- Shopping cart and order processing
- Payment tracking and order status

### 🔐 Non-Functional Requirements
- High availability (Multi-AZ RDS)
- Scalability (read replicas, future support)
- Secure access (IAM, encryption at rest)

---

## ⚙️ Tech Stack

| Component       | Tool/Service             |
|----------------|--------------------------|
| Database        | PostgreSQL on AWS RDS    |
| IaC             | Terraform                |
| Migrations      | Alembic (Python)         |
| Data Seeding    | Python (Faker, psycopg2) |
| Testing         | pytest                   |
| CI/CD           | GitHub Actions (planned) |
| Monitoring      | CloudWatch               |
| Visualization   | draw.io (ER diagrams)    |

---

## 🗂️ Directory Structure

```text
ecommerce-dms/
├── .gitignore
├── README.md
│
├── terraform/                  # AWS infrastructure (VPC, RDS, etc.)
│   ├── main.tf
│   ├── variables.tf
│   └── ...
│
├── scripts/                    # Python scripts
│   ├── data_loader.py          # Inserts sample data
│   ├── test_db.py              # DB validation tests
│   ├── .env                    # Secure DB credentials (not committed)
│   ├── requirements.txt
│
├── schema/
│   └── migrations/             # Alembic migration files
│       └── versions/
│           └── <timestamp>_init_schema.py
│
├── monitoring/                 # CloudWatch alarms (Terraform)
├── diagrams/                   # ERD and architecture visuals
└── docs/                       # Requirements and additional docs
```
---



## 📦 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/aedez/ecommerceproject.git
   cd eecommerceproject
   ```

2. Initialize Terraform and apply:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```

3. Populate the Database
    ```bash
    cd ../scripts
    pip install -r requirements.txt
    python data_loader.py
    ```


## 🧪 Testing
- Run unit tests:
    ```bash
    pytest scripts/test_db.py
    ```

## 🔄 Migrations with Alembic
- Create a new migration:
Uses .env file for credentials.
    ```bash
    alembic revision -m "new migration"
    alembic upgrade head
    ```

## 💶 **Estimated Cost for a Few Hours (Testing in eu-west-1)**

### 🧱 **Amazon RDS (Multi-AZ, db.t3.medium)**


### 💰 **Total Estimated for 3 Hours Testing**
| Resource     | Cost Estimate |
|--------------|---------------|
| RDS (Multi-AZ)  | ~€0.45        |
| NAT Gateways    | ~€0.30        |
| Misc            | ~€0.10        |
| **Total**       | **~€0.85 – €1.00** |

---

## ✅ Tips to Control Costs

1. **Delete the stack immediately after testing**:
   ```bash
   terraform destroy
   ```
2. **Double-check that RDS snapshots and NAT Gateways are gone**.
3. **Tag your resources** with `Environment=Test` to track spend later.


## 📈 Monitoring
- Set up CloudWatch alarms for RDS metrics (CPU, memory, etc.)
- Optionally, integrate with Grafana for advanced visualization.


## 📜 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 📞 Contact
For questions or feedback, please reach out to:
@mike


## my reminder for local testing steps:
update_env_ci_and_start_tf.sh after adding password to .env file
alembic upgrade head
python3 data_sample_loader.py  
pytest data_sample_test.py  
temporarily open aws sg to allow all ip. find a way to make it just github action ip later. 
currently using a github repo that calls the ip address of the github action runner.
maybe use aws cli to get the ip
push to github
github actions ci/cd
... (will add application deployment steps later)
bash terraform_safe_destroyer.sh to destroy the stack

