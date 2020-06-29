##buildsuv.sh

## open firewall
ufw allow ssh, http, https, 17171, 8091

## update the os
apt update -y
apt upgrade -y

