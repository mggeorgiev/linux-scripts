#!/bin/shell
set -e

make_ca() {
    echo "Creating Self-Signed Root CA certificate and key"
    openssl req \
        -new \
        -nodes \
        -x509 \
        -keyout ca.key \
        -out ca.crt \
        -config ca.cnf \
        -extensions v3_req \
        -days 1826  # 5 years
}

make_int() {
    echo "Creating Intermediate CA certificate and key"
    openssl req \
        -new \
        -nodes \
        -keyout ca_int.key \
        -out ca_int.csr \
        -config ca-intermediate.cnf \
        -extensions v3_req
    openssl req -in ca_int.csr -noout -verify
    openssl x509 \
        -req \
        -CA ca.crt \
        -CAkey ca.key \
        -CAcreateserial \
        -in ca_int.csr \
        -out ca_int.crt \
        -extfile ca-intermediate.cnf \
        -extensions v3_req \
        -days 365 # 1 year
    openssl verify -CAfile ca.crt ca_int.crt
    echo "Creating CA chain"
    cat ca_int.crt ca.crt > ca.pem
}

make_server() {
    echo "Creating nginx-manager certificate and key"
    openssl req \
        -new \
        -nodes \
        -keyout server.key \
        -out server.csr \
        -config server.cnf
    openssl req -in server.csr -noout -verify
    openssl x509 \
        -req \
        -CA ca_int.crt \
        -CAkey ca_int.key \
        -CAcreateserial \
        -in server.csr \
        -out server.crt \
        -extfile server.cnf \
        -extensions v3_req \
        -days 365 # 1 year
    openssl verify -CAfile ca.pem server.crt
}

make_servers() {
    local name="${1:?Usage: make_server <server-name>}"

    echo "Creating ${name} certificate and key"
    openssl req \
        -new \
        -nodes \
        -keyout "${name}.key" \
        -out "${name}.csr" \
        -config "${name}.cnf"
    openssl req -in "${name}.csr" -noout -verify
    openssl x509 \
        -req \
        -CA ca_int.crt \
        -CAkey ca_int.key \
        -CAcreateserial \
        -in "${name}.csr" \
        -out "${name}.crt" \
        -extfile "${name}.cnf" \
        -extensions v3_req \
        -days 90
    openssl verify -CAfile ca.pem "${name}.crt"
    cat "${name}.crt" ca_int.crt > "${name}-fullchain.pem"
}

make_agents() {
    local name="${1:?Usage: make_agent <agent-name>}"

    echo "Creating ${name}-agent certificate and key"
    openssl req \
        -new \
        -nodes \
        -keyout "${name}-agent.key" \
        -out "${name}-agent.csr" \
        -config "${name}-agent.cnf"
    openssl req -in "${name}-agent.csr" -noout -verify
    openssl x509 \
        -req \
        -CA ca_int.crt \
        -CAkey ca_int.key \
        -CAcreateserial \
        -in "${name}-agent.csr" \
        -out "${name}-agent.crt" \
        -extfile "${name}-agent.cnf" \
        -extensions v3_req \
        -days 90
    openssl verify -CAfile ca.pem "${name}-agent.crt"
}

names=(
    pi201.belovo
    pi202.belovo
)

# MAIN
#make_ca
#make_int
#make_server
#make_agent

for name in "${names[@]}"; do
    make_servers "$name"
    make_agents "$name"

    #Copy certs
    scp "${name}.crt" "${name}.key" "${name}-fullchain.pem" ca.pem "${name}-agent.crt" "${name}-agent.key" "${name}":~/certs/
done

#source https://docs.nginx.com/nginx-instance-manager/system-configuration/secure-traffic/