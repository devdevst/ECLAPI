#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip.deflate.compress.\(optional\)
header3=Accept:application\/json

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/networks

#Command
curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep -1 "Internet_Lan" | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat

temp=$(cat temp.dat)

sed -i -e "s/network1_id:/network1_id:${temp}/g" user_info.conf
sed -i -e "s/firewall_if1_nw:/firewall_if1_nw:${temp}/g" user_info.conf

curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep -1 "Vlan1" | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat

temp=$(cat temp.dat)

sed -i -e "s/network2_id:/network2_id:${temp}/g" user_info.conf
sed -i -e "s/firewall_if2_nw:/firewall_if2_nw:${temp}/g" user_info.conf

sed -i -e "s/server1_networks:/server1_networks:${temp}/g" user_info.conf
sed -i -e "s/server2_networks:/server2_networks:${temp}/g" user_info.conf
