#!/bin/bash

kubectl -n rook-ceph delete cephcluster rook-ceph
sleep 2
kubectl delete -f operator.yaml
kubectl delete -f common.yaml
