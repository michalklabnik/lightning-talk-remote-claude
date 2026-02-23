# Hetzner Cloud VM
# cx43 in Helsinki — Tailscale-only access, firewall blocks all inbound

# ---------------------------------------------------------------------------
# Data Sources
# ---------------------------------------------------------------------------

resource "hcloud_ssh_key" "jajsem_ed25519" {
  name       = "jajsem_ed25519"
  public_key = file("${var.ssh_public_key_path}/id_ed25519.pub")
}

# ---------------------------------------------------------------------------
# Cloud-Init
# ---------------------------------------------------------------------------

locals {
  ssh_public_keys = [for f in fileset(var.ssh_public_key_path, "*.pub") : trimspace(file("${var.ssh_public_key_path}/${f}"))]

  hetzner_cloud_init = templatefile("${path.root}/cloud-init/cloud-init.yaml.tftpl", {
    tailscale_auth_key = var.tailscale_auth_key
    username           = var.vm_username
    ssh_public_keys    = local.ssh_public_keys
    github_token       = var.github_token
    azure_sp_tenant    = var.azure_sp_tenant
    azure_sp_appid     = var.azure_sp_appid
    azure_sp_password  = var.azure_sp_password
    ntfy_channel       = var.ntfy_channel
    bash_aliases       = file("${path.root}/cloud-init/bash_aliases")
  })
}

# ---------------------------------------------------------------------------
# Firewall — blocks all inbound, outbound allowed by default
# ---------------------------------------------------------------------------

# Workaround: hcloud provider skips SetRules API when zero rule blocks exist
# (d.GetOk("rule") returns false). Always keep at least one dummy rule.
resource "hcloud_firewall" "main" {
  name = "hetzner-hel1-cx43-fw"

  # Dummy rule — allows ICMP from localhost only (no real traffic)
  # Ensures provider always calls SetRules API
  rule {
    direction   = "in"
    protocol    = "icmp"
    source_ips  = ["127.0.0.1/32"]
    description = "dummy rule — hcloud provider workaround"
  }

  dynamic "rule" {
    for_each = var.enable_ssh_firewall && length(var.admin_ips) > 0 ? [1] : []
    content {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = var.admin_ips
    }
  }

  labels = {
    managed_by = "opentofu"
  }
}

resource "hcloud_firewall_attachment" "main" {
  firewall_id = hcloud_firewall.main.id
  server_ids  = [hcloud_server.main.id]
}

# ---------------------------------------------------------------------------
# Server
# ---------------------------------------------------------------------------

resource "hcloud_server" "main" {
  name        = "hetzner-hel1-cx43"
  server_type = "cx43"
  image       = "ubuntu-24.04"
  location    = "hel1"

  ssh_keys  = [hcloud_ssh_key.jajsem_ed25519.id]
  user_data = local.hetzner_cloud_init

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  backups                  = false
  shutdown_before_deletion = true

  labels = {
    managed_by = "opentofu"
    location   = "hel1"
    type       = "cx43"
  }
}

# ---------------------------------------------------------------------------
# Outputs
# ---------------------------------------------------------------------------

output "hetzner_vm_name" {
  description = "Name of the Hetzner server"
  value       = hcloud_server.main.name
}

output "hetzner_vm_ipv4" {
  description = "Public IPv4 address of the Hetzner server"
  value       = hcloud_server.main.ipv4_address
}

output "hetzner_vm_ipv6" {
  description = "Public IPv6 address of the Hetzner server"
  value       = hcloud_server.main.ipv6_address
}

output "hetzner_vm_status" {
  description = "Current status of the Hetzner server"
  value       = hcloud_server.main.status
}
