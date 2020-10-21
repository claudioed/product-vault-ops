#!/bin/bash
kind create cluster --name tdc-secrets --config clusterconfig.yaml

kubectl cluster-info --context kind-tdc-secrets