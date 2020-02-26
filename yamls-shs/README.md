## Background

   Providing system Pods for chinese users. Note that all scripts in this project only work on CentOS 7.x.
   
## Component
- [kubernetes](kubernetes)
- [flannel](flannel)
- [calico](calico)

## 安装helm
```bash
# 安装 helm
wget https://get.helm.sh/helm-v2.16.3-linux-amd64.tar.gz

tar -zxvf helm-v2.16.3-linux-amd64.tar.gz 

cp linux-amd64/helm /usr/local/bin/

# 安装服务端tiller

# 利用阿里云的镜像来配置 Helm
helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.16.3  --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
kubectl create serviceaccount --namespace kube-system tiller  

kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller 

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

# 检查是否安装成功
helm version
```

