# Setup

> :information_source: _Note: This will create resources in your Joyent account for which you will be charged for._

1. Clone this repo, open a terminal, and change directory to the repo location.
1. Download and install [Terraform](https://www.terraform.io/downloads.html).
1. Download and run [sdc-docker-setup.sh](https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh) 
to generate required certificates for Prometheus to connect to [Triton Container Monitor](https://docs.joyent.com/public-cloud/api/prometheus).
1. Copy the file `terraform.tfvars.example` to `terraform.tfvars` in this directory and edit the variable values to the paths 
to your SSH key for your Joyent account and the paths to the certificates created in the previous setup.
1. Set the required environment variables `SDC_URL`, `SDC_ACCOUNT`, and `SDC_KEY_ID` in your terminal as described in 
[Set Up your CLI](https://apidocs.joyent.com/cloudapi/#set-up-your-cli). 
1. Execute `terraform init`.
1. Execute `terraform apply` and enter `yes` when prompted to make the changes.
1. Once the apply finishes, open the `grafana_address` value from the output in your browser. Enter `admin` as the 
username and `admin` as the password when prompted.
1. In Grafana navigate to the _Triton Cloud_ dashboard.

# Teardown

> :warning: Note: This will destroy previously created resources and you will lose any associated data._

1. Execute `terraform destroy` and enter `yes` when prompted to make the changes.
