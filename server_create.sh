#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"


#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
server1_name=$(cat user_info.conf | grep server1_name | sed -e 's/server1_name://'g)
server1_flavorRef=$(cat user_info.conf | grep server1_flavorRef | sed -e 's/server1_flavorRef://'g)
server1_imageRef=$(cat user_info.conf | grep server1_imageRef | sed -e 's/server1_imageRef://'g)
server1_networks=$(cat user_info.conf | grep server1_networks | sed -e 's/server1_networks://'g)
server2_name=$(cat user_info.conf | grep server2_name | sed -e 's/server2_name://'g)
server2_flavorRef=$(cat user_info.conf | grep server2_flavorRef | sed -e 's/server2_flavorRef://'g)
server2_imageRef=$(cat user_info.conf | grep server2_imageRef | sed -e 's/server2_imageRef://'g)
server2_networks=$(cat user_info.conf | grep server2_networks | sed -e 's/server2_networks://'g)

#API
endpoint=nova-hk1-ecl.api.ntt.com
api=\/v2\/${tenant_ID}\/servers

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{
"server": {"min_count":1, "flavorRef": "'${server1_flavorRef}'","name": "'${server1_name}'","imageRef": "'${server1_imageRef}'", "max_count": 1,
 "networks": [{"uuid": "'${server1_networks}'", "fixed_id": ""}]}
}' https://${endpoint}.${api}

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{
"server": {"min_count":1, "flavorRef": "'${server2_flavorRef}'","name": "'${server2_name}'","imageRef": "'${server2_imageRef}'", "max_count": 1,
 "networks": [{"uuid": "'${server2_networks}'", "fixed_id": ""}]}
}' https://${endpoint}.${api}
