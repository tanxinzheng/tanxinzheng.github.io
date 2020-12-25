---
title: Docker之Redis Cluster搭建
categories:
  - 技术实践
tags:
  - redis
  - cluster
  - docker
  - docker-compose
abbrlink: 41928529
cover: https://cdn.tanxz.com/images/category/redis.jpg
top_img: https://cdn.tanxz.com/images/post/default_top_img.jpg
date: 2019-03-10 19:33:34
---

## 环境

Docker 版本 19.03.8
```
MacBook-Pro-6:~ tanxinzheng$ docker -v
Docker version 19.03.8, build afacb8b
```

## 搭建
搭建的部署主要分为
- 架构设计
- 编写Docker Compose编排文件
- 创建redis cluster配置文件
- 启动服务容器
- 创建Redis集群

### 架构设计
redis集群模式必须要有3个主节点3个从节点才能正常启动集群模式

- 主节点端口：7000 | 7001 | 7002
- 从节点端口：7003 | 7004 | 7005

### Docker Compose
为节省内存资源，主从节点都部署在单机实例中
```
version: '2'

services:
  cluster:
    image: daocloud.io/redis
    container_name: redis-cluster
    # 添加该参数后服务后台运行后，容器不会自动退出
    tty: true
    restart: always
    # linux环境下建议使用host模式
    network_mode: host

    volumes:
      - ./data:/data
      - ./config:/etc/redis  
    ports:
      - "7000:7000"
      - "7001:7001"
      - "7002:7002"
      - "7003:7003"
      - "7004:7004"
      - "7005:7005"
    ## 必须使用宿主机ip 作为集群总线ip，否则宿主机无法访问到容器内的redis集群ip 
    # 也可以加在配置文件中
    #  --cluster-announce-ip 172.16.65.218 
    command: 
      - /bin/bash 
      - -c 
      - |
        redis-server /etc/redis/redis_cluster_7000.conf  --cluster-announce-ip 172.16.65.218 & 
        redis-server /etc/redis/redis_cluster_7001.conf  --cluster-announce-ip 172.16.65.218 &
        redis-server /etc/redis/redis_cluster_7002.conf  --cluster-announce-ip 172.16.65.218 &
        redis-server /etc/redis/redis_cluster_7003.conf  --cluster-announce-ip 172.16.65.218 & 
        redis-server /etc/redis/redis_cluster_7004.conf  --cluster-announce-ip 172.16.65.218 &
        redis-server /etc/redis/redis_cluster_7005.conf  --cluster-announce-ip 172.16.65.218 
```
### redis_700X.conf
根据各端口修改配置中的端口号
```
port 7000
# 绑定机器的内网IP或者公网IP,一定要设置，不要用 127.0.0.1
bind 0.0.0.0
# 启用集群模式
cluster-enabled yes
# 集群节点文件
cluster-config-file nodes_7000.conf
# 指定工作目录，rdb,aof持久化文件将会放在该目录下，不同实例一定要配置不同的工作目录
dir /data/7000/
# 节点宕机发现时间，可以理解为主节点宕机后从节点升级为主节点时间
cluster-node-timeout 5000
# 集群广播ip
#cluster-announce-ip 172.20.0.4
#cluster-announce-port 7000
# 开启AOF模式
appendonly yes
# 关闭保护模式
protected-mode no
# 是否后台启动
daemonize no
# pid file所在目录
pidfile /var/run/redis_7000.pid 
# 客户端访问密码
# requirepass redis2020
# 日志文件
logfile /var/log/redis_7001.log
```

## 启动Redis Cluster
```
docker-compose up -d
```

### 创建Redis集群

- 进入容器
```
$ docker exec -it redis-cluster /bin/bash
```
- 创建集群
```
$ redis-cli --cluster create 127.0.0.1:7000 \
                           127.0.0.1:7001 \
                           127.0.0.1:7002 \
                           127.0.0.1:7003 \
                           127.0.0.1:7004 \
                           127.0.0.1:7005 \
                           --cluster-replicas 1
```

## 查看集群状态

### 
```
## -c表示集群模式进入
root@docker-desktop:/data# redis-cli -c -h localhost -p 7000

## 查看集群信息 cluster_state为ok则表示集群创建成功
localhost:7000> cluster info
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:1
cluster_current_epoch:6
cluster_my_epoch:3
cluster_stats_messages_ping_sent:5290
cluster_stats_messages_pong_sent:5299
cluster_stats_messages_update_sent:1
cluster_stats_messages_sent:10590
cluster_stats_messages_ping_received:5294
cluster_stats_messages_pong_received:5290
cluster_stats_messages_meet_received:5
cluster_stats_messages_update_received:3
cluster_stats_messages_received:10592

## 查看集群节点信息
localhost:7000> cluster nodes
6b7f8c4767feb376a99e79068748253afcf6ea5a 127.0.0.1:7001@17001 slave ef7fdf2421427d1da29da4c1dab9e8c26ca12854 0 1607594235646 3 connected
52b109a6491a2e4280b6a66642716939d0f46e89 127.0.0.1:7004@17004 slave ef7fdf2421427d1da29da4c1dab9e8c26ca12854 0 1607594236555 5 connected
df7dcbf82ecba0ff044f2715b052674e73ec1ca6 127.0.0.1:7000@17000 myself,slave ef7fdf2421427d1da29da4c1dab9e8c26ca12854 0 1607594234000 1 connected
51f5c9fb771a702933d8bc29fcd13eb41811e2bb 127.0.0.1:7005@17005 master - 0 1607594236000 6 connected
ef7fdf2421427d1da29da4c1dab9e8c26ca12854 127.0.0.1:7002@17002 master - 0 1607594236657 3 connected 0-16383
cf7327c9ec3b374ebc6ba3f49c6bd5e0a7098601 127.0.0.1:7003@17003 master - 0 1607594235544 4 connected
```

## 参考
- [1] [Redis Cluster](https://redis.io/topics/cluster-tutorial)