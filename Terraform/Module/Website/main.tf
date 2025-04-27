resource "azurerm_static_web_app" "static_web_app" {
  name                = var.static_web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
  tags                = var.tags
}

# Create a custom domain for the Static Web App
resource "azurerm_static_web_app_custom_domain" "custom_domain" {
  static_web_app_id = azurerm_static_web_app.static_web_app.id
  domain_name       = var.domain_name
  validation_type   = "dns-txt-token"
}

# Create the DNS TXT record for domain validation
resource "azurerm_dns_txt_record" "validation" {
  name                = "_dnsauth.${var.domain_name}"
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
  ttl                 = var.dns_ttl
  
  record {
    value = azurerm_static_web_app_custom_domain.custom_domain.validation_token
  }
}

# Create the DNS CNAME record pointing to the Static Web App
resource "azurerm_dns_cname_record" "app" {
  name                = var.subdomain_prefix  # "www" or "" for root domain
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
  ttl                 = var.dns_ttl
  record              = azurerm_static_web_app.static_web_app.default_host_name
}