#!/bin/bash

#source /path/to/file
#your-registry-server=""
#your-name="Martin Georgiev"
#your-pword="" 
#your-email="mggeorgiev@gmail.com"
#namespace=""

kubectl create secret docker-registry regcred \
                      --namespace "${namespace}" \
                      --docker-server="${your-registry-server}" \
                      --docker-username="${your-name>}" \
                      --docker-password="${your-pword}" \
                      --docker-email="${your-email}"
