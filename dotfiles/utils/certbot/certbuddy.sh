#!/bin/bash
FQDN=$1

get_cert(){
    cd ~/ssl
    sudo certbot certonly --manual --preferred-challenges dns -d $FQDN
}

rocket(){
    get_cert
    sudo cp /etc/letsencrypt/live/$FQDN/fullchain.pem $FQDN/
    sudo cp /etc/letsencrypt/live/$FQDN/privkey.pem $FQDN/
    docker restart nginx
}

rocket
