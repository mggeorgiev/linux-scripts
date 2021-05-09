#!/bin/bash

mkdir proxy
cd proxy/
touch Dockerfile
touch backend-not-found.html
touch default.conf
touch docker-compose.yml
mkdir includes
mkdir ssl
cd includes/
touch proxy.conf
touch ssl.conf

cd ..
targetFile="Dockerfile"
nginx="nginx:1.9"
cat << EOF >> $targetFile
FROM $nginx

#  default conf for proxy service
COPY ./default.conf /etc/nginx/conf.d/default.conf

# NOT FOUND response
COPY ./backend-not-found.html /var/www/html/backend-not-found.html

#  Proxy and SSL configurations
COPY ./includes/ /etc/nginx/includes/

# Proxy SSL certificates
COPY ./ssl/ /etc/ssl/certs/nginx/
EOF

# Update backend-not-found.html
targetFile="backend-not-found.html"
cat << EOF >> $targetFile
<html>
    <head>
        <title>Proxy Backend Not Found</title>
    </head>
    <body >
        <h2>Proxy Backend  Not Found</h2>
    </body>
</html>
EOF

# Update default.conf
targetFile="default.conf"
cat << EOF >> $targetFile
# web service1 config.
server {
    listen 80;
    listen 443 ssl http2;
    server_name d-infra.sofia;

    # Path for SSL config/key/certificate
    ssl_certificate /etc/ssl/certs/nginx/site1.crt;
    ssl_certificate_key /etc/ssl/certs/nginx/site1.key;
    include /etc/nginx/includes/ssl.conf;

    location /martingeorgievcom {
        include /etc/nginx/includes/proxy.conf;
        proxy_pass http://d-infra.sofia:8082;
    }

    access_log off;
    error_log  /var/log/nginx/error.log error;
}

# web service2 config.
server {
    listen 80;
    listen 443 ssl http2;
    server_name docker.sofia;

    # Path for SSL config/key/certificate
    ssl_certificate /etc/ssl/certs/nginx/site2.crt;
    ssl_certificate_key /etc/ssl/certs/nginx/site2.key;
    include /etc/nginx/includes/ssl.conf;

    location /excalidraw {
        include /etc/nginx/includes/proxy.conf;
        proxy_pass http://docker.sofia:5000;
    }

    access_log off;
    error_log  /var/log/nginx/error.log error;
}

# Default
server {
    listen 80 default_server;

    server_name _;
    root /var/www/html;

    charset UTF-8;

    error_page 404 /backend-not-found.html;
    location = /backend-not-found.html {
        allow   all;
    }
    location / {
        return 404;
    }

    access_log off;
    log_not_found off;
    error_log  /var/log/nginx/error.log error;
}
EOF

cd includes/

# Update proxy.conf
targetFile="proxy.conf"
cat << EOF >> $targetFile
proxy_set_header Host \$host;
proxy_set_header X-Real-IP \$remote_addr;
proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto \$scheme;
proxy_buffering off;
proxy_request_buffering off;
proxy_http_version 1.1;
proxy_intercept_errors on;
EOF

# Update proxy.conf
targetFile="ssl.conf"
cat << EOF >> $targetFile
ssl_session_timeout 1d;
ssl_session_cache shared:SSL:50m;
ssl_session_tickets off;

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-
ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-
SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-
GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-
AES128-SHAECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-
SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:
DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-
DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:
AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-
CBC3-SHA:!DSS';
ssl_prefer_server_ciphers on;
EOF

cd ../ssl

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout site1.key -out site1.crt
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout site2.key -out site2.crt
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout site3.key -out site3.crt

cd ..

# Update docker-compose.yml
targetFile="docker-compose.yml"
cat << EOF >> $targetFile
version: '2'
services:
proxy:
build: ./
networks:
- site1
- site2
ports:
- 80:80
- 443:443

networks:
site1:
external:
name: site1_default
site2:
external:
name: site2_default
EOF

# docker-compose build
# docker-compose up -d

# docker pull $nginx
# docker build -t reverse-proxy-nginx .
# docker run --name reverse-proxy-nginx -d reverse-proxy-nginx