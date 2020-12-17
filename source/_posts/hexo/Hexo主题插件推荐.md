---
abbrlink: 3878378061
categories:
  - hexo
---

## hexo-auto-category

每个文章的配置区域都写一次分类名称太麻烦了，并且你如果想改一次分类名字就更折磨人。这个插件就很好地解决了这个问题。

hexo-auto-category会根据目录级别自动填写分类，分类名就是目录名，并且支持多级目录生成多个分类。

```yaml
# 「在Hexo配置文件里添加」

# Generate categories from directory-tree
# Dependencies: https://github.com/xu-song/hexo-auto-category
# depth: the depth of directory-tree you want to generate, should > 0
auto_category:
 enable: true
 depth: 1
```

