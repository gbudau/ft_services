#!/usr/bin/env sh

# Delete the namespace
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

# Delete other deployments
DIR=`dirname "$0"`
kubectl delete -k "$DIR"


docker rmi -f my-nginx:latest
docker rmi -f my-ftp:latest
docker rmi -f my-mysql:latest
docker rmi -f my-phpmyadmin:latest
docker rmi -f alpine:3.12

#minikube stop
#minikube delete
