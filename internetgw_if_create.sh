#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/gw_interfaces

#Body
network1_id=$(cat user_info.conf | grep network1_id | sed -e 's/network1_id://'g)
gateway_id=$(cat user_info.conf | grep gateway_id | sed -e 's/gateway_id://'g)
public_ip_submask_length=$(cat user_info.conf | grep public_ip_submask_length | sed -e 's/public_ip_submask_length://'g)

cidr=$(cat user_info.conf | grep cidr | sed -e 's/cidr://'g)
a=${cidr}
b=$(echo $a | sed -e 's/[0-9]*\.//'g)
c=`expr $b + 1`
d=`expr $b + 4`
e=`expr $b + 5`
gw_vipv4=$(echo $a | sed -e "s/\.${b}$/\.${c}/"g)
primary_ipv4=$(echo $a | sed -e "s/\.${b}$/\.${d}/"g)
secondary_ipv4=$(echo $a | sed -e "s/\.${b}$/\.${e}/"g)

#Command
curl -X POST -v -H "${header1}" -H "${header2}" -H "${header3}" -H "${header4}" -d '
{ "gw_interface": { "internet_gw_id": "'${gateway_id}'", "gw_vipv4": "'${gw_vipv4}'", "name": "API-IW-GW", "netmask": '${public_ip_submask_length}', "network_id": "'${network1_id}'", "primary_ipv4": "'${primary_ipv4}'", "secondary_ipv4": "'${secondary_ipv4}'", "service_type": "internet", "vrid": 1 } }
' https://${endpoint}.${api}

