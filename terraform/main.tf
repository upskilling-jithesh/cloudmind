name: Terraform CI

on:
  push:
    branches:
      - main
      - 'feature/**'
  pull_request:
    branches:
      - main

jobs:
  terraform:
    name: Terraform Format Validate and Plan
    runs-on: ubuntu-latest

    steps:
      # Step 1 - Pull code from GitHub
      - name: Checkout code
        uses: actions/checkout@v4

      # Step 2 - Install Terraform on pipeline runner
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.12.0
          cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}

      # Step 3 - Check formatting
      # Fails if code is not properly formatted
      - name: Terraform Format Check
        run: terraform fmt -check -recursive
        working-directory: terraform

      # Step 4 - Initialize
      # Downloads AWS provider + connects to Terraform Cloud
      - name: Terraform Init
        run: terraform init
        working-directory: terraform

      # Step 5 - Validate
      # Checks syntax is correct
      - name: Terraform Validate
        run: terraform validate
        working-directory: terraform

      # Step 6 - Plan
      # Shows what will change on AWS
      # Runs on PR so you can review before merge
      - name: Terraform Plan
        run: terraform plan
        working-directory: terraform