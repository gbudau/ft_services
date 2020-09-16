#!/usr/bin/env sh

# Delete the namespace
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

DIR=`dirname "$0"`
kubectl delete -f "$DIR/nginx/nginx.yaml"
kubectl delete -f "$DIR/ftp/ftp.yaml"
kubectl delete -f "$DIR/mysql/mysql.yaml"


docker rmi my-nginx:latest
docker rmi my-ftp:latest
docker rmi my-mysql:latest

#minikube stop
#minikube delete
