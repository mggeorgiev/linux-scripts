#!/bin/bash

######################
# Create CA-signed certs
######################

# NAME="fqdn"
read -p "Enter fqdn: " NAME
#IP="10.0.0.2"
read -p "Enter IP: " IP

# Generate a private key
openssl genrsa -out cd /etc/ldap/$NAME.key 2048
# Create a certificate-signing request
openssl req -new -key cd /etc/ldap/$NAME.key -out cd /etc/ldap/$NAME.csr -subj "/CN=${NAME}/C=BG/L=Sofia"
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

openssl x509 -req -in /etc/ldap/$NAME.csr -CA /etc/ssl/certs/myCA.crt -CAkey /etc/ssl/private/myCA.key -CAcreateserial -out /etc/ldap/$NAME.crt -days 825 -sha256 -extfile $NAME.ext

openssl verify -CAfile myCA.pem -verify_hostname $NAME $NAME.crt