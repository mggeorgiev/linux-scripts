#!/bin/bash
myRepository="d-infra.sofia:5000"
myImage="pekarnaudoma"
tag=":latest"
deploymentName="pekarnaudoma"
kubectl set image deployment/${deploymentName} ${deploymentName}=${myRepository}/${myImage}:${tag}
