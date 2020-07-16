#!/bin/bash

#source /path/to/file
#yourregistry-server=""
#yourname="Martin Georgiev"
#yourpword="" 
#youremail="mggeorgiev@gmail.com"
#namespace=""

kubectl create secret docker-registry regcred \
                      --namespace "${namespace}" \
                      --docker-server="${yourregistryserver}" \
                      --docker-username="${yourname}" \
                      --docker-password="${yourpword}" \
                      --docker-email="${youremail}"
