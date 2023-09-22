#!/bin/bash

# Create a kind cluster
kind create cluster --name kind

# Waits for the cluster to be ready before proceeding
kubectl wait --namespace kube-system --for=condition=Ready pod -l component=controller-manager

# Check that the cluster is up and running
kubectl get nodes 
