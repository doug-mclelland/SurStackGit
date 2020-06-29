##buildsuv.sh

## open firewall
ufw allow ssh
ufw allow http
ufw allow https
ufw allow 17171/tcp
ufw allow 8091/tcp

## update the os
apt update -y
apt upgrade -y

