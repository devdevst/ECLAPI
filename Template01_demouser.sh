./token_get.sh || ./token_get.sh

./internetgw_create.sh || ./internetgw_create.sh
sleep 15;

./internetgw_list.sh || ./internetgw_list.sh
sleep 15;

./publicip_create.sh || ./publicip_create.sh
sleep 15;

./publicip_list.sh || ./publicip_list.sh
sleep 15;

./network_create.sh || ./network_create.sh
sleep 30;

./network_list.sh || ./network_list.sh 
sleep 30;

./subnet_create.sh || ./subnet_create.sh
sleep 30;

./firewall_create.sh || ./firewall_create.sh
sleep 30;

./firewall_if_list.sh || ./firewall_if_list.sh
sleep 15;

./firewall_list.sh || ./firewall_list.sh
sleep 600;

./firewall_if_update.sh || ./firewall_if_update.sh
sleep 30;

./server_create.sh || ./server_create.sh
sleep 15;

./internetgw_if_create.sh || ./internetgw_if_create.sh

cp user_info.conf_origin user_info.conf
