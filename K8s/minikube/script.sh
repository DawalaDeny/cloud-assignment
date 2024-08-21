#!/bin/bash
kubectl apply -f ConfigMap.yml
kubectl apply -f mongo-secret.yaml
kubectl apply -f mongo-deployment.yaml
kubectl apply -f mongo-service.yaml
sleep 5
kubectl apply -f back-end-deployment.yaml
kubectl apply -f back-end-service.yaml
kubectl apply -f front-end-deployment.yaml
kubectl apply -f front-end-service.yaml

##ssh -i "C:/Users/shabo/.ssh/DenyVaste" -L 32293:192.168.49.2:32293 -L 30669:192.168.49.2:30669 ubuntu@141.145.217.88