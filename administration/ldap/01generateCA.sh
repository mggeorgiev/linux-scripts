#!/bin/bash

######################
# Become a Certificate Authority
######################

# Generate private key
openssl genrsa -des3 -out /etc/ssl/private/myCA.key 2048
# Generate root certificate
openssl req -x509 -new -nodes -key /etc/ssl/private/myCA.key -sha256 -days 825 -out /etc/ssl/certs/myCA.crt -subj "/CN=u-srv.sofia/C=BG/L=Sofia"

#openssl req -x509 -new -nodes -key myCA.key -sha256 -days $days -out myCA.pem