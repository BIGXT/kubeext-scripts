###########################################
##
## Copyright (2019,) Institute of Software
##       Chinese Academy of Sciences
##        wuheng@otcaix.iscas.ac.cn  
##
##########################################

VERSION="2.7.1"
DATAPATH="/mnt/registry"

echo "docker run -d --name registry --restart=always -p 5000:5000 -v $DATAPATH:/var/lib/registry registry:$VERSION"
docker run -d --name dev.registry --restart=always -p 5000:5000 -v $DATAPATH:/var/lib/registry registry:$VERSION
