#!/bin/bash
##terraform logs
nowtime=`date +"%m_%d_%Y_%s"`
(mkdir -p ./tflogs)
export TF_LOG="INFO"
export TF_LOG_PATH="./tflogs/terraform-$nowtime.log"
export KUBE_CONFIG_PATH=~/.kube/config

set -e
echo "1ClickAddons.sh: Running custom addons"
(bash ./custom/1ClickAddons.sh)

echo "1ClickAddons.sh: Running KSM addon"
(cd ksm; bash ./1ClickAddons.sh)

##option to disable openebs
echo "1ClickAddons.sh: openebs option: $1"
openebs=$1

if [[ "$1" == "openebs-disabled" ]]; then
    echo "openebs-disabled"
else
    echo "1ClickAddons.sh: Running OpenEBS addon"
    (cd openebs; bash ./1ClickAddons.sh)

fi
