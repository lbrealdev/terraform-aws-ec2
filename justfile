# Format Terraform files in place
@fmt:
    terraform fmt -write=true -recursive

# Init (no backend) then validate — matches CI validate path
@validate:
    terraform init -backend=false
    terraform validate

# Initialize Terraform (providers / modules / backend)
@init *ARGS:
    terraform init {{ ARGS }}

# Scaffold terraform.tfvars from examples/<profile>.tfvars.example (default: ec2)
use-config profile="ec2":
    #!/usr/bin/env bash
    set -euo pipefail
    src="examples/{{ profile }}.tfvars.example"
    if [ ! -f "$src" ]; then
        echo "Unknown profile: {{ profile }}"
        echo "Available:"
        ls examples/*.tfvars.example
        exit 1
    fi
    if [ -f terraform.tfvars ]; then
        echo "terraform.tfvars already exists — remove it first or edit in place."
        exit 1
    fi
    cp "$src" terraform.tfvars
    echo "Created terraform.tfvars from $src — edit it before plan/apply."

# Create a plan and save it to ./plan
@plan *ARGS:
    terraform plan -out plan {{ ARGS }}

# Apply the saved ./plan file
@apply:
    terraform apply plan

# Plan a destroy, then confirm before applying it
@destroy *ARGS:
    terraform plan -destroy -out destroy {{ ARGS }}
    just _destroy-apply

[confirm("Destroy all Terraform-managed resources? This cannot be undone.")]
@_destroy-apply:
    terraform apply destroy

# Remove local Terraform artifacts (does not destroy cloud resources)
[confirm("Remove local .terraform / plan / state artifacts? Cloud resources are not destroyed.")]
@cleanup:
    rm -rf .terraform
    rm -f plan destroy crash.log crash.*.log *.tfstate *.tfstate.*
    echo "Local Terraform artifacts removed."

# CI workflow hygiene (zizmor + pinact verify)
[working-directory('.github')]
@ci-scan:
    zizmor dependabot.yml ./workflows/*.yml
    pinact run --verify ./workflows/*.yml

# Pin GitHub Actions to immutable SHAs
[working-directory('.github')]
@ci-pin:
    pinact run ./workflows/*.yml
