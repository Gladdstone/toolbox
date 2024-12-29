#!/bin/bash
# kind clusters do not support load balancer services by default
# this can affect ingress and gateway functionality

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml
kubectl apply -f metallb.yaml

# Currently metallb does not have gateway support, so when testing/running gateway cilium
# or an alternative is required.
# Note: Gateway CRDs must be installed prior to Cilium, as it has a dependency on the GatewayAPI
# kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.2.1/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
# helm repo add cilium https://helm.cilium.io/
# helm upgrade --install cilium cilium/cilium --version 1.13.0 \
#   --namespace kube-system \
#   --set kubeProxyReplacement=strict \
#   --set gatewayAPI.enabled=true


