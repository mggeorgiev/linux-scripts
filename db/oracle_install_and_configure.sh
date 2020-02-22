#!/bin/bash

#Create Oracle user
sudo adduser oracle
sudo passwd oracle

#upgrade the system
sudo yum upgrade -y

#install text editor
sudo yum insyall nano -y

#install mount toos
sudo yum install cifs-utils -y

#install pre-requisites for apache tomcat and sqlplus
#sudo yum install java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 mc net-tools.x86_64 htop iotop iftop unzip wget epel-release -y
#sudo yum install rlwrap -y

#sudo systemctl start chronyd
#sudo systemctl enable chronyd

#Set the firewall

#sudo firewall-cmd --permanent --new-service=oracle-db
#sudo firewall-cmd --permanent --service=oracle-db --set-short="Oracle Database Listener" --add-port=1521/tcp
#sudo firewall-cmd --permanent --zone=public --add-service=http
#sudo firewall-cmd --permanent --zone=public --add-service=https
#sudo firewall-cmd --permanent --zone=public --add-service=oracle-db
#sudo firewall-cmd --reload

#Installing of Apache Tomcat and Apache httpd
#sudo yum install tomcat httpd -y

#enable services
#sudo systemctl start tomcat
#sudo systemctl enable tomcat
#sudo systemctl start httpd
#sudo systemctl enable httpd

#install Oracle DB
sudo yum localinstall /shared/Oracle/oracle-database-preinstall-18c* -y
sudo yum localinstall /shared/Oracle/oracle-database-xe-18c* -y

#configure the database
sudo /etc/init.d/oracle-xe-18c configure

#
sudo echo '# setting oracle database environment variables and aliases' >> /etc/profile.d/oraenv.sh
sudo echo 'ORACLE_SID=XE' >> /etc/profile.d/oraenv.sh
sudo echo 'ORAENV_ASK=NO' >> /etc/profile.d/oraenv.sh
sudo echo 'ORACLE_HOME=/opt/oracle/product/18c/dbhomeXE' >> /etc/profile.d/oraenv.sh
sudo echo 'ORACLE_BASE=/opt/oracle' >> /etc/profile.d/oraenv.sh
sudo echo 'PATH=$PATH:/opt/oracle/product/18c/dbhomeXE/bin'  >> /etc/profile.d/oraenv.sh
sudo echo '. /usr/local/bin/oraenv -s' >> /etc/profile.d/oraenv.sh
sudo echo 'alias sqlplus="rlwrap sqlplus"' >> /etc/profile.d/oraenv.sh
sudo echo 'alias rman="rlwrap rman"' >> /etc/profile.d/oraenv.sh
sudo . /etc/profile.d/oraenv.sh


#install APEX
sudo mkdir -p /opt/oracle/apex
sudo unzip /shared/Oracle/apex_18.*.zip -d /opt/oracle
sudo chown -R oracle:oinstall /opt/oracle/apex

#copy APEX static files 
sudo mkdir -p /var/www/apex/images
sudo cp -a /opt/oracle/apex/images/. /var/www/apex/images

#install ords
#sudo mkdir -p /opt/oracle/ords
#sudo unzip /shared/Oracle/ords-18.*.zip -d /opt/oracle/ords

#
#cd /opt/oracle/ords
#java -jar ords.war install advanced
