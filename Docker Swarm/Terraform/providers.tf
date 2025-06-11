terraform {
  required_version = ">= 1.12.0"
  required_providers {

    proxmox = {
      source  = "telmate/proxmox"
      version = "= 3.0.2-rc01"
    }
  }
}

terraform {
  required_version = ">= 1.12.0"
  required_providers {

    proxmox = {
      source  = "telmate/proxmox"
      version = "= 3.0.2-rc01"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure     = true  
  pm_api_url          = var.pm_api_url        # The Proxmox URL
  pm_api_token_id     = var.pm_api_token_id   # The Proxmox Terraform APIUser ID
  pm_api_token_secret = var.pm_token_secret   # The Proxmox Terraform APIUser secret
}