#!/bin/bash
myRepository="d-infra.sofia:5000"
myImage="martingeorgiev"
tag=":latest"
deploymentName="martingeorgiev"
kubectl create deployment ${deploymentName} --image=${myRepository}/${myImage}:${tag}
#kubectl scale deployment ${deploymentName} --replicas=3
kubectl autoscale deployment ${deploymentName} --cpu-percent=80 --min=1 --max=5
kubectl expose deployment ${deploymentName} --name=${deploymentName}-service --type=LoadBalancer --port 80 --target-port 8080