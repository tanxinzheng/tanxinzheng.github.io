---
title: Github访问加速设置
tags:
  - git
  - github
categories: 
  - 技术分享
abbrlink: 41928511
cover: /images/category/git-logo.jpg
date: 2020-12-10 22:33:34
---

### 原理概述

众所周知，由于github服务站点在美国，国内访问速度时好时坏，而通过DNS域名解析后速度更慢，所以我们可以直接通过设置hosts的域名对应的实际ip直接访问ip绕过域名解析，速度可以快到飞起，OK，进入正题。



#### 域名DNS解析IP

##### DNS解析域名对应ip

- 访问https://www.ping.cn/dns/

![image-20201216105335033](../../img/image-20201216105335033.png)

- 找到当前网络运营商、解析时间最小的对应IP

  ![image-20201216105708714](../../img/image-20201216105708714.png)

##### Mac系统下命令查询域名对应ip

_这种方式查询出来的ip，无法保证ip的访问速度，推荐使用第一种方式。_

```
MacBook-Pro-6:~ tanxinzheng$ nslookup www.github.com
Server:		114.114.114.114
Address:	114.114.114.114#53

Non-authoritative answer:
www.github.com	canonical name = github.com.
Name:	github.com
Address: 13.250.177.223
```

#### 修改hosts映射Github域名

管理员模式下编辑hosts

- Mac系统在 /etc/hosts

- Windows系统在 C:/windows/System/etc/hosts

将映射代码添加在hosts文件尾部（该ip为上海地区的最小解析时间，请大家实际情况修改）

_注：若需要加快github访问不只是单纯的需要映射github.com域名_

```
# github ip
13.229.188.59 		github.com
52.128.23.153		githubusercontent.com
```

#### 刷新本地DNS解析缓存

- Windows

  ```cmd
  ipconfig /flushdns
  ```

- Mac

  ```shell
  sudo killall -HUP mDNSResponder
  ```

- Linux

  ```shell
  sudo /etc/init.d/networking restart
  ```

  