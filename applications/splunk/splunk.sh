#!/bin/bash
sudo /opt/splunk/bin/splunk stop
sudo dpkg -i /shared/Splunk/splunk-*
#wget -O splunk-8.0.0-1357bef0a7f6-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.0&product=splunk&filename=splunk-8.0.0-1357bef0a7f6-linux-2.6-amd64.deb&wget=true'
sudo /opt/splunk/bin/splunk start --accept-license --answer-yes
