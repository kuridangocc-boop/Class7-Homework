# Terraform Step-by-Step: 11 Nov 2025

## What is Terraform?
Terraform is Infrastructure as Code (IaC) tool that lets you define, provision, query and manage cloud resources using a declarative configuration language. Instead of clicking through the AWS console or writing complex API calls, you write code that describes your desired infrastructure, and Terraform handles all the API calls and sequencing needed to make it happen.

Terraform solves problems that are encountered using API, AWS Console and AWS CLI by:
- Using declarative code (describe what you want, not how to create it)
- Maintaining state (knows what exists and what needs to change)
- Being idempotent (safe to run multiple times)
- Managing dependencies automatically
- Supporting version control
- Enabling code reuse through modules

Find Terraform Documentations at (https://developer.hashicorp.com/terraform/docs)

Terraform uses the HashiCorp Configuration Language (HCL) to actually build out the resources as code that can be run over powershell or Gitbash (on windows).
This README.MD will cover building VPC with Terraform

### This repo contains the building blocks of Terraform using TheoWAF directory and Terraform Registry for Resource codes used to build Terraform.

First, need to ensure prerequisites are met
**For Windows users:** You should run Git Bash as an administrator. 

Run this command: 
```bash
curl https://raw.githubusercontent.com/aaron-dm-mcdonald/Class7-notes/refs/heads/main/101825/check.sh | bash
```

If you get a revocation error, run this instead:
```bash
curl --ssl-no-revoke https://raw.githubusercontent.com/aaron-dm-mcdonald/Class7-notes/refs/heads/main/101825/check.sh | bash
```
The script will create the TheoWAF folder structure if needed and will download a .gitignore file configured for Terraform projects.

Ensure Terraform is running updated version 6.

Clone Theo's repo and create `auth.tf` and `main.tf` files
Open VS Code (or using Gitbash, go to the location of the created files and type "code ." enter).

Using the Terraform Registry and locating the specific Resource codes, build out the .tf files in Visual Studio (VS)

### Authentication

Terraform uses the same authentication mechanisms as the AWS CLI. Common methods:

1. **AWS CLI profile** (recommended for local development) - stored in `~/.aws/credentials`
2. **Environment variables** - `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
3. **IAM roles** (recommended for CI/CD and production)

Terraform automatically uses whatever credentials are available in your environment.

Find AWS Provider Authentication documentation at (https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)

## Basic Terraform Workflow 

```bash
# Initialize working directory: downloads provider plugins, generates lock file, etc
terraform init

# Validate HCL syntax and configuration (check your "grammar", not if it "makes sense" otherwise known as semantically correct)
terraform validate

# Show execution plan: preview what will change
terraform plan

# Apply changes: actually create/modify/destroy infrastructure
terraform apply

# Destroy all resources managed by this configuration
terraform destroy
```

**Typical workflow:**
1. Write or modify `.tf` files
2. Run `terraform validate` to check syntax
3. Run `terraform plan` to see what will change
4. Review the plan carefully
5. Run `terraform apply` to make the changes
6. Terraform updates the state file automatically

Find Terraform CLI Commands at (https://developer.hashicorp.com/terraform/cli/commands)

## Additional Terraform documents can be found below:
- [Getting Started with Terraform and AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
- [Terraform Language Reference](https://developer.hashicorp.com/terraform/language)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### Key terms:

- **IaC (Infrastructure as Code):** The practice of managing infrastructure through code rather than manual configuration. Terraform is an IaC tool that allows us to write code that interacts with cloud provider APIs.

- **Terraform:** An open-source IaC tool created by HashiCorp for cloud automation. Cloud agnostic (works with AWS, Azure, GCP, etc. "multicloud environment"), widely used, simple declarative language, and extensive community support.

- **State:** A JSON file (`terraform.tfstate`) that keeps track of what infrastructure Terraform is managing, the current attributes of each resource, and metadata. This is how Terraform knows what already exists vs. what needs to be created or changed. **Never manually edit this file.**

- **Provider:** A plugin that enables Terraform to interact with a specific cloud platform or service. In our case, we use the AWS provider to interact with AWS APIs in "TF Init".

- **HCL (HashiCorp Configuration Language):** Terraform's declarative configuration language. More human-readable than JSON. While primarily declarative (you describe what you want), it includes some procedural features like loops and conditionals.

- **Idempotency:** A critical property of Terraform; running `terraform apply` multiple times with the same configuration produces the same result. Terraform won't recreate or modify resources unless your code changes or state drift is detected.

- **Resource:** A block of HCL code that defines infrastructure to create in the cloud, like a VPC or EC2 instance. Each resource has a type and configuration parameters.

- **Execution Plan:** Generated by `terraform plan`, this shows exactly what Terraform will do before it does it; what resources will be created, modified, or destroyed, and in what order. This is Terraform's "dry run" feature.

- **State Drift:** When the actual infrastructure in AWS differs from what's recorded in the Terraform state file. This can happen if someone manually changes resources in the console. Terraform can detect and correct drift using `terraform plan` and `terraform apply`.
