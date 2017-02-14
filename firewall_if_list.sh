#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip.deflate.compress.\(optional\)
header3=Accept:application\/json

#API
endpoint=network-hk1-ecl.api.ntt.com
api=\/v2.0\/firewall_interfaces

#Command
curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep '"slot_number": 1' -B 4 | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat
temp=$(cat temp.dat)
sed -i -e "s/firewall_if1_id:/firewall_if1_id:${temp}/g" user_info.conf

curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep '"slot_number": 2' -B 4 | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat
temp=$(cat temp.dat)
sed -i -e "s/firewall_if2_id:/firewall_if2_id:${temp}/g" user_info.conf

curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep '"slot_number": 3' -B 4 | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat
temp=$(cat temp.dat)
sed -i -e "s/firewall_if3_id:/firewall_if3_id:${temp}/g" user_info.conf

curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep '"slot_number": 4' -B 4 | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat
temp=$(cat temp.dat)
sed -i -e "s/firewall_if4_id:/firewall_if4_id:${temp}/g" user_info.conf
