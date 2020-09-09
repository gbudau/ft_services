#!/usr/bin/env bash

# Delete the namespace
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

kubectl delete svc nginx
kubectl delete deploy nginx-deployment

#minikube stop
#minikube delete
