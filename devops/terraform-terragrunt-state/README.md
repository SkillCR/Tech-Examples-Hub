# Terraform and Terragrunt Multi-Environment State Management

This project demonstrates how to manage Terraform state files across multiple environments (development, staging, production) using Terragrunt. Each environment has its own state file managed locally, ensuring isolation and consistency across your infrastructure deployments.

## Directory Structure

The project is organized as follows:

```
terraform-terragrunt-state/
├── terragrunt.hcl                 # Root Terragrunt configuration
├── environments/                  # Environment-specific configurations
│   ├── dev/
│   │   └── terragrunt.hcl         # Development environment config
│   ├── staging/
│   │   └── terragrunt.hcl         # Staging environment config
│   └── prod/
│       └── terragrunt.hcl         # Production environment config
└── modules/
    └── example/
        └── main.tf                # Terraform module for creating local files
```

## How It Works

- **Modular Terraform Code**: The `modules/example/main.tf` file defines a simple Terraform module that creates a local file with content specific to each environment.

- **Environment-Specific Configuration**: Each environment (`dev`, `staging`, `prod`) has its own `terragrunt.hcl` file. These files include:
  - Inputs specific to the environment.
  - A dynamically generated backend configuration (`backend.tf`) that tells Terraform where to store the state file.

- **Terragrunt**: Terragrunt manages the configuration and ensures that each environment has its own isolated state file, reducing the risk of state conflicts.

## Getting Started

### Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed on your machine.
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) installed on your machine.

### Usage

1. **Navigate to the desired environment directory**:
   ```bash
   cd environments/dev
   ```

2. **Initialize Terraform**:
   ```bash
   terragrunt init
   ```

3. **Apply the configuration**:
   ```bash
   terragrunt apply
   ```

4. **Repeat for other environments** (`staging`, `prod`):
   ```bash
   cd ../staging
   terragrunt init
   terragrunt apply
   ```

5. **Check the Output**:
   - A file named `output.txt` will be created in the `modules/example` directory with content specific to the environment (e.g., "This is the development environment").

## Explanation of Key Concepts

- **`generate "backend"`**: This block in the `terragrunt.hcl` files dynamically generates the backend configuration for each environment. This ensures that the state file is stored in a specific location without hardcoding the backend in the module, keeping it reusable.

- **State Isolation**: By configuring separate state files for `dev`, `staging`, and `prod`, you ensure that each environment is isolated, preventing unintended changes from propagating across environments.
