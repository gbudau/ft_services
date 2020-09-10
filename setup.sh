#!/usr/bin/env bash

# Start minikube
#minikube start --driver=virtualbox

# Install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/config.yaml

# Build images
eval $(minikube docker-env)
docker build -t my-nginx srcs/nginx
docker build -t my-ftp srcs/ftp
eval $(minikube docker-env -u)

# Load configs
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/ftp/ftp.yaml

# Activate dashboard
#minikube dashboard
