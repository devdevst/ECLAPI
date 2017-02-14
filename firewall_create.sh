#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#API
endpoint=network-hk1-ecl.api.ntt.com
api=\/v2.0\/firewalls

#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
firewall_plan_id=$(cat user_info.conf | grep firewall_plan_id | sed -e 's/firewall_plan_id://'g)
firewall_name=$(cat user_info.conf | grep firewall_name | sed -e 's/firewall_name://'g)

cidr=$(cat user_info.conf | grep cidr | sed -e 's/cidr://'g)
a=${cidr}
b=$(echo $a | sed -e 's/[0-9]*\.//'g)
c=`expr $b + 1`
firewall_gateway=$(echo $a | sed -e "s/\.${b}$/\.${c}/"g)

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{"firewall": {"availability_zone": "zone1-groupa","default_gateway": "'${firewall_gateway}'","description": "via api fw","firewall_plan_id": "'${firewall_plan_id}'","name": "'${firewall_name}'","tenant_id": "'${tenant_ID}'"}}' https://${endpoint}.${api}
