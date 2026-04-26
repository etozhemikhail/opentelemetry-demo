# opentelemetry-demo on Yandex Cloud (VM + Docker Compose)

Terraform configuration in this directory provisions a single VM in Yandex Cloud and bootstraps the full `opentelemetry-demo` stack via `docker compose up -d --build`.

## Provisioned resources

- VPC network and subnet
- Security group with ingress for SSH and selected UI ports
- Service account with basic logging/monitoring roles
- Compute instance (public IP + cloud-init bootstrap)

## Prerequisites

- Terraform `>= 1.6.0`
- Yandex Cloud account with permission to create VPC, IAM, and Compute resources
- IAM token for provider authentication
- SSH public key

## Configure variables

1. Copy example values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit `terraform.tfvars`:
   - set `yc_cloud_id`, `yc_folder_id`, `yc_token`
   - set your `ssh_public_key`
   - restrict `allowed_cidrs` to your IP

You can also provide `yc_token` via environment variable:

```bash
export TF_VAR_yc_token="y0_AQAAAA..."
```

## Deploy

```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

After `apply`, Terraform prints:
- `frontend_url`
- `grafana_url`
- `jaeger_url`
- `vm_external_ip`

## Post-deploy checks

1. Wait 5-10 minutes for cloud-init bootstrap and image builds.
2. SSH into the VM:

```bash
ssh ubuntu@<vm_external_ip>
```

3. Verify bootstrap log:

```bash
sudo tail -n 100 /var/log/otel-demo-bootstrap.log
```

4. Verify containers:

```bash
cd /opt/opentelemetry-demo
docker compose ps
```

5. Open endpoints in browser:
   - `frontend_url`
   - `grafana_url`
   - `jaeger_url`

## Destroy

```bash
terraform destroy
```

## Notes

- Bootstrap builds some images locally (`--build`), so first start can be long.
- `allowed_cidrs = ["0.0.0.0/0"]` is insecure for production; use narrow CIDRs.
- This setup is intended for demo/sandbox workloads.
