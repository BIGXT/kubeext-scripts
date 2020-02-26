https://github.com/indeedeng/rabbitmq-operator

## 使用prometheus监控rabbitmq
### 部署rabbitmq
使用helm进行部署

```bash
# 将rabbitmq的chart获取到本地
helm fetch stable/rabbitmq

cd rabbitmq

vi values.yaml
   设置metrics:
        enabled: true

   设置persistence:
        enabled: false

   设置service:
        type: NodePort

vi ./templates/svc.yaml

修改：
{{- if .Values.metrics.enabled }}
  - name: metrics
    port: {{ .Values.metrics.port }}
    targetPort: metrics
    {{- if (eq .Values.service.type "NodePort") }}
    nodePort: 31002
    {{- end }}
{{- end }}

# 部署rabbitmq
cd ..
helm install ./rabbitmq

# 检查状态
kubectl get po

# 在prometheus中的kubernetes-metrics-endpoint的job中可以直接获取到rabbitmq到数据

# 删除
helm list
helm delete [chartName]   
```
### 若要使用pvc
1.在templates下创建pv   
// 查看卷到大小,根据大小设置storage    
helm inspect stable/rabbitmq | grep size   

pv.yaml
```
kind: PersistentVolume
apiVersion: v1
metadata:
  name: rabbitmq-pv-volume
  labels:
    app: rabbitmq
spec:
  capacity:
    storage: 8Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data/pv/rabbitmq"
```
存在文件权限问题，待解决。  
若开启了pvc，helm delete的时候不会自动删除，需要手动删除。