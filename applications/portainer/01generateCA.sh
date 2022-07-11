#!/bin/bash

######################
# Become a Certificate Authority
######################
days=825

# Generate private key
openssl genrsa -des3 -out myCA.key 2048
# Generate root certificate
#openssl req -x509 -new -nodes -key myCA.key -sha256 -days $days -out myCA.pem -subj "/CN=d-infra.sofia/C=BG/L=Sofia"
openssl req -x509 -new -nodes -key myCA.key -sha256 -days $days -out myCA.crt -subj "/CN=d-infra.sofia/C=BG/L=Sofia"

#openssl req -x509 -new -nodes -key myCA.key -sha256 -days $days -out myCA.pem