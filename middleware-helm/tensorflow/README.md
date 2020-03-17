## 使用prometheus监控tensorflow
### tensorflow
使用helm进行部署

```bash
# 将tensorflow的chart获取到本地
git clone https://github.com/kubesys/kubeOS.git

cd middleware-helm/tensorflow-resnet

# 若已设置好则不更改
vi values.yaml
   设置metrics:
        enabled: true

   设置service:
        type: NodePort

# 部署tensorflow
cd ..
helm install -n tensorflow  ./tensorflow-resnet

# 检查状态
kubectl get po

# 删除
helm list
helm delete [chartName]   
```
配置prometheus文件
```bash
- job_name: 'tensorflow'
        metrics_path: /monitoring/prometheus/metrics
        static_configs:
          - targets:
              - 'tensorflow-tensorflow-resnet.default:8501'
```