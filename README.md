# Setup

> :information_source: _Note: This will create resources in your Joyent account for which you will be charged for._

1. Download and install [Terraform](https://www.terraform.io/downloads.html).
1. Download and run [sdc-docker-setup.sh](https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh) to generate required certificates for Prometheus to connect to CMON.
1. Copy `terraform.tfvars.example` to `terraform.tfvars` in this directory and edit the variables values to the paths to your SSH key for your Joyent and account and the paths to the certificates created in the previous setup.
1. Set the required environment variables `SDC_URL`, `SDC_ACCOUNT`, and `SDC_KEY_ID`. 
1. Execute `terraform init`.
1. Execute `terraform apply` and type `yes` when prompted to make the changes.

# Teardown

> :warning: Note: This will destroy previously created resources and you will lose any associated data._

1. Execute `terraform destroy` and type `yes` when prompted to make the changes.
