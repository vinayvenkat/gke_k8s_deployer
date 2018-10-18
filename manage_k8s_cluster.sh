#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: manage_k8s_cluster.sh <create | delete> <cluster name> <zone> <project id>"
    exit 2
fi
echo $#

if [ "$1" = "create" ]; then 
    echo "Creating the K8's cluster"
    gcloud container clusters create $2 \
        --cluster-version=1.10.7-gke.6 \
        --zone $3 \
        --project $4 \
        --no-enable-legacy-authorization
elif [ "$1" = "delete" ]; then
    echo "Deleting the K8's cluster"
    gcloud container clusters delete $2 \
    --zone $3 \
    --project $4
else
    echo "Error usage. Please check your command..." \
         "Usage: manage_k8s_cluster.sh <create | delete> <cluster name> <zone> <project id>"
fi
