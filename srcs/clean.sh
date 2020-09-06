#!/usr/bin/env bash

echo "metalLB manifest delete"
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
