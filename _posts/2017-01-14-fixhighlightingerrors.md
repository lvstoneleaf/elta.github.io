---
layout: post
category: "Default"
description: ""
title:  "Github 博客，修复高亮错误"
date: 2017-01-14
tags: [Github, Highlighter]
---

Github 博客搭建完成后，github 上显示可以正常创建，但是邮箱中一直收到一个警告信息，提示 highlighter 配置了一个过时的版本，需要更新。根据提示进行了页面配置的更新，在 _config.yml 中增加了 highlighter 的设置。

更新后的 _config.yml 文件内容如下：

```
permalink: /:categories/:title.html
url: 
lsi: false
pygments: true
safe: true
auto: false 

paginate: 8
paginate_path: "page:num"

# presonal config
title: Elta's Blog
description: Elta's Blog, powered by Jekyll...
author: Dongxue Zhang

seo: 
  keyword: 
  description: 
config:
  js_dir:
  img_dir:
  css_dir:
```
