#!/bin/bash

your-registry-server=""
your-name="Martin Georgiev"
your-pword="" 
your-email="mggeorgiev@gmail.com"

kubectl create secret docker-registry regcred \
                      --docker-server="${your-registry-server}" \
                      --docker-username="${your-name>}" \
                      --docker-password="${your-pword}" \
                      --docker-email="${your-email}"
