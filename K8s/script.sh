#!/bin/bash
kubectl apply -f .
kubectl apply -f ./k8-deployments
kubectl apply -f ./k8-services