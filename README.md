## 1. Background

In our design, the OS includes Docker, kubernetes, and you can get the packages by yourself.
Note that you should first disable selinux and firewalld of your OS.

| Name        | Type      | Version |  Packages  |   
| ------      | ------    | ------  | ------      |
| Docker      | Container-based virtualization | 19.03   | [redhat](https://docs.docker.com/install/linux/docker-ee/rhel/), [openSUSE/SUSE](https://docs.docker.com/install/linux/docker-ee/suse/), [centos](https://docs.docker.com/install/linux/docker-ce/centos/), [debian](https://docs.docker.com/install/linux/docker-ce/debian/), [fedora](https://docs.docker.com/install/linux/docker-ce/fedora/), [ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) |
| KVM/libvirt  | OS-based virtualization  | 2.1.2/4.5.0   | [Linux](https://www.qemu.org/download/#linux) |
| openvswitch  | Network virtualization | 2.11    | [redhat/CentOS](http://docs.openvswitch.org/en/latest/intro/install/distributions/#red-hat), [openSUSE/SUSE](http://docs.openvswitch.org/en/latest/intro/install/distributions/#opensuse), [debian/ubuntu](http://docs.openvswitch.org/en/latest/intro/install/distributions/#debian) |
| Calico      | Network solution        | 3.11  | [Linux](https://docs.projectcalico.org/v3.9/getting-started/kubernetes/) |
| Kubernetes   | Virtual compute resource pool  | 1.17.1  | [Linux](https://v1-14.docs.kubernetes.io/) |
| istio        | ServiceMesh | 1.2.3   | [Linux](https://istio.io/docs/setup/kubernetes/install/kubernetes/) |


updated: 2020-2-13

# 2. Demo Environment

Using the account admin/111111 to log in the [demo environment](http://39.106.124.113:9537/).

## 3. Authors

- wuheng@otcaix.iscas.ac.cn
- xuyuanjia2017@otcaix.iscas.ac.cn
- wuyuewen@otcaix.iscas.ac.cn


## 4. Projects

- [CMP](cmp-yamls) (Cross-cloud management platform) (Baidu, Aliyun, Tencent, JD, Ucloud, Amazon, Azure, Google)
  - Compute: VirtualMachine, Container
  - Network: CDN
  - Database
  - Storage
- [DevOps](devops-yamls)
  - 代码开发 (Eclipse Che)：https://github.com/eclipse/che
  - 代码仓库（Gitlab）：https://github.com/gitlabhq/gitlabhq
  - 编译部署（tektoncd）：https://github.com/tektoncd
  - 在线文档 (ShowDoc): https://github.com/kphcdr/godoc
  - 过程管里（projectManage）：https://gitee.com/vilson/vue-projectManage
- [service-oriented PaaS](mpaas-yamls)
  - 制品管理（helm）：https://github.com/helm/helm
  - 服务网格（istio）：https://github.com/istio/istio
  - 服务追踪（zipkin）：https://github.com/openzipkin/zipkin
  - 服务注册（eureka）：https://github.com/Netflix/eureka
  - 服务网关（zuul）：https://github.com/Netflix/zuul
  - 服务容错（hystrix）：https://github.com/Netflix/Hystrix
  - 服务配置（Apollo）：https://github.com/ctripcorp/apollo


## 5. Architecture and Demo

We call it ARE-MVC. It is configuration based, analytically driven and Kubernetes oriented system.
We hope it can support various scenario, such as DevOps, Edge and PaaS

![avatar](https://github.com/kubesys/kubeOS/blob/master/imgs/arch.png)

It includes three projects:

- [kubeOS](https://github.com/kubesys/kubeOS): scripts
- [kubeext-system](https://github.com/kubesys/kubeext-system): customized Kubernetes resources
- [kubeext-dashboard](https://github.com/kubesys/kubeext-dashboard): Web UI

## 6. Commands

- kubeadm alpha certs check-expiration
- ETCDCTL_API=3 etcdctl --endpoints=https://localhost:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key member list
- ETCDCTL_API=3 etcdctl --endpoints=https://localhost:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key user list
cloudplus

