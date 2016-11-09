der
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/subnets

#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
network1_id=$(cat user_info.conf | grep network1_id | sed -e 's/network1_id://'g)
network2_id=$(cat user_info.conf | grep network2_id | sed -e 's/network2_id://'g)
public_ip_submask_length=$(cat user_info.conf | grep public_ip_submask_length | sed -e 's/public_ip_submask_length://'g)
cidr=$(cat user_info.conf | grep cidr | sed -e 's/cidr://'g)
a=${cidr}
b=$(echo $a | sed -e 's/[0-9]*\.//'g)
c=`expr $b + 1`
d=`expr $b + 2`
gateway_ip=$(echo $a | sed -e "s/\.${b}$/\.${c}/"g)
nexthop=$(echo $a | sed -e "s/\.${b}$/\.${d}/"g)

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{ "subnet": { "cidr": "192.168.1.0/24", "description": "Example subnet 1 description.", "dns_nameservers": [ "8.8.8.8" ], "enable_dhcp": true, "gateway_ip": "192.168.1.1", "host_routes": [ { "destination": "192.168.1.0/24", "nexthop": "192.168.1.2" } ], "ip_version": 4, "name": "Example subnet 1", "network_id": "'${network1_id}'", "tags": { "keyword1": "value1", "keyword2": "value2" }, "tenant_id": "'${tenant_ID}'" }}' https://${endpoint}.${api}

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{ "subnet": { "cidr": "192.168.2.0/24", "description": "Example subnet 2 description.", "dns_nameservers": [ "8.8.8.8" ], "enable_dhcp": true, "gateway_ip": "192.168.2.1", "host_routes": [ { "destination": "192.168.2.0/24", "nexthop": "192.168.2.2" } ], "ip_version": 4, "name": "Example subnet 2", "network_id": "'${network2_id}'", "tags": { "keyword1": "value1", "keyword2": "value2" }, "tenant_id": "'${tenant_ID}'" }}' https://${endpoint}.${api}

#Command
curl -X POST -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{ "subnet": { "cidr": "'${cidr}/${public_ip_submask_length}'", "description": "Example subnet 3 description.", "dns_nameservers": [ "8.8.8.8" ], "enable_dhcp": true, "gateway_ip": "'${gateway_ip}'", "host_routes": [ { "destination": "'${cidr}/${public_ip_submask_length}'", "nexthop": "'${nexthop}'" } ], "ip_version": 4, "name": "Example subnet 3", "network_id": "'${network1_id}'", "tags": { "keyword1": "value1", "keyword2": "value2" }, "tenant_id": "'${tenant_ID}'" }}' https://${endpoint}.${api}
