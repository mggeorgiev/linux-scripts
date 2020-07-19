#!/bin/bash

microk8s.enable dns dashboard ingress

ifconfig

microk8s kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
microk8s.kubectl proxy --accept-hosts=.* --address=0.0.0.0 &

#https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
#http://allin.sofia:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
