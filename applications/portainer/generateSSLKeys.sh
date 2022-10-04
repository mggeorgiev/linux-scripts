#!/bin/bash

#openssl genrsa -out rootCA.key 4096

#openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt

server_name=""

openssl req -x509 \
            -sha256 -days 1024 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=d-infra.sofia/C=BG/L=Sofia" \
            -keyout rootCA.key -out rootCA.crt

openssl genrsa -subj -out d-infra.sofia.key 2048
openssl req -new -sha256 -key d-infra.sofia.key -subj "/C=BG/ST=CA/O=martingeorgiev.com, Inc./CN=d-infra.sofia" -out d-infra.sofia.csr
openssl req -in d-infra.sofia.csr -noout -text

openssl x509 -req -in d-infra.sofia.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out d-infra.sofia.csr -days 500 -sha256

openssl x509 -in d-infra.sofia.csr -text -noout


### generate portainer ###
openssl genrsa -out portainer.key 2048
openssl req -new -sha256 -key portainer.key -subj "/C=BG/ST=CA/O=martingeorgiev.com, Inc./CN=d-infra.sofia" -out portainer.csr

### verify the contents of the csr ###
openssl req -in portainer.csr -noout -text

### generate the cert ###

openssl x509 -req -in portainer.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out portainer.crt -days 500 -sha256


docker run -d -p 9443:9443 -p 9000:9000 \
    --name portainer --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    -v $(pwd):/certs \
    portainer/portainer-ce \
    --sslcert /certs/portainer.crt \
    --sslkey /certs/portainer.key

# openssl genrsa -out portainer.key 2048
# # openssl ecparam -genkey -name secp384r1 -out portainer.key
# # openssl req -new -x509 -sha256 -key portainer.key -out portainer.crt -days 365

# # openssl req -x509 \
# #             -sha256 -days 365 \
# #             -nodes \
# #             -newkey rsa:2048 \
# #             -subj "/CN=d-infra.sofia/C=BG/L=Sofia" \
# #             -keyout rootCA.key -out rootCA.crt

# cat > csr.conf <<EOF
# [ req ]
# default_bits = 2048
# prompt = no
# default_md = sha256
# req_extensions = req_ext
# distinguished_name = dn

# [ dn ]
# C = BG
# ST = California
# L = Sofia
# O = Sofia
# OU = infra
# CN = d-infra.sofia

# [ req_ext ]
# subjectAltName = @alt_names

# [ alt_names ]
# DNS.1 = d-infra.sofia
# IP.1 = 192.168.88.46

# EOF

# openssl req -new -key portainer.key -out portainer.crt -config csr.conf

# cat > cert.conf <<EOF
# authorityKeyIdentifier=keyid,issuer
# basicConstraints=CA:FALSE
# keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
# subjectAltName = @alt_names

# [alt_names]
# DNS.1 = d-infra.sofia

# EOF

# openssl x509 -req \
#     -in portainer.key \
#     -CA rootCA.crt -CAkey rootCA.key \
#     -CAcreateserial -out portainer.crt \
#     -days 365 \
#     -sha256 -extfile cert.conf

# openssl x509 \
#     -in portainer.key \
#     -CA rootCA.crt -CAkey rootCA.key \
#     -CAcreateserial -out portainer.crt \
#     -days 365 \
#     -sha256 -extfile cert.conf

# openssl genrsa -des3 -out rootCA.key 4096
# openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt
# openssl req -x509 \
#             -sha256 -days 365 \
#             -nodes \
#             -newkey rsa:2048 \
#             -subj "/CN=d-infra.sofia/C=BG/L=Sofia" \
#             -keyout rootCA.key -out rootCA.crt