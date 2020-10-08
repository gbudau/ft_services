#!/usr/bin/env bash

# Start minikube
echo "✨  Starting Minikube"
minikube start --driver=virtualbox --disk-size=5000mb

# Create secretkey for MetalLB
DIR=`dirname "$0"`
openssl rand -base64 128 > "$DIR/srcs/metallb/configs/secretkey" > /dev/null 2>&1

# Use Minikube's built-in Docker daemon
eval $(minikube docker-env)

# Build Docker Images
services=(nginx ftps mysql phpmyadmin wordpress influxdb grafana telegraf)
for service in "${services[@]}"; do
	title="$(tr '[:lower:]' '[:upper:]' <<< ${service:0:1})${service:1}"
	echo "🐳  Building Docker Image for ${title}"
	docker build -t "my-$service" "$DIR/srcs/$service" > /dev/null 2>&1
done

# Load Kubernetes Objects
echo "⚖️   Installing MetalLB"
kubectl apply -k "$DIR"/srcs/metallb/ > /dev/null 2>&1
echo "📋  Creating ConfigMaps"
kubectl apply -k "$DIR"/srcs/config/ > /dev/null 2>&1
echo "⛵  Creating Deployments"
kubectl apply -k "$DIR"/srcs/ > /dev/null 2>&1

# Delete MetalLB secretkey
rm -f "$DIR/srcs/metallb/configs/secretkey" > /dev/null 2>&1

# Activate the dashboard
echo "📊  Activating Minikube Dashboard"
minikube dashboard
