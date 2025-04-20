# 🛒 Ecommerce DMS (Database Management System)

An end-to-end database infrastructure project for a scalable ecommerce platform. Designed for cloud-native deployment with AWS RDS, automated provisioning using Terraform, and robust monitoring via CloudWatch.

## 🚀 Features

### Functional Requirements
- Product catalog (name, description, price, inventory)
- User accounts and profiles
- Shopping cart and order placement
- Payment records and order status tracking

### Non-Functional Requirements
- High availability (Multi-AZ RDS)
- Scalability (read replicas, partitioned tables)
- Security (IAM, encryption at rest, secure access)

## 🧰 Tech Stack

- **Database**: PostgreSQL on AWS RDS
- **IaC**: Terraform
- **Scripting**: Python (psycopg2, Faker)
- **Monitoring**: CloudWatch, optional Grafana
- **CI/CD**: GitHub Actions + Flyway (or Alembic)
- **Visualization**: draw.io / Lucidchart for ERD

## 🗂️ Repository Structure

├── terraform/ # Infrastructure as Code (RDS setup) 
├── schema/ # SQL schema, migrations 
├── scripts/ # Python data loading and tests 
├── ci-cd/ # CI/CD pipelines 
├── monitoring/ # CloudWatch alarms 
├── diagrams/ # ER diagrams and architecture visuals 
    └── docs/ # Requirements, documentation