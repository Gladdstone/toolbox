#!/bin/bash

k3d cluster local --port 4318:80@loadbalancer --registry-config registries.yaml
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack --namespace prometheus --create-namespace
helm install csi-secrets-store-provider-azure csi-secrets-store-provider-azure/csi-secrets-store-provider-azure --namespace kube-system

