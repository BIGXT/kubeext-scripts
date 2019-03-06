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

## 2. All-in-one

you can install all softwares using the following script

```
curl https://github.com/kubesys/kubeos/releases/download/1.1/install.sh | sh
```

## 3. List

- [repo](repo): yum client for CentOS.7x
- [syspods](syspods): system pods 
