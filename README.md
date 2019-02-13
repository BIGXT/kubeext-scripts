## 1. Background

  We assume you plan to run docker-based systems on CentOS 7, and this project aims to help users to install docker-based systems based on
Yum.

## 2. Steps

### 2.1 Prerequisite

copy all the *.repo you needs to the path ``/etc/yum.repos.d/''

close selinux (vi /etc/selinux/config)

```
SELINUX=(enforcing --> disabled)
```

disable firewalld
```
systemctl stop firewalld
systemctl disable firewalld
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
