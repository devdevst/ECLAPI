

#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/public_ips

#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
public_ip_name=$(cat user_info.conf | grep public_ip_name | sed -e 's/public_ip_name://'g)
public_ip_submask_length=$(cat user_info.conf | grep public_ip_submask_length | sed -e 's/public_ip_submask_length://'g)
gateway_id=$(cat user_info.conf | grep gateway_id | sed -e 's/gateway_id://'g)

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{"public_ip": {"description": "ApiGIP","internet_gw_id": "'${gateway_id}'","name": "'${public_ip_name}'","submask_length": '${public_ip_submask_length}',"tenant_id": "'${tenant_ID}'"}}' https://${endpoint}.${api}
