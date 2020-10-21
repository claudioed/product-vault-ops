#!/bin/bash

helm repo add hashicorp https://helm.releases.hashicorp.com

kubectl create ns vault
sleep 1
helm install vault hashicorp/vault --set "server.dev.enabled=true" --namespace vault