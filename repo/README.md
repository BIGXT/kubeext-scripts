## 1. Background

In our design, the OS includes Docker, kubernetes, and you can get the packages by yourself.
Note that you should first disable selinux and firewalld of your OS.

| Name       | Version |  Packages  |   
| ------     | ------  | ------ |
| Docker     | 18.09   | [redhat](https://docs.docker.com/install/linux/docker-ee/rhel/), [openSUSE/SUSE](https://docs.docker.com/install/linux/docker-ee/suse/), [centos](https://docs.docker.com/install/linux/docker-ce/centos/), [debian](https://docs.docker.com/install/linux/docker-ce/debian/), [fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) |
| Kubernetes | 1.13.3  | [redhat/CentOS/SUSE/openSUSE](https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.x86_64.rpm), [ubuntu/debian](https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.amd64.deb) |
| KVM        | 2.12   | [redhat/CentOS](https://docs.openstack.org/install-guide/environment-packages-rdo.html), [openSUSE/SUSE](https://docs.openstack.org/install-guide/environment-packages-obs.html), [debian/ubuntu](https://docs.openstack.org/install-guide/environment-packages-ubuntu.html) |
| openvswitch| 2.10   | [redhat/CentOS](http://docs.openvswitch.org/en/latest/intro/install/distributions/#red-hat), [openSUSE/SUSE](http://docs.openvswitch.org/en/latest/intro/install/distributions/#opensuse), [debian/ubuntu](http://docs.openvswitch.org/en/latest/intro/install/distributions/#debian) |

updated: 2019-3-5

## 2. Manual

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

### 2.2 Install Docker

```
yum install docker-ce
systemctl start docker 
systemctl enable docker
```

### 2.3 Install Kubernetes

```
yum install kubeadm kubectl kubelet  
or 
rpm --force -Uvh https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.x86_64.rpm
```

### 2.4 Install kvm （optional）

```
yum install qemu-kvm qemu-img
```

### 2.5 Install openvswitch （optional）

```
yum install openvswitch
systemctl start openvswitch 
systemctl enable openvswitch
```

Next, please see project [syspods](../syspods) to complete installation.
