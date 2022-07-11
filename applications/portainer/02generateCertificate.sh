#!/bin/bash

######################
# Create CA-signed certs
######################

NAME="fqdn" # Use your own domain name
IP="10.0.0.2"
# Generate a private key
openssl genrsa -out $NAME.key 2048
# Create a certificate-signing request
openssl req -new -key $NAME.key -out $NAME.csr -subj "/CN=${NAME}/C=BG/L=Sofia"
# Create a config file for the extensions
>$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = bar.$NAME # Optionally, add additional domains (I've added a subdomain here)
IP.1 = $IP # Optionally, add an IP address (if the connection which you have planned requires it)
EOF

openssl x509 -req -in $NAME.csr -CA myCA.crt -CAkey myCA.key -CAcreateserial -out $NAME.crt -days 825 -sha256 -extfile $NAME.ext

openssl verify -CAfile myCA.pem -verify_hostname $NAME $NAME.crt