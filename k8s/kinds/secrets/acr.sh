#!/bin/bash

<<<<<<< HEAD
#source /path/to/file
#yourregistryserver="martingeorgiev.azurecr.io"
#yourname="martingeorgiev"
=======
source acr.cfg
#yourregistry-server=""
#yourname="Martin Georgiev"
>>>>>>> 2c0722643eddb235417d579ab5ce4ea745051b25
#yourpword="" 
#youremail="mggeorgiev@gmail.com"
#namespace="default"

kubectl create secret docker-registry regcred \
                      --namespace "${namespace}" \
                      --docker-server="${yourregistryserver}" \
                      --docker-username="${yourname}" \
                      --docker-password="${yourpword}" \
                      --docker-email="${youremail}"
