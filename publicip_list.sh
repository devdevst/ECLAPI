#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip.deflate.compress.\(optional\)
header3=Accept:application\/json

#API
endpoint=network-jp1-ecl.api.ntt.com
api=\/v2.0\/public_ips

#Command
curl -X GET \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api} | grep cidr | sed -e 's/      "cidr": "//'g | sed -e 's/",//'g > temp.dat

temp=$(cat temp.dat)
sed -i -e "s/cidr:/cidr:${temp}/g" user_info.conf

