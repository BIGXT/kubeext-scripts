# Prometheus Exporter for Alibaba Cloud
## 配置文件
在aliyun-exporter.yaml里面配置需要监控的数据

## Docker Image
```bash
cd aliyun_exporter
docker build -t aliyun-exporter:0.3.1 .
```

## docker运行命令：
```bash
docker run -d  -p 9525:9525 -e "ALIYUN_ACCESS_ID=XXXX" -e "ALIYUN_ACCESS_SECRET=XXXX" -e "ALIYUN_REGION=cn-XXXX" -v $(pwd)/aliyun-exporter.yml:/aliyun-exporter.yml  aliyun-exporter:0.3.1  -p 9525 -c  /aliyun-exporter.yml

```
## Usage

Config your credential and interested metrics:

```yaml
credential:
  access_key_id: <YOUR_ACCESS_KEY_ID>
  access_key_secret: <YOUR_ACCESS_KEY_SECRET>
  region_id: <REGION_ID>

metrics:
  acs_cdn:
  - name: QPS
  acs_mongodb:
  - name: CPUUtilization
    period: 300
```

## Configuration

```yaml
rate_limit: 5 # request rate limit per second. default: 10
credential:
  access_key_id: <YOUR_ACCESS_KEY_ID> # required
  access_key_secret: <YOUR_ACCESS_KEY_SECRET> # required
  region_id: <REGION_ID> # default: 'cn-hangzhou'
  
metrics: # required, metrics specifications
  acs_cdn: # required, Project Name of CloudMonitor
  - name: QPS # required, Metric Name of CloudMonitor, belongs to a certain Project
    rename: qps # rename the related prometheus metric. default: same as the 'name'
    period: 60 # query period. default: 60
    measure: Average # measure field in the response. default: Average

info_metrics:
  - ecs
  - rds
  - redis
```

## Metrics Meta

`aliyun-exporter` shipped with a simple site hosting the metrics meta from the CloudMonitor API. You can visit the metric meta in [localhost:9525](http://localhost:9525) after launching the exporter.

* `host:port` will host all the available monitor projects
* `host:port/projects/{project}` will host the metrics meta of a certain project
* `host:port/yaml/{project}` will host a config YAML of the project's metrics