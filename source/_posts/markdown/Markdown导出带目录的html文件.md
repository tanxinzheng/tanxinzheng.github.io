---
title: Markdown导出带目录的html文件
categories: Markdown
tags:
	- Markdown
abbrlink: 3058308324
date: 2017-10-15 12:10:23
---

## 安装插件

使用下面命令进行全局安装：

```
npm install -g i5ting_toc
1
```

------

## 插件用法

安装好 i5ting_toc 后，就可以使用简单的命令了。比如输入`i5ting_toc -h`查看插件用法，如下图示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190905160156342.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG56b3VxaQ==,size_16,color_FFFFFF,t_70)

------

## md 文件转 html 文件

**这里我在本地给大家演示一遍。**

- 进入md文件所在目录

如下图示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190905160538563.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG56b3VxaQ==,size_16,color_FFFFFF,t_70)

- 输入命令`i5ting_toc -f index.md -o`

如下图示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190905160831569.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG56b3VxaQ==,size_16,color_FFFFFF,t_70)

命令执行完后，md文件目录下生成了一个preview文件夹，我们需要的html文件夹就在里面，然后直接浏览器打开这个html即可。如下图示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190905161030886.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG56b3VxaQ==,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190905161108879.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG56b3VxaQ==,size_16,color_FFFFFF,t_70)

希望本文对各位同学能有所帮助！