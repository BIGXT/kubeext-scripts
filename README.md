## 1. Background

  We assume you plan to run docker-based systems on CentOS 7, and this project aims to help users to install docker-based systems based on Yum.

| Name       | Version |
| ------     | ------  | 
| Docker     | 18.09   | 
| Kubernetes | 1.13.3  | 

updated: 2019-2-13

## 2. Steps

### 2.1 Prerequisite

2.1.1 copy all the *.repo you needs to the path ``/etc/yum.repos.d/''

2.1.2 close selinux (vi /etc/selinux/config)

```
SELINUX=(enforcing --> disabled)
```

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

Next, please see project [syspods](https://github.com/kube-tools/syspods) to complete installation.
