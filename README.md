## 1. Background

In our design, the OS includes Docker, kubernetes, and you can get the packages by yourself.
Note that you should first disable selinux and firewalld of your OS.

| Name        | Type      | Version |  Packages  |   
| ------      | ------    | ------  | ------      |
| Docker      | Container-based virtualization | 19.03   | [redhat](https://docs.docker.com/install/linux/docker-ee/rhel/), [openSUSE/SUSE](https://docs.docker.com/install/linux/docker-ee/suse/), [centos](https://docs.docker.com/install/linux/docker-ce/centos/), [debian](https://docs.docker.com/install/linux/docker-ce/debian/), [fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) |
| KVM/libvirt  | OS-based virtualization  | 2.1.2/4.5.0   | [Linux](https://www.qemu.org/download/#linux) |
| openvswitch  | Network virtualization | 2.11    | [redhat/CentOS](http://docs.openvswitch.org/en/latest/intro/install/distributions/#red-hat), [openSUSE/SUSE](http://docs.openvswitch.org/en/latest/intro/install/distributions/#opensuse), [debian/ubuntu](http://docs.openvswitch.org/en/latest/intro/install/distributions/#debian) |
| Kubernetes   | Virtual compute resource pool  | 1.14.6  | [Linux](https://v1-14.docs.kubernetes.io/) |
| istio        | ServiceMesh | 1.2.3   | [Linux](https://istio.io/docs/setup/kubernetes/install/kubernetes/) |


updated: 2019-8-31


## 2. Authors:

- wuheng@otcaix.iscas.ac.cn
- xuyuanjia2017@otcaix.iscas.ac.cn
- yanbowen18@otcaix.iscas.ac.cn


## 3. List

- [yum repos](configs): yum client for CentOS.7x
- [solutions](solutions)
   - [container](solutions/container)
   - [hypervisor](solutions/kvm)
