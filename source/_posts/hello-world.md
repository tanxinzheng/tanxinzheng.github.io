---
title: Hexo教程
tags:
  - Hexo
index_img: /img/hexo.jpeg
abbrlink: 2628717197
---
Welcome to [Hexo](https://hexo.io/)! This is your very first post. Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).

## Quick Start

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/one-command-deployment.html)

### New draft

    //新建草稿
    $ hexo new draft "new draft"

    //如果你希望强行预览草稿，更改配置文件：
    render_drafts: true
    
    //或者，如下方式启动server：
    $ hexo server --drafts
    
    //把草稿变成文章，或者页面：
    $ hexo publish [layout] <filename>