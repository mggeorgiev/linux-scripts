#!/bin/bash

source k8ssecret.sh

kubectl create secret docker-registry $SECRET_NAME
  --docker-server "${REGISTRY_NAME}.azurecr.io"
  --docker-email $YOUR_MAIL
  --docker-username=${SERVICE_PRINCIPAL_ID}
  --docker-password ${YOUR_PASSWORD}