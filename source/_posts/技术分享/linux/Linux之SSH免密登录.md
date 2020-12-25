---
title: Linux之SSH免密登录
abbrlink: 2578104319
date: 2017-08-18 17:59:25
cover: https://cdn.tanxz.com/images/category/linux.jpeg
top_img: https://cdn.tanxz.com/images/post/default_top_img.jpg
tags: 
  - Linux
---



安装Linux/Ubuntu的阿里云ECS默认情况下是使用账号+密码通过SSH登录的，并且默认账户是root，所以这里难免会有安全隐患。
因此这里记录一下：Linux/Ubuntu系统怎么设置普通用户（非root用户），本教程以admin用户为例，使用秘钥登录通过SSH登录远程服务器。

# 本地端流程
## 检查本地SSH Key
检查本地是否已经存在SSH Key秘钥，输入下面的命令来检查本地是否已经存在秘钥，如果有下面结果则跳过该步，若没有那么接下来的步骤生成秘钥

    $ ls -a ~/.ssh
    .		..		authorized_keys	id_rsa		id_rsa.pub	known_hosts

## 生成本地SSH Key秘钥
输入以下命令，默认会在相应路径下（~/.ssh）生成id_rsa和id_rsa.pub两个文件，如下面代码所示

     # 注：若需要免密码登录则直接回车
     ~$ ssh-keygen -t rsa -C "your_email@example.com"   
     Enter file in which to save the key (/your_home_path/.ssh/id_rsa): 
     Enter passphrase (empty for no passphrase): 
     Enter same passphrase again: 
     Your identification has been saved in /your_home_path/.ssh/id_rsa.
     Your public key has been saved in /your_home_path/.ssh/id_rsa.pub.
     The key fingerprint is:
     SHA256:YgZkAauw6YCWAWwvfiMgJ7zBGkVbFqgRxQ7hdet5nGY your_email@example.com
     The key's randomart image is:
     +---[RSA 2048]----+
     |BO=++o           |
     |Bo++. .          |
     |oOo ..           |
     |+==...o .        |
     |X+.  o+ES        |
     |=X + o+.         |
     |.oX .            |
     |..               |
     |                 |
     +----[SHA256]-----+

# 服务器端流程
创建普通用户
使用root用户操作以下命令创建普通用户：
## 创建用户并修改密码

    useradd admin
    passwd admin
    vi /etc/sudoers                                 # 增加用户su身份，编辑sudoers文件
    admin ALL=(ALL:ALL) ALL                         # 在最底部加入这一行，保存退出

## 添加ssh key公钥配置
使用root用户操作以下命令创建存储密钥的文件夹及文件
> <font color=red>**注意：第三步是最重要的一步！！！**</font>

     mkdir /home/admin/.ssh
     chmod 700 /home/admin/.ssh                       
     vi /home/admin/.ssh/authorized_keys            #创建authorized_keys文件，并将本地生成的id_rsa.pub的内容填入authorized_keys
     chmod 600 /home/admin/.ssh/authorized_keys     #设置authorized_keys权限
     chown -R admin:admin /home/admin/.ssh/         #修改用户组和用户所有权
     systemctl stop sshd                            #暂停ssh服务
     systemctl start sshd                           #启动ssh服务

## 设置SSH登录安全配置（可选步骤）
> **温馨提示：SSH登录安全配置建议，使用root用户操作以下命令**

     # 编辑SSH配置文件 
     vi /etc/ssh/sshd_config
     PermitRootLogin no                             # 禁用root账号登录，该配置可不修改，避免特殊情况下需要用到root
     PasswordAuthentication no                      # 禁用账号+密码登录
     # 保存退出后，重启ssh服务
     systemctl stop sshd
     systemctl start sshd

# 本地验证登录
因为每次记ip很麻烦，推荐使用hosts映射ip，使用别名登录。
## 添加远端ip别名

    vi /etc/hosts
    xxx.xxx.xxx.xxx   my-remote-server              # 添加远端ip及映射的别名：ip  别名

## 验证ssh免密登录

    ssh admin@xxx.xxx.xxx.xxx                       # ip远程登录
    ssh admin@my-remote-server                      # 别名远程登录

   


