---
title: Mac系统下升级node版本
abbrlink: 1345941684
tags:
	- mac
	- node
description: 如何在Mac系统下升级node版本
---



#### 第一步：使用npm安装n模块

n模块是专门用来管理nodejs版本的，名字就叫n执行命令

````
npm install -g n
````
#### 第二步：使用n模块升级node

*第一种是升级到最新版本*

```
sudo n latest
```

*第二种是升级到稳定版本（建议用稳定版本）*

`sudo n stable`

安装成功！（若版本未切换成功则进入第三步手动修改环境变量）

```
node -v
v11.10.1
```

最后升级npm到最新版本：

```
sudo npm install npm@latest -g
```

#### 第三步：修改NODE_HOME环境变量

```shell
sudo vi /etc/profile
+
export NODE_HOME=/usr/local/n/versions/node/12.0.0
export PATH=$NODE_HOME/bin:$PATH
```

激活环境变量

```
source /etc/profile
```