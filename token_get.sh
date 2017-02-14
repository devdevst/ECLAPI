tenant_ID=$(cat user_info.conf | grep tenant_ID | sed -e 's/tenant_ID://'g)
api_key=$(cat user_info.conf | grep api_key | sed -e 's/api_key://'g)
api_secret_key=$(cat user_info.conf | grep api_secret_key | sed -e 's/api_secret_key://'g)

curl -i \
 -H "Content-Type: application/json" \
 -d ' 
{
   "auth": {
       "identity": {
           "methods": [
               "password"
           ],
           "password": {
               "user": {
                   "domain": {
                       "id": "default"
                   },
                   "name": "'${api_key}'",
                   "password": "'${api_secret_key}'"
             }
           }
       },
       "scope": {
           "project": {
               "id": "'${tenant_ID}'"
           }
       }
   }
}' https://keystone-hk1-ecl.api.ntt.com/v3/auth/tokens \
| grep X-Subject-Token | sed -e 's/X-Subject-Token: //'g > token.txt
