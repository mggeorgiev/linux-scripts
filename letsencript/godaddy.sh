#!/bin/bash

# This script is used to check and update your GoDaddy DNS server 
# with the TXT _acme-challenge record
# Special thanks to mfox for his ps script
# https://github.com/markafox/GoDaddy_Powershell_DDNS
# and TheBelcherman
# https://tinyurl.com/yxubdmnu
#
# First go to GoDaddy developer site 
# to create a developer account and get your key and secret
# https://developer.godaddy.com/getstarted
# Be aware that there are 2 types of key and secret - 
# one for the test server and one for the production server
# Get a key and secret for the production server
# 
# Enter vaules for all variables, Latest API call requries them.

domain="martingeorgiev.info"        # your domain
type="TXT"                # Record type A, CNAME, MX, etc.
name="_acme-challenge"    # name of record to update
ttl="600"                 # Time to Live min value 600
port="1"                  # Required port, Min value 1
weight="1"                # Required weight, Min value 1
key=$1                    # key for godaddy developer API
secret=$2                 # secret for godaddy developer API

headers="Authorization: sso-key $key:$secret"

echo $headers

result=$(curl -s -X GET -H "$headers" \
 "https://api.godaddy.com/v1/domains/$domain/records/$type/$name")

echo $result

if [ -z "$1" ];
then
	echo "Empty input!"
else
	echo "Updating $name record with $1"
	curl -X PUT "https://api.godaddy.com/v1/domains/$domain/records/$type/$name" \
-H "accept: application/json" \
-H "Content-Type: application/json" \
-H "$headers" \
-d "[ { \"data\": \"$1\", \"name\": \"$name\", \"port\": $port, \"priority\": 0, \"protocol\": \"string\", \"service\": \"string\", \"ttl\": $ttl, \"type\": \"$type\", \"weight\": $weight } ]"

fi