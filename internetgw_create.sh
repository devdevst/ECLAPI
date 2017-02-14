#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
internet_service_id=$(cat user_info.conf | grep internet_service_id | sed -e 's/internet_service_id://'g)
gateway_name=$(cat user_info.conf | grep gateway_name | sed -e 's/gateway_name://'g)
qos_option_id=$(cat user_info.conf | grep qos_option_id | sed -e 's/qos_option_id://'g)

#API
endpoint=network-hk1-ecl.api.ntt.com
api=\/v2.0\/internet_gateways

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{"internet_gateway": {"description": "Api internet gateway","internet_service_id": "'${internet_service_id}'","name": "'${gateway_name}'","qos_option_id": "'${qos_option_id}'","tenant_id": "'${tenant_ID}'"}}' https://${endpoint}.${api}
