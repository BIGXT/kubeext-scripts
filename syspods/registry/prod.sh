###########################################
##
## Copyright (2019,) Institute of Software
##       Chinese Academy of Sciences
##        wuheng@otcaix.iscas.ac.cn  
##
##########################################

VERSION="2.7.1"
KEYNAME="domain"
KEYPATH="/etc/registry"
DATAPATH="/mnt/registry"
USER="admin"
PWD="admin"
HOST="iscas-registry.local"

## generate .cer and .key
rm -rf $KEYPATH
mkdir -p $KEYPATH

openssl req -newkey rsa:4096 -nodes -sha256 -keyout $KEYPATH/$KEYNAME.key -x509 -days 36500 -out $KEYPATH/$KEYNAME.crt -subj "/C=CN/ST=BeiJing/L=ChaoYang/O=CAS/OU=IS/CN=$HOST"

## generate username and password
## unsupport
#  docker run --entrypoint htpasswd registry:$VERSION -Bbn $USER $PWD > $KEYPATH/htpasswd

## generate ca.crt

#openssl req -new -x509 -key /etc/registry/domain.key -out ca.crt -days 36500
mkdir -p /etc/docker/certs.d/$HOST:443
cp $KEYPATH/$KEYNAME.crt /etc/docker/certs.d/$HOST:443/ca.crt

# --restart=always

echo "docker run -d --name prod.registry -v $KEYPATH:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$KEYNAME.crt -e REGISTRY_HTTP_TLS_KEY=/certs/$KEYNAME.key -p 443:443 -v $DATAPATH:/var/lib/registry registry:$VERSION"

# docker run -d --name prod.registry --hostname $HOST -v $KEYPATH:/auth -e "REGISTRY_AUTH=htpasswd" -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" -e REGISTRY_AUTH_HTPASSWD_PATH=$KEYPATH/htpasswd  -v $KEYPATH:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$KEYNAME.crt -e REGISTRY_HTTP_TLS_KEY=/certs/$KEYNAME.key -v $DATAPATH:/var/lib/registry -p 443:443 registry:$VERSION

docker run -d --name prod.registry --hostname $HOST -v $KEYPATH:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$KEYNAME.crt -e REGISTRY_HTTP_TLS_KEY=/certs/$KEYNAME.key -v $DATAPATH:/var/lib/registry -p 443:443 registry:$VERSION
