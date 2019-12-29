#!/bin/bash

sudo cp /etc/webmin/letsencrypt-key.pem /Shared/CERT/letsencrypt/
sudo cp /etc/webmin/letsencrypt-cert.pem /Shared/CERT/letsencrypt/
sudo cp /etc/webmin/letsencrypt-ca.pem /Shared/CERT/letsencrypt/

#sudo cp /Shared/CERT/letsencrypt/letsencrypt-key.pem /etc/webmin/
#sudo cp /Shared/CERT/letsencrypt/letsencrypt-cert.pem /etc/webmin/
#sudo cp /Shared/CERT/letsencrypt/letsencrypt-ca.pem /etc/webmin/
