#!/bin/bash
APIVER=34.0
echo "Enter Cloud Director password: "
read -s PASSWD

HOST=$1
USER=$2

PASS=`echo -n ${USER}@system:${PASSWD} |base64`

KEY=`curl -I --header "Accept: application/*;version="${APIVER} --header "Authorization: Basic "${PASS} --request POST https://${HOST}/api/sessions|grep X-VMWARE-VCLOUD-ACCESS-TOKEN|cut -d ":" -f 2`


curl --header "Accept: application/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT -d @brand.json -H "Content-Type: application/json" https://${HOST}/cloudapi/branding/


curl --header "Accept: image/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT --data-binary @tietoevry-logo.png -H "Content-Type: image/png" https://${HOST}/cloudapi/branding/logo

curl --header "Accept: image/*;version=${APIVER}" --header "Authorization: Bearer ${KEY}" --request PUT --data-binary @te-logo-192.png -H "Content-Type: image/png" https://${HOST}/cloudapi/branding/icon

