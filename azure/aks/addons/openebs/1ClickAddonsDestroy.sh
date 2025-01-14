#!/bin/bash
set -e
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"

export KUBE_CONFIG_PATH=~/.kube/config
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

echo "openebs/1ClickAddonsDestroy.sh: coping variable files"
cp -f ../../../variables.tf .
cp -f ../../../terraform.tfvars .

terraform init
terraform refresh

export KUBE_CONFIG_PATH=~/.kube/config
echo "openebs/1ClickAddonsDestroy.sh Terraform Destroy"
terraform destroy -auto-approve
