#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/networks

#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
network1_name=$(cat user_info.conf | grep network1_name | sed -e 's/network1_name://'g)
network1_type=$(cat user_info.conf | grep network1_type | sed -e 's/network1_type://'g)
network2_name=$(cat user_info.conf | grep network2_name | sed -e 's/network2_name://'g)
network2_type=$(cat user_info.conf | grep network2_type | sed -e 's/network2_type://'g)

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{"network": {"admin_state_up": true,"description": "Example network 1 description.","name": "'${network1_name}'","plane": "'${network1_type}'","tags": {"keyword1": "value1","keyword2": "value2"},"tenant_id": "'${tenant_ID}'"}}' https://${endpoint}.${api}

curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{"network": {"admin_state_up": true,"description": "Example network 2 description.","name": "'${network2_name}'","plane": "'${network2_type}'","tags": {"keyword1": "value1","keyword2": "value2"},"tenant_id": "'${tenant_ID}'"}}' https://${endpoint}.${api}

