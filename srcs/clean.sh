#!/usr/bin/env bash

# Delete the namespace
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

DIR=`dirname "$0"`
kubectl delete -f "$DIR/nginx/nginx.yaml"
kubectl delete -f "$DIR/ftp/ftp.yaml"


eval $(minikube docker-env)
docker image prune -af
eval $(minikube docker-env -u)

#minikube stop
#minikube delete
