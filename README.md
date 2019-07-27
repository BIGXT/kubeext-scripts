## 1. Background

In our design, the OS includes Docker, kubernetes, and you can get the packages by yourself.
Note that you should first disable selinux and firewalld of your OS.

| Name       | Version |  Packages  |   
| ------     | ------  | ------ |
| Docker     | 19.03   | [redhat](https://docs.docker.com/install/linux/docker-ee/rhel/), [openSUSE/SUSE](https://docs.docker.com/install/linux/docker-ee/suse/), [centos](https://docs.docker.com/install/linux/docker-ce/centos/), [debian](https://docs.docker.com/install/linux/docker-ce/debian/), [fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) |
| Kubernetes | 1.15.1  | [redhat/CentOS/SUSE/openSUSE](https://github.com/kubesys/kubeos/releases/download/1.2/kube-tools-v1.13.5-cloudplus.1903.el7.x86_64.rpm), [ubuntu/debian](https://github.com/kubesys/kubeos/releases/download/1.2/kube-tools-v1.13.5-cloudplus.1903.amd64.deb) |
| calico     | 3.8     | [kubernetes](https://docs.projectcalico.org/v3.8/getting-started/kubernetes/) |
| KVM        | 2.12   | [redhat/CentOS](https://docs.openstack.org/install-guide/environment-packages-rdo.html), [openSUSE/SUSE](https://docs.openstack.org/install-guide/environment-packages-obs.html), [debian/ubuntu](https://docs.openstack.org/install-guide/environment-packages-ubuntu.html) |
| openvswitch| 2.11   | [redhat/CentOS](http://docs.openvswitch.org/en/latest/intro/install/distributions/#red-hat), [openSUSE/SUSE](http://docs.openvswitch.org/en/latest/intro/install/distributions/#opensuse), [debian/ubuntu](http://docs.openvswitch.org/en/latest/intro/install/distributions/#debian) |

updated: 2019-7-27


## 2. Authors:

- wuheng@otcaix.iscas.ac.cn
- xuyuanjia2017@otcaix.iscas.ac.cn
- sulingang17@otcaix.iscas.ac.cn


## 3. List

- [yum repos](configs): yum client for CentOS.7x
- [solutions](solutions)
   - [container](solutions/container)
   - [hypervisor](solutions/hypervisor)
