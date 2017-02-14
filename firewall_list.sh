#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip.deflate.compress.\(optional\)
header3=Accept:application\/json

#API
endpoint=network-hk1-ecl.api.ntt.com
api=\/v2.0\/firewalls

#Command
curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep '"id"' | sed -e 's/      "id": "//'g | sed -e 's/",//'g > temp.dat

temp=$(cat temp.dat)

sed -i -e "s/firewall_id:/firewall_id:${temp}/g" user_info.conf
