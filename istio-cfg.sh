#!/bin/bash

ISTIO_DIR=/Users/vvenkatara/Documents/ISTIO/istio-1.0.2

if [ "$#" -eq 0 ]; then
   echo "Usage: istio-cfg <cmd: istio-core | install_crds | create_namespace> <namespace name>"
   exit 1
fi

if [ "$1" = "install_crds" ]; then 
    echo "Creating Kubernetes cluster..."
    exit
    (cd $ISTIO_DIR && kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml)
elif [ "$1" = "create_namespace" ]; then
    if [ "$#" -ne 2 ]; then
      echo "Usage: istio-cfg create_namespace <namespace name>"
      exit 1
    fi
    echo "Creating namespace $2..."
    exit
    kubectl create namespace vv15-istio 
    kubectl label namespace vv15-istio istio-injection=enabled
elif [ "$1" == "istio-core" ]; then
    echo "Installing Istio core components" 
	kubectl apply -f install/kubernetes/istio-demo-auth.yaml
else
    echo "Error. Please check usage. " \
         "Usage: istio-cfg <cmd: install_crds | create_namespace> <namespace name>"
fi
