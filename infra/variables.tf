variable "ssh_public_key_path" {
  description = "Path to directory containing SSH public keys (all *.pub files will be added)"
  type        = string
  default     = "ssh-key"
}

variable "tailscale_auth_key" {
  description = "Tailscale auth key for automatic network join (reusable, pre-approved)"
  type        = string
  sensitive   = true
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "oci_tenancy_ocid" {
  description = "Oracle Cloud tenancy OCID"
  type        = string
  sensitive   = true
}

variable "oci_user_ocid" {
  description = "Oracle Cloud user OCID"
  type        = string
  sensitive   = true
}

variable "oci_fingerprint" {
  description = "Oracle Cloud API key fingerprint"
  type        = string
  sensitive   = true
}

variable "oci_private_key_path" {
  description = "Path to Oracle Cloud API private key PEM file"
  type        = string
}

variable "oci_region" {
  description = "Oracle Cloud region (must be home region for free tier)"
  type        = string
  default     = "eu-frankfurt-1"
}

variable "vm_username" {
  description = "Non-root username created on VMs via cloud-init"
  type        = string
  default     = "claude"
}

variable "enable_ssh_firewall" {
  description = "Enable SSH inbound firewall rule for admin IPs"
  type        = bool
  default     = false
}

variable "admin_ips" {
  description = "List of admin IP addresses allowed to SSH into VMs (CIDR notation)"
  type        = list(string)
  default     = []
}

variable "github_token" {
  description = "GitHub personal access token for gh CLI authentication"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_sp_appid" {
  description = "Azure service principal application (client) ID"
  type        = string
  default     = ""
}

variable "azure_sp_password" {
  description = "Azure service principal password (client secret)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_sp_tenant" {
  description = "Azure tenant ID for service principal login"
  type        = string
  default     = ""
}

variable "ntfy_channel" {
  description = "ntfy.sh channel for cloud-init completion notifications"
  type        = string
  default     = "mk-remote-claude-zwoh3S"
}
