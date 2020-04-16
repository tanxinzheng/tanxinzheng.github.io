---
title: 基于Github Action工作流自动部署Hexo
date: 2020-04-16 11:54:14
tags: [Hexo, Github]
index_img: /img/default_thumbnail.jpg

---

# Hexo搭建
这段就pass了，只要这篇主要讲解Github Action部署

# 创建github ssh 私钥和公钥
在本地运行如下命令生成id_rsa和id_rsa.pub文件，一路回车，不要输入密码！！！不要输入密码！！！不要输入密码！！！（被这个坑的我想哭T_T，一直验证不通过）
```cmd
$ ssh-keygen -t rsa -C "tanxinzheng@139.com" #此处修改为你github的注册邮箱
```

# Github设置
- 将id_rsa私钥放入项目的settings/secures配置中
- 将id_rsa.pub公钥填入账号的settings/SSH keys配置中

# 创建Github Action工作流脚本

在项目该目录下创建~./.github/workflows/main.yml文件，将下面的配置信息填入，并修改自己的信息即可

```yml
name: CI
on:
  push:
    branches:
      - generate-source
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source
        uses: actions/checkout@v1
        with:
          ref: generate-source
      - name: Use Node.js ${{ matrix.node_version }}
        uses: actions/setup-node@v1
        with:
          version: ${{ matrix.node_version }}
      - name: Setup hexo
        env:
          ACTION_DEPLOY_KEY: ${{ secrets.HEXO_DEPLOY_PRI }}
        run: |
          mkdir -p ~/.ssh/
          echo "$ACTION_DEPLOY_KEY" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan github.com >> ~/.ssh/known_hosts
          git config --global user.email "tanxinzheng@139.com"
          git config --global user.name "tanxinzheng"
          npm install hexo-cli -g
          npm install
      - name: Hexo deploy
        run: |
          hexo clean
          hexo d
```

# Github Action执行部署
在Github Action页面执行即可，push之后会自动部署。