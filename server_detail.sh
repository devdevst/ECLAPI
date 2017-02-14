#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip.deflate.compress.\(optional\)
header3=Accept:application\/json

#API
endpoint=nova-hk1-ecl.api.ntt.com
api=\/v2\/7cddcf9feee94db695a1df96688c3b6d\/servers/detail

#Command
curl -X GET -v \
-H "${header3}" \
-H "${header2}" \
-H "${header1}" \
https://${endpoint}.${api}
