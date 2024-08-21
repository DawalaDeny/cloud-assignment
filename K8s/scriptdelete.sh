#!/bin/bash
kubectl delete -f .
kubectl delete -f ./k8-deployments
kubectl delete -f ./k8-services