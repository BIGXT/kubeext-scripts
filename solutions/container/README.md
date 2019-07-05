
# Introduction

This is a management platform for containerized applications.

# Quick start

We assume you have installed the following softwares on your machine:

- Docker: 18.06
- kubeadm/kubelet/kubectl: 1.14.3
- openvswitch: 2.11

In addition,  you have stopped/disabled the selinux and firewalld services.

Now you can install the platform using the following command (you may try twice).

```
bash dev.sh
```

# Components

- [Kubernetes](https://github.com/kubernetes/kubernetes):  Automated container deployment, scaling, and management 
- [Openvswitch CNI](https://github.com/alauda/kube-ovn): An OVN-based Kubernetes Network Fabric for Enterprises


