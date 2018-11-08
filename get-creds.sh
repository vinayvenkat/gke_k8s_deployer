#!/bin/bash 

if [ "$#" -ne 3 ]; then
    echo "Usage: get-creds.sh <cluster name> <zone> <project id>"
    exit 2
fi
echo $#

gcloud container clusters get-credentials $1 \
    --zone $2 \
    --project $3

#gcloud config set container/use_client_certificate True
