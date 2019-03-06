FROM centos:7

MAINTAINER wuheng@otcaix.iscas.ac.cn

COPY ./node/10-ovs.conf.template \
     ./node/ovs \
     ./node/host-local \
     ./node/dhcp \
     ./node/loopback \
     ./node/cni.conf \
     ./node/ovs.py \
     /home/node/

WORKDIR /home/node

CMD ["/usr/bin/python", "ovs.py"]
