---
title: Windows下git配置ssh密钥
tags:
  - git
categories:
  - 技术分享
abbrlink: 41928510
cover: https://cdn.tanxz.com/images/category/git-logo.jpg
top_img: https://cdn.tanxz.com/images/post/default_top_img.jpg
date: 2020-12-10 22:33:34
---



#### 检查用户.SSH目录

若存在则直接使用已生成的ssh公私密钥，跳过生成SSH公私密钥步骤

**若需要免密提交则要保证生成的ssh公私密钥是未输入密码的**

```
PS C:\Users\tanxz\.ssh> ls

    目录: C:\Users\tanxz\.ssh


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        2020/12/16      0:31           1679 id_rsa
-a----        2020/12/16      0:31            402 id_rsa.pub
-a----        2020/12/16      0:34            185 known_hosts
```

#### 生成SSH公私密钥

```c++
C:\Users\tanxz> ssh-keygen -t rsa -C "tanxinzheng@139.com"
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\tanxz/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\Users\tanxz/.ssh/id_rsa.
Your public key has been saved in C:\Users\tanxz/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:9BM2DGD4+BKfyMjWhrP0b4xdHlk4I9JG/dJB0BwR0Nc tanxinzheng@139.com
The key's randomart image is:
+---[RSA 2048]----+
|     .oo+B=+ .   |
|    ... .o= . E  |
|     =  .+=o     |
|    + =.=o+o     |
| . = B oS*o      |
|  B * + +  .     |
| o = = o .       |
|  . o + .        |
|     o.          |
+----[SHA256]-----+
```

#### 添加SSH公钥到github和gitee

打开.ssh目录下的id_rsa.pub文件，复制里面的内容，到github和gitee设置中找到的SSH key的信息，添加即可。

#### 测试是否ssh密钥是否有效

```
C:\Users\tanxz\.ssh> ssh -T git@github.com
Hi tanxinzheng! You've successfully authenticated, but GitHub does not provide shell access.
PS C:\Users\tanxz\.ssh> ssh -T git@gitee.com
Hi tanxinzheng! You've successfully authenticated, but GITEE.COM does not provide shell access.
```

若显示以上信息，恭喜你以后终于不用输入密码了！！：）

