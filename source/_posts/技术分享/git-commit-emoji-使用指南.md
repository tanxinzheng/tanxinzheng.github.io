---
title: git commit emoji 使用指南
categories:
  - 技术分享
keywords:
  - java
  - git
  - emoji
  - tanxz博客
  - tanxz blog
  - hexo
  - butterfly
  - 博客
  - blog
top_img: 'https://cdn.tanxz.com/images/post/default_top_img.jpg'
toc_number: true
abbrlink: 1018026521
date: 2020-12-24 23:11:41
updated:
tags:
description:
comments:
cover: https://cdn.tanxz.com/images/post/20201226164703.jpeg
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



## 目录

- [commit 格式](https://github.com/liuchengxu/git-commit-emoji-cn#commit-格式)
- [emoji 指南](https://github.com/liuchengxu/git-commit-emoji-cn#emoji-指南)
- [如何在命令行中显示 emoji](https://github.com/liuchengxu/git-commit-emoji-cn#如何在命令行中显示-emoji)
- 参考
  - [git commit emoji](https://github.com/liuchengxu/git-commit-emoji-cn#git-commit-emoji)
  - [write a good commit message](https://github.com/liuchengxu/git-commit-emoji-cn#write-a-good-commit-message)

执行 `git commit` 时使用 emoji 为本次提交打上一个 "标签", 使得此次 commit 的主要工作得以凸现，也能够使得其在整个提交历史中易于区分与查找。

截取的 [gitmoji](https://github.com/carloscuesta/gitmoji) 快照:

[![gitmoji-snapshot](https://cdn.tanxz.com/images/post/20201224231547.png)](https://github.com/liuchengxu/git-commit-emoji-cn/blob/master/snapshot.png)

## commit 格式

`git commit` 时，提交信息遵循以下格式：

```
:emoji1: :emoji2: 不超过 50 个字的摘要，首字母大写，使用祈使语气，句末不要加句号

提交信息主体

引用相关 issue 或 PR 编号 <#110>
```

初次提交示例：

```
git commit -m ":tada: Initialize Repo"
```

## emoji 指南

| emoji             | emoji 代码                    | commit 说明           |
| ----------------- | ----------------------------- | --------------------- |
| 🎉 (庆祝)          | `:tada:`                      | 初次提交              |
| 🆕 (全新)          | `:new:`                       | 引入新功能            |
| 🔖 (书签)          | `:bookmark:`                  | 发行/版本标签         |
| 🐛 (bug)           | `:bug:`                       | 修复 bug              |
| 🚑 (急救车)        | `:ambulance:`                 | 重要补丁              |
| 🌐 (地球)          | `:globe_with_meridians:`      | 国际化与本地化        |
| 💄 (口红)          | `:lipstick:`                  | 更新 UI 和样式文件    |
| 🎬 (场记板)        | `:clapper:`                   | 更新演示/示例         |
| 🚨 (警车灯)        | `:rotating_light:`            | 移除 linter 警告      |
| 🔧 (扳手)          | `:wrench:`                    | 修改配置文件          |
| ➕ (加号)          | `:heavy_plus_sign:`           | 增加一个依赖          |
| ➖ (减号)          | `:heavy_minus_sign:`          | 减少一个依赖          |
| ⬆️ (上升箭头)      | `:arrow_up:`                  | 升级依赖              |
| ⬇️ (下降箭头)      | `:arrow_down:`                | 降级依赖              |
| ⚡ (闪电) 🐎 (赛马) | `:zap:` `:racehorse:`         | 提升性能              |
| 📈 (上升趋势图)    | `:chart_with_upwards_trend:`  | 添加分析或跟踪代码    |
| 🚀 (火箭)          | `:rocket:`                    | 部署功能              |
| ✅ (白色复选框)    | `:white_check_mark:`          | 增加测试              |
| 📝 (备忘录) 📖 (书) | `:memo:` `:book:`             | 撰写文档              |
| 🔨 (锤子)          | `:hammer:`                    | 重大重构              |
| 🎨 (调色板)        | `:art:`                       | 改进代码结构/代码格式 |
| 🔥 (火焰)          | `:fire:`                      | 移除代码或文件        |
| ✏️ (铅笔)          | `:pencil2:`                   | 修复 typo             |
| 🚧 (施工)          | `:construction:`              | 工作进行中            |
| 🗑️ (垃圾桶)        | `:wastebasket:`               | 废弃或删除            |
| ♿ (轮椅)          | `:wheelchair:`                | 可访问性              |
| 👷 (工人)          | `:construction_worker:`       | 添加 CI 构建系统      |
| 💚 (绿心)          | `:green_heart:`               | 修复 CI 构建问题      |
| 🔒 (锁)            | `:lock:`                      | 修复安全问题          |
| 🐳 (鲸鱼)          | `:whale:`                     | Docker 相关工作       |
| 🍎 (苹果)          | `:apple:`                     | 修复 macOS 下的问题   |
| 🐧 (企鹅)          | `:penguin:`                   | 修复 Linux 下的问题   |
| 🏁 (旗帜)          | `:checkered_flag:`            | 修复 Windows 下的问题 |
| 🔀 (交叉箭头)      | `:twisted_rightwards_arrows:` | 分支合并              |

## 如何在命令行中显示 emoji

默认情况下，在命令行中并不会显示出 emoji, 仅显示 emoji 代码。不过可以使用 [emojify](https://github.com/mrowa44/emojify) 使得在命令行也可显示 emoji, 它是一个 shell 脚本，安装与使用都很简单，在 [这里](https://github.com/mrowa44/emojify) 查看如何安装与使用。

[![emojify](https://cdn.tanxz.com/images/post/20201224231547.png)](https://github.com/liuchengxu/git-commit-emoji-cn/blob/master/terminal_emojify.png)

## 参考

### git commit emoji

- [gitmoji](https://github.com/carloscuesta/gitmoji/)
- [emoji-cheat-sheet](http://www.webpagefx.com/tools/emoji-cheat-sheet/)
- [styleguide-git-commit-message](https://github.com/slashsBin/styleguide-git-commit-message)
- [atom git commit messages guide](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#git-commit-messages)
- [An emoji guide for your commit messages](https://gitmoji.carloscuesta.me/)
- [程序员提交代码的 emoji 指南——原来表情文字不能乱用](https://www.h5jun.com/post/gitmoji.html)
- [Ant Design 更新日志 emoji 规范](https://github.com/ant-design/ant-design/wiki/轮值规则和版本发布流程#emoji-for-changelog)

### write a good commit message

- [A Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
- [How to write a Git Commit Message (2014)](https://news.ycombinator.com/item?id=13889155)
- [how to write a good git commit message](https://github.com/joelparkerhenderson/git_commit_message)
- [5 Useful Tips For A Better Commit Message](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
- [Udacity Git Commit Message Style Guide](http://udacity.github.io/git-styleguide/)
- [How to commit a change with both “message” and “description” from the command line?](https://stackoverflow.com/questions/16122234/how-to-commit-a-change-with-both-message-and-description-from-the-command-li)