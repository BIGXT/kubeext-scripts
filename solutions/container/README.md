
# Introduction

This is a management platform for containerized applications.

# Quick start

We assume you have stopped/disabled the selinux and firewalld services, 
and you have installed the following softwares on your machine, see the [tutorial](../../configs/README.md):

- Docker: 18.06
- kubeadm/kubelet/kubectl: 1.14.3
- openvswitch: 2.11


private network
```
rpm --force -Uvh http://133.133.135.22/cloudplus/kube-tools-v1.14.3-cloudplus.1906.el7.x86_64.deb
rpm --force -Uvh http://133.133.135.22/cloudplus/kube-setup-v1.14.3-cloudplus.1906.el7.x86_64.deb
or
rpm --force -Uvh http://133.133.135.22/cloudplus/kube-tools-v1.14.3-cloudplus.1906.el7.x86_64.rpm
rpm --force -Uvh http://133.133.135.22/cloudplus/kube-setup-v1.14.3-cloudplus.1906.el7.x86_64.rpm
yum install docker (1.13) or yum install docker-ce(18.09)
```

public network
```
http://39.107.241.0/cloudplus/kube-tools-v1.14.3-cloudplus.1906.el7.x86_64.deb
http://39.107.241.0/cloudplus/kube-setup-v1.14.3-cloudplus.1906.el7.x86_64.deb
or
http://39.107.241.0/cloudplus/kube-tools-v1.14.3-cloudplus.1906.el7.x86_64.rpm
http://39.107.241.0/cloudplus/kube-setup-v1.14.3-cloudplus.1906.el7.x86_64.rpm
yum install docker (1.13) or yum install docker-ce(18.09)
```

Now you can install the platform using the following command (you may try twice).

```
kubesetup
```

# Components

- Foundational features 
  - [Kubernetes cluster](https://github.com/kubernetes/kubernetes):  Automated container deployment, scaling, and management 
  - [Kubernetes network](https://github.com/alauda/kube-ovn): An OVN-based Kubernetes network fabric for enterprises
  - [Kubernetes register](https://github.com/ContainerSolutions/trow): Image Management for Kubernetes Clusters
  - [Kubernetes monitoring](https://github.com/coreos/kube-prometheus): The Prometheus monitoring system and time series database
  - [Kubernetes logging](https://github.com/grafana/loki): Loki is a horizontally-scalable, highly-available, multi-tenant log aggregation system inspired by Prometheus
- Advanced workload controllers:
  - [Stateful application on Kubernetes](https://github.com/openkruise/kruise): Automate application workloads management on Kubernetes 
- Advanced tools
  - [Pipeline on Kubernetes](https://github.com/tektoncd/pipeline): It provides k8s-style resources for declaring CI/CD-style pipelines
  - [Online configuration diagnostic tool for Kubernetes](https://github.com/reactiveops/polaris): Validation of best practices in your Kubernetes clusters 
- ~~[Offline diagnostic tool for Kubernetes](https://github.com/heptio/sonobuoy): It provides a diagnostic tool that makes it easier to understand the state of a Kubernetes cluster by running a set of Kubernetes conformance tests in an accessible and non-destructive manner.~~
- ~~[MachineLearning workloads on Kubernetes](https://github.com/PipelineAI/pipeline): Real-time enterprise AI platform~~
- ~~[Streaming workloads on Kubernetes](https://github.com/strimzi/strimzi-kafka-operator): Apache Kafka running on Kubernetes~~

**Tools**

- [helm-convert](https://github.com/ContainerSolutions/helm-convert):Convert Helm charts to Kubernetes resources.

# Advanced features

### Advanced StatefulSet
```yaml
apiVersion: apps.kruise.io/v1alpha1
kind: StatefulSet
metadata:
  name: sample
spec:
  replicas: 3
  serviceName: fake-service
  selector:
    matchLabels:
      app: sample
  template:
    metadata:
      labels:
        app: sample
    spec:
      readinessGates:
        # A new condition must be added to ensure the pod remain at NotReady state while the in-place update is happening
      - conditionType: InPlaceUpdateReady 
      containers:
      - name: main
        image: nginx:alpine
  podManagementPolicy: Parallel  # allow parallel updates, works together with maxUnavailable
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      # Do in-place update if possible, currently only image update is supported for in-place update
      podUpdatePolicy: InPlaceIfPossible
      # Allow parallel updates with max number of unavailable instances equals to 2
      maxUnavailable: 2
```
### Broadcast Job
Run a BroadcastJob that each Pod computes pi, with `ttlSecondsAfterFinished` set to 30. The job
will be deleted in 30 seconds after the job is finished.

```yaml
apiVersion: apps.kruise.io/v1alpha1
kind: BroadcastJob
metadata:
  name: broadcastjob-ttl
spec:
  template:
    spec:
      containers:
        - name: pi
          image: perl
          command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  completionPolicy:
    type: Always
    ttlSecondsAfterFinished: 30
```
### SidecarSet

The yaml file below describes a SidecarSet that contains a sidecar container named `sidecar1`

```yaml
# sidecarset.yaml
apiVersion: apps.kruise.io/v1alpha1
kind: SidecarSet
metadata:
  name: test-sidecarset
spec:
  selector: # select the pods to be injected with sidecar containers
    matchLabels:
      app: nginx
  containers:
  - name: sidecar1
    image: centos:7
    command: ["sleep", "999d"] # do nothing at all 
```

### Namespaced Subnets

Each Namespace can have a unique Subnet (backed by a Logical Switch). Pods within the Namespace will have IP addresses allocated from the Subnet. It's also possible for multiple Namespaces to share a Subnet.

Kube-OVN uses annotations on Namespaces to create and share Subnets. If a Namespace has no related annotations, it will use the default Subnet (10.16.0.0/16)

Use the following annotations to define a Subnet:

- `ovn.kubernetes.io/cidr`: The CIDR of the Subnet.
- `ovn.kubernetes.io/gateway`: The Gateway address for the Subnet.
- `ovn.kubernetes.io/logical_switch`: The Logical Switch name in OVN.
- `ovn.kubernetes.io/exclude_ips`: Addresses that should not be allocated to Pods.


Example:

```bash
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    ovn.kubernetes.io/cidr: 10.17.0.0/16
    ovn.kubernetes.io/gateway: 10.17.0.1
    ovn.kubernetes.io/logical_switch: ovn-subnet
    ovn.kubernetes.io/exclude_ips: "192.168.0.4,192.168.0.30..192.168.0.60,192.168.0.110..192.168.0.120"
  name: ovn-subnet
```

This YAML will create a Logical Switch named `ovn-subnet` in OVN, with CIDR 10.17.0.0/16, and Gateway 10.17.0.1. The IP addresses between 10.17.0.0 and 10.17.0.10 will not be allocated to the Pods.

**NOTE**: In the current version, we only support creating a Subnet while creating a new Namespace. Modifying annotations after Namespace creation will not trigger Subnet creation/update in OVN. Dynamic Subnet configuration is planned for a future release.

To share a Subnet across multiple Namespaces, point the annotation `ovn.kubernetes.io/logical_switch` to an existing Logical Switch when creating the Namespace. For example:

```bash
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    ovn.kubernetes.io/logical_switch: ovn-subnet
  name: ovn-share
```

This YAML will create a Namespace ovn-share that uses the same Subnet as the previous Namespace `ovn-subnet`.

### Subnet Isolation

Can configure a Subnet to deny any traffic from source IP addresses not within the same Subnet. Can whitelist specific IP addresses and IP ranges.

Kube-OVN supports network isolation and access control at the Subnet level.

Use following annotations to specify the isolation policy:
- `ovn.kubernetes.io/private`: boolean, controls whether to deny traffic from IP addresses outside of this Subnet. Default: false.
- `ovn.kubernetes.io/allow`: strings of CIDR separated by commas, controls which addresses can access this Subnet, if `private=true`.

Example:

```bash
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    ovn.kubernetes.io/cidr: 10.17.0.0/16
    ovn.kubernetes.io/gateway: 10.17.0.1
    ovn.kubernetes.io/logical_switch: ovn-subnet
    ovn.kubernetes.io/exclude_ips: 10.17.0.0..10.17.0.10
    ovn.kubernetes.io/private: "true"
    ovn.kubernetes.io/allow: 10.17.0.0/16,10.18.0.0/16
  name: ovn-subnet
``` 

### Static IP Addresses for Workloads

Allocate random or static IP addresses to workloads.

Kube-OVN supports allocation a static IP address for a single Pod, or a static IP pool for a Workload with multiple Pods (Deployment/DaemonSet/StatefulSet). To enable this feature, add the following annotations to the Pod spec template.

Use the following annotations to specify the address
- `ovn.kubernetes.io/ip_address`: Specifies IP address
- `ovn.kubernetes.io/mac_address`: Specifies MAC address

Example:
```bash
apiVersion: v1
kind: Pod
metadata:
  name: static-ip
  namespace: ls1
  annotations:
    ovn.kubernetes.io/ip_address: 10.16.0.15
    ovn.kubernetes.io/mac_address: 00:00:00:53:6B:B6
spec:
  containers:
  - name: static-ip
    image: nginx:alpine
```

**Note**:

1. The address **SHOULD** be in the CIDR of related switch.
2. The address **SHOULD NOT** conflict with addresses already allocated.
3. The static MAC address is optional.

Use the following annotation to allocate addresses for a Workload:
-  `ovn.kubernetes.io/ip_pool`: For Deployments/DaemonSets, we will randomly choose an available IP address for a Pod. For StatefulSets, the IP allocation will follow the order specified in the list.

Example:
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: ovn-test
  name: starter-backend
  labels:
    app: starter-backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: starter-backend
  template:
    metadata:
      labels:
        app: starter-backend
      annotations:
        ovn.kubernetes.io/ip_pool: 10.16.0.15,10.16.0.16,10.16.0.17
    spec:
      containers:
      - name: backend
        image: nginx:alpine
```

**Note**:

1. The address **SHOULD** be in the CIDR of the related switch.
2. The address **SHOULD NOT** conflict with addresses already allocated.
3. If the `ip_pool` size is smaller than the replica count, some Pods will not start.
2. Care should be taken for scaling and updates to ensure there are addresses available for new Pods.

### Dynamic QoS

Configure Pod Ingress/Egress traffic rate limits on the fly.

Kube-OVN supports dynamically configurations of Ingress and Egress traffic rate limiting.

Use the following annotations to specify QoS:
- `ovn.kubernetes.io/ingress_rate`: Rate limit for Ingress traffic, unit: Mbit/s
- `ovn.kubernetes.io/egress_rate`: Rate limit for Egress traffic, unit: Mbit/s

Example:

```bash
apiVersion: v1
kind: Pod
metadata:
  name: qos
  namespace: ls1
  annotations:
    ovn.kubernetes.io/ingress_rate: "3"
    ovn.kubernetes.io/egress_rate: "1"
spec:
  containers:
  - name: qos
    image: nginx:alpine
```
