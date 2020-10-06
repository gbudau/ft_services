#!/usr/bin/env sh

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
docker build -t my-ftps srcs/ftps
docker build -t my-mysql srcs/mysql
docker build -t my-phpmyadmin srcs/phpmyadmin
docker build -t my-wordpress srcs/wordpress
docker build -t my-influxdb srcs/influxdb
docker build -t my-grafana srcs/grafana
docker build -t my-telegraf srcs/telegraf

# Load configs
kubectl apply -k srcs/config/
kubectl apply -k srcs/

# Activate dashboard
#minikube dashboard
