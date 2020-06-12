#!/bin/bash
myRepository="d-infra.sofia:5000"
myImage="martingeorgievinfo"
tag=":latest"
deploymentName="martingeorgievinfo"
kubectl set image deployment/${deploymentName} ${deploymentName}=${myRepository}/${myImage}:${tag}
