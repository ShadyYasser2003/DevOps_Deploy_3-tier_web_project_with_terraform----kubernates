# 🗳️ Voting App - Kubernetes Microservices with Terraform

<div align="center">

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)
![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

**Advanced Voting App built with Kubernetes on AWS EKS and infrastructure managed via Terraform**

[🚀 Demo](#demo) • [📋 Requirements](#requirements) • [⚡ Quick Installation](#quick-installation) • [🏗️ Infrastructure](#infrastructure)

</div>

---

## 📖 Overview

A modern microservices-based voting application deployed on **Kubernetes**, allowing users to vote between cats and dogs. This project uses **Terraform** to manage the entire infrastructure on **AWS EKS**, with an **Application Load Balancer (ALB)** ensuring high availability and performance.

### ✨ Key Features

- 🏗️ Microservices Architecture
- ☸️ Kubernetes Native with StatefulSets for persistent storage
- 🔧 Infrastructure as Code using Terraform (no external modules)
- 🔄 Load Balancing via AWS ALB Ingress
- 💾 Persistent Storage using AWS EBS
- 🔒 Encrypted data in transit and at rest
- 📊 Health Monitoring with readiness/liveness checks
- 🎨 Responsive Frontend (Arabic UI included)
- ⚡ Live Result Updates
- 🔧 Horizontal & Vertical Scalability

---

## 🏗️ Application Architecture

```mermaid
graph TB
    subgraph "AWS Cloud - Managed by Terraform"
        subgraph "VPC & Networking"
            VPC[VPC]
            IGW[Internet Gateway]
            NAT[NAT Gateway]
            SG[Security Groups]
        end

        subgraph "EKS Cluster"
            subgraph "Public Subnets"
                ALB[Application Load Balancer]
            end

            subgraph "Private Subnets"
                subgraph "Frontend Pods"
                    F1[Frontend Pod 1]
                    F2[Frontend Pod 2]
                    F3[Frontend Pod 3]
                end

                subgraph "Backend Pods"
                    B1[Backend Pod 1]
                    B2[Backend Pod 2]
                    B3[Backend Pod 3]
                end

                subgraph "Database"
                    R[Redis StatefulSet]
                    PV[Persistent Volume]
                end
            end
        end

        subgraph "Storage"
            EBS[EBS Volumes]
        end

        subgraph "IAM & Security"
            ROLES[IAM Roles]
            POLICIES[IAM Policies]
        end
    end

    Users[Users] --> ALB
    ALB --> F1
    ALB --> F2
    ALB --> F3
    ALB --> B1
    ALB --> B2
    ALB --> B3

    F1 --> B1
    F2 --> B2
    F3 --> B3

    B1 --> R
    B2 --> R
    B3 --> R

    R --> PV
    PV --> EBS
```



## 🛠️ Tech Stack

### Infrastructure
- Terraform – Infrastructure provisioning (no modules)
- AWS Provider

### Backend
- Python 3.9
- Flask
- Redis

### Frontend
- Flask (Python)
- HTML/CSS/JavaScript

### Platform
- Kubernetes
- AWS EKS
- AWS ALB
- AWS EBS
- AWS VPC
- Docker

---

## 📋 Requirements

### Local Environment
- Terraform >= 1.0
- kubectl >= 1.24
- Docker >= 20.10
- AWS CLI >= 2.0
- Git

### AWS Resources
- AWS Account
- Configured AWS CLI
- Optional: S3 + DynamoDB for Terraform state
