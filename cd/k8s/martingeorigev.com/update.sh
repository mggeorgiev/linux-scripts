#!/bin/bash
myRepository="d-infra.sofia:5000"
myImage="martingeorgiev"
tag=":latest"
deploymentName="martingeorgiev"
kubectl set image deployment/${deploymentName} ${deploymentName}=${myRepository}/${myImage}:${tag}
