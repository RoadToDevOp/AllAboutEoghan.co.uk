
# Resource Group Configuration
resource_group_name = "all-about-eoghan-rg"
location = "uksouth"  # Change to your preferred Azure region

# Existing Resources
Anchor_resource = "Anchor-Resources"  # Resource group containing your existing Key Vault and DNS Zone
key_vault_name = "AAEkeyvault"
dns_zone_name = "allabouteoghan.co.uk"  # Your existing DNS zone name

# Optional: Additional tags to merge with default tags
tags = {
  Owner       = "Eoghan O'Neill"
  Project     = "PersonalWebsite"
  CostCenter  = "Personal"
}