 #!/bin/bash
 
sudo apt install gnutls-bin ssl-cert
sudo certtool --generate-privkey --bits 4096 --outfile /etc/ssl/private/mycakey.pem
#sudo nano /etc/ssl/ca.info
sudo certtool --generate-self-signed --load-privkey /etc/ssl/private/mycakey.pem --template /etc/ssl/ca.info --outfile /usr/local/share/ca-certificates/mycacert.crt
sudo update-ca-certificates
sudo certtool --generate-privkey --bits 2048 --outfile /etc/ldap/u-srv_slapd_key.pem
#sudo nano /etc/ssl/u-srv.info
sudo certtool --generate-certificate --load-privkey /etc/ldap/u-srv_slapd_key.pem --load-ca-certificate /etc/ssl/certs/mycacert.pem --load-ca-privkey /etc/ssl/private/mycakey.pem --template /etc/ssl/u-srv.info --outfile /etc/ldap/u-srv_slapd_cert.pem
sudo chgrp openldap /etc/ldap/u-srv_slapd_key.pem
sudo chmod 0640 /etc/ldap/u-srv_slapd_key.pem