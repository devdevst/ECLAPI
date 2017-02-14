#Header
token=$(cat token.txt)
header1=X-Auth-Token:${token}
header2=Accept-Encoding\:gzip deflate compress \(optional\)
header3=Accept: application\/json
header4="Content-Type: application/json"

#Command
curl -X PUT -v \
-H "${header1}" \
-H "${header2}" \
-H "${header3}" \
-H "${header4}" \
https://glance-hk1-ecl.api.ntt.com/v2/images/a8f0d31c-6c2d-445d-9c08-5b015f0609f6/file --upload-file test.qcow2
