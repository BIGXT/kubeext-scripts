
## verified history

20200422 17:00 centos7 kubernetes 1.17.4 aliyun 4core16GB, verified.

## important notes

To install a single node kubernetes cluster. It is more complex when facing not well prepared machines (existing old versions, broken networks, e.g.,). It is near impossible to setup a tool without several years' production experience.

To make things easy, This note gives a limited installation with the following requirements.

1. 3 Machines with static domestic IP connections.
2. All the machines have stable Internet accesses.
3. All the machines have the same linux version. Currently our scripts only support Centos 7.4, it may support Centos 7.8(we have not tested it yet)
4. Any requirements from kubernetes ( https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ ) and docker-ce ( https://docs.docker.com/engine/install/centos/ )

## For all machines

Execute the following steps on every machine.

### Get the script 

```
git clone https://github.com/kubesys/kubeext-scripts.git
cd ./kubeext-scripts/yamls-shs/kubernetes
```

### Remove all old versions and set up the pre-installation environment

```
bash -x ./removeAll.sh
```

If your machines are clean(first installation), you can skip this step.

### install kubernetes and docker by the Centos yum sources

```
bash -x ./installAll.sh
```

It installs the default newest version automatically.

It may encounter some errors, especially in old environments. You probably need to solve software conflicts manually.

### get the deploy images

check the version you install:

```
kubeadm version
```

the output is like:
```
kubeadm version: &version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.4", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T11:54:15Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
```

Then, you need to change images.conf manually (to modify the all image versions if you need):

```
vi images.conf
```

The image versions should be same as the GitVersion of kubeadm:

```
k8s.gcr.io/kube-apiserver:v1.17.4
k8s.gcr.io/kube-controller-manager:v1.17.4
k8s.gcr.io/kube-scheduler:v1.17.4
k8s.gcr.io/kube-proxy:v1.17.4
k8s.gcr.io/pause:3.1
k8s.gcr.io/etcd:3.4.3-0
k8s.gcr.io/coredns:1.6.5
```

At last, execute pull.sh to pull down all images and change their tags by:

```
bash -x pull.sh 
```

It may wait a longer time than you can image.

## Setup a single master

Execute the following steps on the master:

### setup initSingleMaster.sh

To set the version you need, change the version (first line) in initSingleMaster.sh

```
vi ./initSingleMaster.sh
```

update the version to (you may need other versions.)

```
version="v1.17.4"
```

Then, execute it:

```
bash -x ./initSingleMaster.sh
```

The output messages including about how to add nodes to master, like:

```
You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

At last, setup network:

```
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
```

if you do want to use calico, check https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network for more options.


## Setup nodes

Execute the following steps on the rest machines:

### Join node to master

copy the message from the last step,replace the contents in <> to the real ones.
```
kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

## Check on master

Some commands like the following ones:

```
kubectl get node
kubectl get pod -n kube-system
```

If it can print normally, It means the cluster is functional.

Then you need to learn a lot of commands to operate kubernetes.

## current bugs

1. It is difficult to remove all the versions of kubernetes or docker.

A possible solution can be:

Find the installed versions:
```
yum list kubeadm --showduplicates
```

or try to install and get the old information
```
yum -y install kubeadm
```

Then copy the old information to remove the old

```
yum -y remove <package name>-<version>.<platform>
yum -y remove kubectl-1.18.2-0.x86_64
yum -y install kubelet-1.17.4-0.x86_64 kubeadm-1.17.4-0.x86_64 kubectl-1.17.4-0.x86_64
```



