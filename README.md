# Cloud Resume Challenge - Eoghan O'Neill

A modern, interactive resume website showcasing cloud engineering skills and experience. Built with HTML, CSS, and JavaScript, deployed on Azure Static Web Apps with infrastructure managed by Terraform.

## Features

- Modern, responsive design with dark theme
- Interactive cursor spotlight effect
- Particle system background
- Animated skill bars and typing effects
- Visitor counter using Azure Functions and CosmosDB
- Infrastructure as Code using Terraform
- CI/CD pipelines for automated deployment

## Project Structure

```
.
├── Website/                 # Frontend application
│   ├── index.html          # Main landing page
│   ├── resume.html         # Resume page
│   └── assets/             # Static assets
├── AzureFunction/          # Backend API
│   ├── function_app.py     # Visitor counter function
│   └── requirements.txt    # Python dependencies
├── Terraform/              # Infrastructure as Code
│   ├── main.tf            # Main Terraform configuration
│   ├── variables.tf       # Variable definitions
│   └── outputs.tf         # Output definitions
└── .github/               # GitHub Actions workflows
    └── workflows/         # CI/CD pipeline definitions
```

## Prerequisites

- Azure subscription
- Azure CLI installed
- Terraform installed (v1.0.0+)
- GitHub account
- Azure DevOps account (optional, for Azure DevOps pipelines)

## Local Development Setup

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/cloud-resume.git
cd cloud-resume
```

2. Initialize Terraform:
```bash
cd Terraform
terraform init
```

3. Create a `terraform.tfvars` file with your Azure configuration:
```hcl
subscription_id = "your-subscription-id"
tenant_id       = "your-tenant-id"
client_id       = "your-client-id"
client_secret   = "your-client-secret"
```

4. Apply the Terraform configuration:
```bash
terraform plan
terraform apply
```

## CI/CD Pipeline Setup

### Option 1: GitHub Actions

1. Create the following secrets in your GitHub repository:
   - `AZURE_CREDENTIALS`: JSON object containing Azure service principal credentials
   - `COSMOSDB_CONNECTION_STRING`: Connection string for CosmosDB
   - `AZURE_STATIC_WEB_APP_TOKEN`: Deployment token for Azure Static Web Apps

2. The pipeline will:
   - Build and test the Azure Function
   - Deploy infrastructure using Terraform
   - Deploy the static website
   - Deploy the Azure Function

### Option 2: Azure DevOps

1. Create a new pipeline in Azure DevOps
2. Connect to your GitHub repository
3. Use the following YAML configuration:

```yaml
trigger:
  - main

variables:
  - group: azure-credentials
  - name: terraformVersion
    value: '1.0.0'

stages:
  - stage: Build
    jobs:
      - job: BuildAndTest
        pool:
          vmImage: 'ubuntu-latest'
        steps:
          - task: UsePythonVersion@0
            inputs:
              versionSpec: '3.9'
          
          - script: |
              python -m pip install --upgrade pip
              pip install -r AzureFunction/requirements.txt
              pip install pytest
            displayName: 'Install dependencies'
          
          - script: |
              pytest AzureFunction/test_function_app.py
            displayName: 'Run tests'

  - stage: DeployInfrastructure
    jobs:
      - job: Terraform
        pool:
          vmImage: 'ubuntu-latest'
        steps:
          - task: TerraformInstaller@0
            inputs:
              terraformVersion: $(terraformVersion)
          
          - task: TerraformTaskV3@3
            inputs:
              provider: 'azurerm'
              command: 'init'
              workingDirectory: '$(System.DefaultWorkingDirectory)/Terraform'
          
          - task: TerraformTaskV3@3
            inputs:
              provider: 'azurerm'
              command: 'apply'
              workingDirectory: '$(System.DefaultWorkingDirectory)/Terraform'
              environmentServiceNameAzureRM: 'your-azure-subscription'

  - stage: DeployApplication
    jobs:
      - job: DeployStaticWebApp
        pool:
          vmImage: 'ubuntu-latest'
        steps:
          - task: AzureStaticWebApp@0
            inputs:
              app_location: 'Website'
              api_location: 'AzureFunction'
              output_location: ''
              azure_static_web_apps_api_token: $(AZURE_STATIC_WEB_APP_TOKEN)
```

## Infrastructure Deployment

The Terraform configuration will create:

1. Resource Group
2. CosmosDB account and database
3. Azure Function App
4. Azure Static Web App
5. Application Insights
6. Storage Account for Terraform state

### Terraform State Management

For production environments, use Azure Storage Account for Terraform state:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstate<UNIQUE_SUFFIX>"
    container_name      = "tfstate"
    key                 = "resume.terraform.tfstate"
  }
}
```

## Monitoring and Analytics

- Application Insights for Azure Function monitoring
- CosmosDB metrics for database performance
- Azure Static Web App analytics for website usage

## Security Considerations

1. Enable HTTPS only
2. Implement CORS policies
3. Use managed identities where possible
4. Store secrets in Azure Key Vault
5. Regular security updates for dependencies

## Cost Optimization

- Use consumption plan for Azure Function
- Enable auto-shutdown for development resources
- Use CosmosDB autoscale
- Implement caching strategies

## Troubleshooting

Common issues and solutions:

1. **Terraform State Lock**
   ```bash
   terraform force-unlock <LOCK_ID>
   ```

2. **Azure Function Deployment Issues**
   - Check function logs in Azure Portal
   - Verify application settings
   - Check Python version compatibility

3. **Static Web App Deployment**
   - Verify build configuration
   - Check route configuration
   - Validate API routes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Azure Static Web Apps](https://docs.microsoft.com/en-us/azure/static-web-apps)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions) 