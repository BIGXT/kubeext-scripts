#!/bin/bash

kubectl apply -f common.yaml
sleep 2
kubectl apply -f operator.yaml
sleep 2
kubectl apply -f cluster.yaml
sleep 2
kubectl get pods -n rook-ceph