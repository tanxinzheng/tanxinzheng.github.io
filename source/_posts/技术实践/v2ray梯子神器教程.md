---
title: v2ray梯子神器教程
categories:
  - 技术实践
keywords:
  - tanxz博客
  - tanxz blog
  - hexo
  - butterfly
  - 博客
  - blog
  - v2ray
top_img: 'https://cdn.tanxz.com/images/post/default_top_img.jpg'
toc_number: true
abbrlink: 1484053344
date: 2021-03-13 15:54:13
updated:
tags:
description:
comments:
cover:
toc:
copyright:
copyright_author:
copyright_author_href:
copyright_url:
copyright_info:
mathjax:
katex:
aplayer:
highlight_shrink:
aside:
---

# V2Ray搭建教程

**此教程2021/3/12日测试通过!!!**

一键搭建V2Ray，小白福利一条命令搞定V2Ray搭建，最详细的V2Ray图文教程！

## 前言

此教程面向小白萌新，从购买 VPS 到使用 SSH 登录并安装和配置 V2Ray，尽量详细一些，老鸟可以直接跳到 [第四部分](https://www.itblogcn.com/article/406.html#title-6)。

## 第一部分：环境信息

- 服务器系统：CentOS 7 以上版本系统兼容本教程
- VPS：我使用的是 [Vultr](https://www.itblogcn.com/vultr)
- 手机和电脑都支持搭建

## 第二部分：创建服务器

已有服务器的同学可以跳过这部分，没有服务器的同学可以先创建服务器，我使用的是[Vultr](https://www.itblogcn.com/vultr)。

[Vultr VPS](https://www.itblogcn.com/vultr/t) 推出了 **2020 年最新的限时促销活动**，「新用户」注册并充值 5 美元以上，即可获得 100 美元的免费赠送金额！力度相当巨大！！ (去年仅送 $50) 用于建站、学习、自建网盘或各种网络服务等等都很实用，优势是价格低，按时计费，随时更换IP。有购买海外 [VPS](https://www.itblogcn.com/vultr) 需求的同学就得抓紧机会了。

**Vultr活动地址：**https://www.itblogcn.com/vultr/t

**Vultr注册教程：**[注册Vultr教程和创建VPS服务器教程](https://www.itblogcn.com/article/registervultr.html)

预算充足的朋友也可以选择搬瓦工的VPS服务器，其CN2 GIA-E线路网速极快。

**搬瓦工注册教程(内附优惠券)：**https://www.itblogcn.com/article/bwg-register.html

**搬瓦工VPS在售列表一览：**https://www.itblogcn.com/bwg/index.html

以上2家都支持支付宝支付。

## 第三部分：JuiceSSH或Xshell连接服务器

准备好你的服务器，确认账号（一般是root）和密码，系统建议Centos7 ×64

> SSH链接服务器软件链接（打开较慢耐心等待）：https://cloud.degoo.com/share/Q26mfIizv30wRn

### JuiceSSH使用教程

手机用`JuiceSSH`连接服务器，教程如下

```
(1）进入JuiceSSH
(2）点上侧连接
(3）点右下角+
(4）昵称随意，类型SSH，地址你的服务器ip（外网IP），端口默认22不变（映射端口和自设端口除外）
(5）认证选新建
(6）昵称随意，用户名一般为root，密码填你的服务器密码
(7）点右上角√
(8）再点右上角√
(9）点你设置的配置，如无昵称就是以服务器ip命名
(10）如无意外，这时就自动登陆服务器了，如果提示你输入密码，再输一遍就行了，输入后记得点保存
(11）进入服务器后，就可以运行代码了，本机键盘手打或者复制粘帖均可
```

### XShell使用教程

电脑用`XShell`连接服务器，教程如下

```javascript
(1）进入XShell
(2）点左上角文件
(3）点新建
(4）名称随意，协议SSH，主机你的服务器IP（外网IP），端口默认22不变（映射端口和自设端口除外）
(5）确定
(6）在左侧会话管理器，选中设置的配置双击打开
(7）提示输入账号和密码，输入后记得点保存(没有提示可能IP被墙)
(8）进入服务器后，就可以运行代码了，本机键盘手打或者复制粘帖均可COPY
```

> **注意：假如连不上服务器，可能是IP被墙，或者是TCP阻断了，建议重新创建服务器，并且删除原有的。**

![20181231151835.png](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea111dd73c13.png)
![img](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea111fdeb54d.png)

## 第四部分：V2Ray搭建

新的一键V2Ray脚本，经过笔者的测试，安装简单方便。因此推荐大家使用。

**安装命令：**

输入以下命令，回车执行（`shift+insert`可粘贴）

```bash
bash <(curl -s -L https://git.io/v2ray-setup.sh)COPY
```

显示一下信息代表安装成功（可直接用以下配置进行连接）(以下配置在链接时使用)：

```
---------- V2Ray 配置信息 -------------

 地址 (IP Address) = 141.*.*.*

 端口 (Port) = 8888

 用户ID (User ID / UUID) = 38b272ba-8a91-*-*-*

 额外ID (Alter Id) = 0

 传输协议 (Network) = tcp

 伪装类型 (header type) = none

---------- END -------------

V2Ray 客户端使用教程: https://git.io/v2ray-client

提示: 输入 v2ray url 可生成 vmess URL 链接 / 输入 v2ray qr 可生成二维码链接

---------- V2Ray vmess URL / V2RayNG v0.4.1+ / V2RayN v2.1+ / 仅适合部分客户端 -------------

vmess://ewoidiI6I*****g==
```

**配置文件要注意(建议直接复制安装结果中 vmess://\**\** 地址，直接导入，避免自己填配置出错)：**

Network(传输协议)： tcp
type(伪装类型)：none
不对的话连不上！！！

好了到这里我们就搭建成功了(*^▽^*)

**相关命令：**

> `v2ray info` 查看 V2Ray 配置信息
> `v2ray config` 修改 V2Ray 配置
> `v2ray link` 生成 V2Ray 配置文件链接
> `v2ray infolink` 生成 V2Ray 配置信息链接
> `v2ray qr` 生成 V2Ray 配置二维码链接
> `v2ray ss` 修改 Shadowsocks 配置
> `v2ray ssinfo` 查看 Shadowsocks 配置信息
> `v2ray ssqr` 生成 Shadowsocks 配置二维码链接
> `v2ray status` 查看 V2Ray 运行状态
> `v2ray start` 启动 V2Ray
> `v2ray stop` 停止 V2Ray
> `v2ray restart` 重启 V2Ray
> `v2ray log` 查看 V2Ray 运行日志
> `v2ray update` 更新 V2Ray
> `v2ray update.sh` 更新 V2Ray 管理脚本
> `v2ray uninstall` 卸载 V2Ray

**vmess协议配置**

查看配置文件(**该配置在后面链接时使用**)：

```
cat /etc/v2ray/config.json
```

[![14.png](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea11229bca76.png)](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea11229bca76.png)

## 第五部分：客户端链接V2Ray

**各平台的v2ray客户端地址：**

(✪ω✪)

### Windows v2ray客户端：

**下载方式一：网盘(直接解压可用)**

【v2ray-windows-64.exe】：https://cloud.degoo.com/share/uJWFAUsuO3fbBe

解压【【【点击v2rayN.exe启动】】】

**下载方式二：GitHub**

客户端：下载[v2rayN.zip](https://github.com/2dust/v2rayN/releases/download/3.19/v2rayN.zip)

【[v2rayN-v2rayN.exe-Github Release](https://github.com/2dust/v2rayN/releases)】 https://github.com/2dust/v2rayN/releases

内核：下载`v2ray-windows-64.zip`文件，注意版本和上面服务端版本要一致！！！

【[v2ray-windows-64.zip Github Release](https://github.com/v2ray/v2ray-core/releases/tag/v4.25.0)】 https://github.com/v2ray/v2ray-core/releases/tag/v4.25.0

对`v2ray-windows-64.zip` 和 v2rayN 进行解压，然后将 v2rayN 目录下所有文件复制到`v2ray-windows-64`解压后的目录，即两个下载好的文件需要在同一目录。

【【【点击**v2rayN.exe**启动】】】

注意电脑右下角 V 图标，双击图标，点右上角 **服务器** ，添加[VMess]服务器。

(*^▽^*)(*^▽^*)(*^▽^*)(*^▽^*)(*^▽^*)(*^▽^*)

**进行配置:**

客户端的配置需要根据你的服务端进行相应的配置，因为你的服务端协议可能是vmess等。

如果你的服务端配置是协议vmess，则配置如下：（**这里传输协议把tcp改为kcp，伪装协议改为kcp**）

![15.png](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea112995ff23.png)

保存后，右键电脑右下角 V 图标

![img](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea112837dc1f.png)

**(✪ω✪)**

### Android v2ray客户端：

**下载方式一：网盘(APK直接安装)**

【APK】：https://cloud.degoo.com/share/8WRnSeIyS3uJnK

**下载方式二：GitHub**
需要你去网上找设备相应的CPU架构并进行选择下载：
https://github.com/2dust/v2rayNG/releases

**使用方法:**

```javascript
(1）打开 v2rayNG APP
(2）点击右上角 + 号
(3）选择 手动输入[Vmess]
(4）别名随意，地址(填服务器外网IP地址)，端口(你设置的V2Ray端口)，用户ID，额外ID:0，加密方式:auto，其他设置默认
(5）右上角 √ 保存
(6）右下角 V图标 点击启动.
(7）打开浏览器试试吧COPY
```

**(✪ω✪)**

### MacOS v2ray客户端:

https://github.com/Cenmrev/V2RayX/releases

**(✪ω✪)**

### Linux内核 v2ray客户端：

Debian、Ubantu、CentOS等电脑桌面发行版（不能完全通用，可以尝试一下）
https://github.com/jiangxufeng/v2rayL/releases
**(✪ω✪)**

### IOS v2ray客户端：

需要国外账号，推荐shadow（小火箭）rocket，quantumult（圈），kitsunebi

------

## 测试

打开浏览器，访问`www.google.com`，如下：

![16.png](https://www.itblogcn.com/wp-content/uploads/2020/04/img_5ea10e5244462-300x154.png)

v2ray搭建教程到此结束，祝大家春风得意！



## 第六部分：v2ray提速之BBR(扩展)(可选)（暂时不建议安装）

篇幅问题请移步这边文章 https://www.itblogcn.com/article/bbr-plus.html

## 不想折腾怎么办？

搬瓦工官方梯子CN2 GIA线路：https://www.itblogcn.com/article/1012.html