# Infrastructure

Two VMs provisioned via OpenTofu — Hetzner Cloud (x86) and Oracle Cloud (ARM, free tier). Access exclusively via Tailscale.

## Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) 1.11.5
- Hetzner Cloud account + API token
- Oracle Cloud account + API key
- Tailscale account + auth key (reusable, pre-approved)

## Setup

```bash
cp terraform.tfvars.example terraform.tfvars
```

Fill in `terraform.tfvars`:

| Variable               | Where to get it                                                          |
|------------------------|--------------------------------------------------------------------------|
| `hcloud_token`         | https://console.hetzner.cloud/ > Project > Security > API Tokens         |
| `oci_fingerprint`      | https://cloud.oracle.com/ > Profile > My profile > API keys              |
| `oci_private_key_path` | Path to OCI API private key PEM (generated with API key above)           |
| `oci_tenancy_ocid`     | https://cloud.oracle.com/ > Profile > Tenancy                            |
| `oci_user_ocid`        | https://cloud.oracle.com/ > Profile > My profile                         |
| `tailscale_auth_key`   | https://login.tailscale.com/admin/settings/keys (reusable, pre-approved) |
| `github_token`         | https://github.com/settings/tokens (classic or fine-grained)             |
| `azure_sp_appid`       | `az ad sp create-for-rbac` output > `appId`                              |
| `azure_sp_password`    | `az ad sp create-for-rbac` output > `password`                           |
| `azure_sp_tenant`      | `az ad sp create-for-rbac` output > `tenant`                             |

## Deploy

```bash
tofu init
tofu plan
tofu apply
```

## Connect

After `tofu apply`, VMs auto-register to your Tailscale network. Connect via:

```bash
ssh claude@<tailscale-hostname-or-ip>
```

## Destroy

```bash
tofu destroy
```
