#!/bin/bash

#source /path/to/file
#yourregistryserver="martingeorgiev.azurecr.io"
#yourname="martingeorgiev"
#yourpword="" 
#youremail="mggeorgiev@gmail.com"
#namespace="default"

kubectl create secret docker-registry regcred \
                      --namespace "${namespace}" \
                      --docker-server="${yourregistryserver}" \
                      --docker-username="${yourname}" \
                      --docker-password="${yourpword}" \
                      --docker-email="${youremail}"
