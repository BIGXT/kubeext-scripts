## 1. Background

In our design, the OS includes Docker, kubernetes, and you can get the packages by yourself.
Note that you should first disable selinux and firewalld of your OS.

| Name       | Version |  Packages  |   
| ------     | ------  | ------ |
| Docker     | 18.09   | [redhat](https://docs.docker.com/install/linux/docker-ee/rhel/), [SUSE](https://docs.docker.com/install/linux/docker-ee/suse/), [centos](https://docs.docker.com/install/linux/docker-ce/centos/), [debian](https://docs.docker.com/install/linux/docker-ce/debian/), [fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) |
| Kubernetes | 1.13.3  | [redhat/CentOS/SUSE/fedora](https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.x86_64.rpm), [ubuntu/debian](https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.amd64.deb) |

updated: 2019-2-28

## 2. Steps

If you want to deploy the above softwares on CentOS 7, you can follow the steps.

### 2.1 Prerequisite


2.1.1 disable selinux (vi /etc/selinux/config)

```
SELINUX=(enforcing --> disabled)
```

2.1.2 copy all the *.repo you needs to the path ``/etc/yum.repos.d/''

2.1.3 disable firewalld
```
systemctl stop firewalld
systemctl disable firewalld
```
2.1.4 enable iptables
```
echo "1" >> /proc/sys/net/bridge/bridge-nf-call-iptables
```

### 2.2 Install Docker

```
yum install docker-ce
systemctl start docker 
systemctl enable docker
```

### 2.3 Install Kubernetes

```
yum install kubeadm kubectl kubelet
systemctl start kubelet 
systemctl enable kubelet
```

Next, please see project [syspods](https://github.com/kubesys/kube-syspods) to complete installation.
