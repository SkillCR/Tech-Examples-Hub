# Managing Multi-Environment Deployments in Kubernetes using Helm and Namespace

## Overview

This project uses Terragrunt to manage and deploy a Kubernetes cluster with KIND, as well as distinct environments (`dev` and `stage`). Each environment is configured with its own Kubernetes namespace and a Nginx deployment via Helm.

## Project Structure

The main structure of the project is as follows:

```
k8s-multi-env-with-kind-and-tf-tg/
│
├── modules/
│   ├── kind/
│   │   └── main.tf
│   └── helm/
│       └── main.tf
├── envs/
│   ├── dev/
│   │   └── terragrunt.hcl
│   ├── stage/
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
└── terragrunt.hcl
```

- **modules/kind**: Contains the Terraform code to create a KIND cluster.
- **modules/helm**: Contains the Terraform code to deploy a Nginx Helm chart in a Kubernetes namespace.
- **envs/dev**: Terragrunt configuration for the development environment.
- **envs/stage**: Terragrunt configuration for the staging environment.
- **envs/terragrunt.hcl**: Terragrunt configuration to deploy the KIND cluster.
- **terragrunt.hcl**: Parent Terragrunt configuration file.

## Prerequisites

Before starting, make sure you have the following tools installed on your machine:

- [Terraform](https://www.terraform.io/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [KIND (Kubernetes IN Docker)](https://kind.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)

## Instructions

### 1. Deploy the KIND Cluster

First, you need to deploy the KIND cluster. This step is necessary before deploying the `dev` and `stage` environments.

```bash
cd envs
terragrunt init
terragrunt apply
```

This will create a local Kubernetes cluster using KIND with the name `kindcluster`.

### 2. Deploy the Development Environment

Once the KIND cluster is deployed, you can deploy the development environment:

```bash
cd dev
terragrunt init
terragrunt apply
```

This will:

1. Create a Kubernetes namespace named `dev`.
2. Deploy Nginx in this namespace using a Helm chart.

### 3. Deploy the Staging Environment

Similarly, you can deploy the staging environment:

```bash
cd ../stage
terragrunt init
terragrunt apply
```

This will:

1. Create a Kubernetes namespace named `stage`.
2. Deploy Nginx in this namespace using a Helm chart.

### 4. Verify the Deployments

To verify that everything was deployed correctly, you can use `kubectl` to inspect the namespaces and services:

- List namespaces:
  ```bash
  kubectl get namespaces
  ```

- List pods in the `dev` namespace:
  ```bash
  kubectl get pods -n dev
  ```

- List pods in the `stage` namespace:
  ```bash
  kubectl get pods -n stage
  ```

- Check the deployed services:
  ```bash
  kubectl get svc -n dev
  kubectl get svc -n stage
  ```

### 5. Destroy the Infrastructure

To clean up your environment after testing, you can destroy the resources by following these steps:

- Destroy the `dev` and `stage` environments:
  ```bash
  cd ../dev
  terragrunt destroy

  cd ../stage
  terragrunt destroy
  ```

- Destroy the KIND cluster:
  ```bash
  cd ../
  terragrunt destroy
  ```

## Conclusion

This project structure allows you to effectively manage a local Kubernetes cluster with multiple environments using Terragrunt. The process is automated and consistent, making it easy to create, verify, and destroy environments.
