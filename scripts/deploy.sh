#!/bin/bash
kubectl create namespace wordpress || true
kubectl apply -n wordpress -f k8s/
echo "Deployment triggered. Check pods and services."