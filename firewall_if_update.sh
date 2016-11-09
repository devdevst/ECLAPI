#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"


#Body
tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
firewall_if1_id=$(cat user_info.conf | grep firewall_if1_id | sed -e 's/firewall_if1_id://'g)
firewall_if1_nw=$(cat user_info.conf | grep firewall_if1_nw | sed -e 's/firewall_if1_nw://'g)
firewall_if2_id=$(cat user_info.conf | grep firewall_if2_id | sed -e 's/firewall_if2_id://'g)
firewall_if2_ip=$(cat user_info.conf | grep firewall_if2_ip | sed -e 's/firewall_if2_ip://'g)
firewall_if2_nw=$(cat user_info.conf | grep firewall_if2_nw | sed -e 's/firewall_if2_nw://'g)
cidr=$(cat user_info.conf | grep cidr | sed -e 's/cidr://'g)
a=${cidr}
b=$(echo $a | sed -e 's/[0-9]*\.//'g)
c=`expr $b + 3`
firewall_if1_ip=$(echo $a | sed -e "s/\.${b}$/\.${c}/"g)

#Command
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/firewall_interfaces\/${firewall_if1_id}
curl -X PUT -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{
  "firewall_interface": {
    "ip_address": "'${firewall_if1_ip}'",
    "network_id": "'${firewall_if1_nw}'"
  }
}' https://${endpoint}.${api}

sleep 300;

#Command
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/firewall_interfaces\/${firewall_if2_id}
curl -X PUT -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
-d '
{
  "firewall_interface": {
    "ip_address": "'${firewall_if2_ip}'",
    "network_id": "'${firewall_if2_nw}'"
  }
}' https://${endpoint}.${api}
