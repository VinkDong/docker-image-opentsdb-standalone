L# docker-image-opentsdb-standalone
opentsdb-standalone 独立的opentsdb镜像

```
chmod a+x run.sh unprivileged.sh
docker build -t hand/opentsdb-standalone .
```

before run container, make sure your hbase container contains opentsdb tables

```
docker run -d --link hbase_container:hbase -p 4242:4242 hand/opentsdb-standalone
```
