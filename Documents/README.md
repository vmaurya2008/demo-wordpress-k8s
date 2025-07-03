# README.md

# WordPress Kubernetes CI/CD Deployment

---

## High-Level Architecture Overview

This deployment architecture uses a CI/CD pipeline powered by Jenkins to build, push, and deploy a containerized WordPress application backed by PostgreSQL, with pgAdmin for DB management. It leverages Kubernetes for orchestration and includes resource scaling, Ingress SSL routing, and persistent volumes.

![Architecture] Open the diagram [flow.drawio.png]

---

## Components
- **GitHub** – Source code version control
- **Jenkins** – CI/CD engine
- **Docker Hub** – Container image registry
- **Kubernetes** – Container orchestration
- **WordPress** – Main web application
- **PostgreSQL** – Backend database
- **pgAdmin** – PostgreSQL GUI admin tool
- **Ingress Controller (Nginx)** – Handles routing + SSL
- **Persistent Volumes** – For DB data storage

---

## Local Development Procedure

### Prerequisites
- Docker
- Minikube or local Kubernetes (e.g., K3s)
- kubectl

### Steps
```bash
# 1. Clone the repository
$ git clone https://github.com/vmaurya2008/demo-wordpress-k8s.git
$ cd demo-wordpress-k8s

# 2. Start Minikube (or your preferred cluster)
$ minikube start

# 3. Deploy to Kubernetes
$ ./scripts/deploy.sh

# 4. Add to /etc/hosts if using ingress host
127.0.0.1   wordpress.local
```

---

## Cloud Deployment Procedure (EKS, GKE, etc.)

```bash
# Ensure kubeconfig is set for your cloud cluster
$ kubectl config use-context my-cloud-cluster

# Deploy all manifests
$ ./scripts/deploy.sh
```

---

## Jenkins Pipeline Workflow

### Jenkinsfile Summary
| Stage            | Description                                               |
|------------------|-----------------------------------------------------------|
| Checkout         | Pulls code from GitHub                                    |
| Build Docker     | Builds Docker image for WordPress                         |
| Push Image       | Pushes image to Docker Hub                                |
| Deploy to K8s    | Applies all Kubernetes manifests                          |

### Jenkins Setup Notes
- Add `dockerhub-creds` credential (username/password) in Jenkins
- Configure Jenkins agent with Docker + kubectl
- Trigger pipeline manually or via GitHub webhook

---

## Version Deployment & Rollback

### To Deploy New Version:
- Update `VERSION` in Jenkinsfile or Docker tag
- Commit and push changes to GitHub
- Jenkins builds and deploys the new version

### To Roll Back:
```bash
kubectl rollout undo deployment/wordpress
```

Or use a previous tag manually:
```bash
kubectl set image deployment/wordpress wordpress=docker.io/vmaurya2008/wordpress:v1.0.0
```

---

## Assumptions, Constraints, and Known Limitations

### Assumptions
- Jenkins has required plugins and access to Docker and Kubernetes
- All resources run in a single namespace (e.g., `wordpress`)
- Secrets are managed manually or through Vault/external tool

### Constraints
- PostgreSQL is single-instance (no HA)
- Static Ingress hostname; no cert-manager integration included
- No external monitoring included (optional)

### Optional Enhancements
- Integrate Prometheus + Grafana for metrics
- Use Helm instead of raw YAML
- Use Terraform to provision infra

---

## Questions or Contributions?
Open issues or PRs on the GitHub repository. Feedback welcome!

---


