#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: manage_app.sh <create | delete>"
    exit $# 
fi
echo $#

if [ "$1" == "create" ]; then
	echo "Installing bookinfo application" 
	kubectl apply -f <(./istio-1.0.3/bin/istioctl kube-inject -f ./istio-1.0.3/samples/bookinfo/platform/kube/bookinfo.yaml)
	echo "Define the Ingress Gateway Routing for the application"
	kubectl apply -f ./istio-1.0.3/samples/bookinfo/networking/bookinfo-gateway.yaml

	echo "Validate the ingress gateway configuration" 
	kubectl get svc istio-ingressgateway -n istio-system

	echo "Configure the environment variables to access various services" 

	echo "Ingress host IP Address: $INGRESS_HOST"
	echo "export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" >> config.txt
	echo "Ingress port: $INGRESS_PORT"
	echo "export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')" >> config.txt
	echo "Secure Ingress port: $SECURE_INGRESS_PORT"
	echo "export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')" >> config.txt
	echo "Gateway URL: $GATEWAY_URL"
	echo "export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT" >> config.txt

	echo "Using curl to access the product page application"
	curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
	curl http://${GATEWAY_URL}/productpage
elif [ "$1" == "delete" ]; then
	echo "Delete the ingress gateway" 
	kubectl delete -f ./istio-1.0.3/samples/bookinfo/networking/bookinfo-gateway.yaml

	echo "Delete the book info application" 
	kubectl delete -f ./istio-1.0.3/samples/bookinfo/platform/kube/bookinfo.yaml
    unset GATEWAY_URL
	unset SECURE_INGRESS_PORT
	unset INGRESS_PORT
	unset INGRESS_HOST
fi
