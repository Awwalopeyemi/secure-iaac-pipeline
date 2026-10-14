# PROJECT DOCUMENTATION

# Secure Azure Infrastructure as Code and DevSecOps Pipeline

## Project Overview

This repository demonstrates a production-grade, secure cloud infrastructure and automated DevSecOps pipeline. It showcases practical competency in building zero-trust cloud architectures, managing infrastructure via code, and enforcing Shift-Left security principles to catch vulnerabilities before code is deployed to production.

---

## Architecture and Security Controls

The infrastructure is provisioned using Terraform and deployed into an Azure subscription with strict security baselines:

- **Resource Isolation:** Deployed within a dedicated resource group to isolate workloads.
- **Hardened Storage Account:** Configured with security best practices:
    - Public network access disabled to prevent external exposure.
    - Enforced Transport Layer Security version 1.2 (`TLS 1.2`).
    - Least-privilege access controls.
- **Identity and Access Management:** Utilizes Azure Managed Identities and Role-Based Access Control (RBAC) to ensure secure service-to-service communication.

---

## DevSecOps CI/CD Pipeline

To prevent security misconfigurations from reaching the cloud, the repository includes an automated continuous integration workflow:

- **Platform:** GitHub Actions.
- **Tooling:** Checkov Static Application Security Testing (SAST).
- **Workflow:** On every push or pull request, the pipeline automatically clones the repository, sets up the environment, and runs Checkov against the Terraform code to evaluate compliance against security benchmarks.

---

## Repository Structure

```
secure-iaac-pipeline/
├── .github/
│   └── workflows/
│       └── security-pipeline.yml   # Automated Checkov SAST scanning pipeline
├── .gitignore                      # Protects local state files and sensitive variables
└── main.tf                         # Terraform configuration for hardened Azure resources
```

---

## Getting Started and Deployment

### Prerequisites

- Azure CLI installed and authenticated (`az login`).
- Terraform installed locally.
- Git installed.

### Local Deployment Steps

1. Clone the repository:
    
    ```bash
    git clone https://github.com/Awwalopeyemi/secure-iaac-pipeline.git
    cd secure-iaac-pipeline
    ```
    
2. Initialize Terraform:
    
    ```bash
    terraform init
    ```
    
3. Plan and apply the infrastructure:
    
    ```bash
    terraform plan
    terraform apply
    ```
    

---

## Professional Impact

This project bridges the gap between cloud engineering and security operations by demonstrating automated compliance checks, version-controlled infrastructure, and secure cloud defaults aligned with industry security standards.

```mermaid
graph TD
    subgraph Local Environment
        Dev[Developer / VS Code] -->|Write Terraform IaC| Code[(main.tf)]
        Code -->|Git Commit & Push| Git[Local Git Repository]
    end

    subgraph GitHub & CI/CD Pipeline
        Git -->|Push to Main| GH[GitHub Repository]
        GH -->|Trigger Workflow| Actions[GitHub Actions CI/CD]
        Actions -->|Run Checkov SAST| Scan{Security Compliance Scan}
    end

    subgraph Azure Cloud Subscription
        Scan -->|Pass / Soft Fail| TF[Terraform Apply]
        TF -->|Provision Resources| Azure[(Azure Resource Group)]
        Azure -->|Secure Storage| Storage[Hardened Storage Account<br/>- TLS 1.2 Enforced<br/>- Public Access Disabled<br/>- Managed Identity / RBAC]
    end