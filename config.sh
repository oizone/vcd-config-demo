#!/bin/bash
APIVER=34.0
#echo "Enter Cloud Director URL name: "
#read HOST
#echo "Enter Cloud Director IP(blank to resolve using URL): "
#read IP
#echo "Enter Cloud Director username: "
#read USER
echo "Enter Cloud Director password: "
read -s PASSWD

HOST=$1
USER=$2

PASS=`echo -n ${USER}@system:${PASSWD} |base64`

KEY=`curl -I --header "Accept: application/*;version="${APIVER} --header "Authorization: Basic "${PASS} --request POST https://${HOST}/api/sessions|grep X-VMWARE-VCLOUD-ACCESS-TOKEN|cut -d ":" -f 2`


curl --header "Accept: application/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT -d @brand.json -H "Content-Type: application/json" https://${HOST}/cloudapi/branding/


curl --header "Accept: image/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT -d @tietoevry-logo.png -H "Content-Type: image/png" https://${HOST}/cloudapi/branding/logo

curl --header "Accept: image/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT -d @tietoevry-icon.png -H "Content-Type: image/png" https://${HOST}/cloudapi/branding/icon

