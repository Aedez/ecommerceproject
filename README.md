# 🛒 Ecommerce Database Management System (DMS)

A basic cloud-native ecommerce backend database system, designed for scalability, high availability, and production-ready deployment on AWS using Infrastructure as Code (IaC).

## 📌 Project Goals

This project demonstrates best practices in cloud database design and management, covering:
- Schema modeling and normalization
- Infrastructure automation with Terraform
- Data population and validation with Python
- CI/CD for schema migrations
- Real-time monitoring using CloudWatch

---

## 📦 Features

### ✅ Functional Requirements
- Product catalog (name, price, inventory, etc.)
- User accounts and profiles (login, addresses)
- Shopping cart and order processing
- Payment tracking and order status updates

### 🔐 Non-Functional Requirements
- High availability via Multi-AZ RDS
- Scalability using read replicas
- Security with IAM policies and encryption at rest

---

## ⚙️ Tech Stack

| Component       | Tool/Service             |
|----------------|--------------------------|
| Database        | PostgreSQL on AWS RDS    |
| IaC             | Terraform                |
| Scripting       | Python (Faker, psycopg2) |
| CI/CD           | GitHub Actions + Flyway  |
| Monitoring      | CloudWatch, Grafana (optional) |
| Visualization   | draw.io (ER diagrams)    |

---

## 🗂️ Directory Structure

ecommerce-dms/
│
├── .gitignore                  # Ignored files and folders
├── README.md                   # Project documentation
│
├── terraform/                  # Infrastructure as Code (AWS RDS setup)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
│
├── schema/                     # SQL schema and migration scripts
│   ├── ddl/                    # DDL scripts to create tables
│   │   └── create_tables.sql
│   └── migrations/             # Migration scripts (Flyway/Alembic)
│       └── V1__init.sql
│
├── scripts/                    # Python scripts for data loading and testing
│   ├── data_loader.py
│   └── test_db.py
│
├── ci-cd/                      # Continuous Integration & Deployment
│   ├── github-actions/         # GitHub Actions workflows
│   │   └── deploy.yml
│   └── flyway/                 # Optional Flyway config
│       └── flyway.conf
│
├── monitoring/                 # Monitoring configs and alert definitions
│   └── cloudwatch-alarms.json
│
├── diagrams/                   # ER diagrams and architecture visuals
│   └── conceptual_er.png
│
└── docs/                       # Requirements and other documentation
    └── requirements.md





## 📦 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ecommerce-dms.git
   cd ecommerce-dms
   ```

2. Initialize Terraform and apply:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```
3. Load sample data:
    ```bash
    cd scripts
    python data_loader.py
    ```


## 🧪 Testing
- Run unit tests:
    ```bash
    python -m unittest discover -s tests
    ```


## 📈 Monitoring
- Set up CloudWatch alarms for RDS metrics (CPU, memory, etc.)
- Optionally, integrate with Grafana for advanced visualization.


## 📜 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 📞 Contact
For questions or feedback, please reach out to: