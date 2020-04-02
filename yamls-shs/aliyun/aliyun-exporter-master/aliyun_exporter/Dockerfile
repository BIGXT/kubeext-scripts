FROM aylei/aliyun-exporter:0.3.0

RUN pip3 install -U aliyun-exporter==0.3.1 PyYAML==5.1.2

RUN pip3 install  aliyun-python-sdk-slb aliyun-python-sdk-dds

COPY info_provider.py /usr/local/lib/python3.7/site-packages/aliyun_exporter/info_provider.py

