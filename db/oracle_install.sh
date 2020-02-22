#!/bin/bash

#upgrade the system
sudo yum upgrade -y

#install text editor
sudo yum insyall nano -y

#install mount toos
sudo yum install cifs-utils -y

#Create Oracle user
sudo adduser oracle
sudo passwd oracle

#Set the firewall

sudo firewall-cmd --permanent --new-service=oracle-db
sudo firewall-cmd --permanent --service=oracle-db --set-short="Oracle Database Listener" --add-port=1521/tcp
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --permanent --zone=public --add-service=oracle-db
sudo firewall-cmd --permanent --zone=public --add-port=5500/tcp
sudo firewall-cmd --reload

#install Oracle DB
sudo yum localinstall /shared/Oracle/oracle-database-preinstall-18c* -y
sudo yum localinstall /shared/Oracle/oracle-database-xe-18c* -y

#configure the database
sudo /etc/init.d/oracle-xe-18c configure

sudo systemctl start oracle-xe-18c
sudo systemctl enable oracle-xe-18c

#
#sudo echo '# setting oracle database environment variables and aliases' >> /etc/profile.d/oraenv.sh
#sudo echo 'ORACLE_SID=XE' >> /etc/profile.d/oraenv.sh
#sudo echo 'ORAENV_ASK=NO' >> /etc/profile.d/oraenv.sh
#sudo echo 'ORACLE_HOME=/opt/oracle/product/18c/dbhomeXE' >> /etc/profile.d/oraenv.sh
#sudo echo 'ORACLE_BASE=/opt/oracle' >> /etc/profile.d/oraenv.sh
#sudo echo 'PATH=$PATH:/opt/oracle/product/18c/dbhomeXE/bin'  >> /etc/profile.d/oraenv.sh
#sudo echo '. /usr/local/bin/oraenv -s' >> /etc/profile.d/oraenv.sh
#sudo echo 'alias sqlplus="rlwrap sqlplus"' >> /etc/profile.d/oraenv.sh
#sudo echo 'alias rman="rlwrap rman"' >> /etc/profile.d/oraenv.sh
#sudo . /etc/profile.d/oraenv.sh

