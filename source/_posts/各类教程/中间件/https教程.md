---
title: 如何申请SSL免费证书
categories: 技术
tags:
	- https
	- ssl
abbrlink: 1125805289
cover: /images/category/https.jpg
date: 2020-12-10 21:38:18
---

> 搭建https协议网上有许多教程，但各种因为网站的搭建情况都有很多特殊情况导致有些场景出现>  问题，这里分别整理了不同业务场景对应的搭建教程。

<!-- more -->

#### Certbot申请证书

> 适用场景：拥有服务器权限，可命令行操作服务器

请直接参考该文章：[Nginx 通过 certbot 为网站自动配置 SSL 证书并续期](https://blog.51cto.com/wzlinux/2385116)

#### Freessl申请证书
> 适用场景：服务器在第三方平台，没有操作服务器的权限只有配置证书的权限

之前在使用OSS搭建Hexo博客时由于OSS存储服务器是由阿里云控制的，无法使用certbot的方式安装证书，又不想用阿里云的证书，查找实践许久终于找到了一种靠谱的解决方案，就是使用https://freessl.cn/平台的Keymanager工具，方便快捷有效。

- 首先，注册https://freessl.cn/的账号（注册就不截图了）

- 下载KeyManger工具，下载地址：https://keymanager.trustasia.com/release/KeyManager-Setup-4.4.19.exe

- 安装好之后，登录注册FreeSSL后进入KeyManager，如下图

![image-20201217233631334](../../img/image-20201217233631334.png)

- 申请证书，填写证书信息，如图

![image-20201217233848143](../../img/image-20201217233848143.png)

- 获取DNS验证信息

![image-20201217234030155](../../img/image-20201217234030155.png)

- 将验证信息填入阿里云解析记录，如下图，完成后点击上一步的【我已配置完成】。

![image-20201217232930044](../../img/image-20201217232930044.png)

- 进入证书管理可看到生成的证书，点击证书详情

![image-20201217233140546](../../img/image-20201217233140546.png)

- 获取证书PEM信息，如下图，到这一步就OK了，拿到这个证书，怎么配置就看你怎么用，是直接上传到服务器还是使用OSS证书托管都可以。

![image-20201217233418235](../../img/image-20201217233418235.png)