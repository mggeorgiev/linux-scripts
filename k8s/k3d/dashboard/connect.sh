#!/bin/bash

echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
export KUBECONFIG="$(k3d get-kubeconfig --name='mycluster')"
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token
kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'