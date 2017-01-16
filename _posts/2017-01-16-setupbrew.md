---
layout: post
category: "Tools"
description: ""
title:  "MacOS 安装 brew"
date: 2017-01-16 13:35:20+00:00
tags: [Brew, MacOS]
---

Mac 系统上安装软件时，也可以使用像 ubuntu 一样的 apt-get 工具：brew。

现在 brew 推荐用户安装到用户目录下，而不是使用 root 权限安装到系统目录下。安装到用户目录下的 brew 所有安装软件均安装到了用户自己的目录下，方便独立管理。

安装 brew 的步骤如下：

### 1. 将 brew 安装到用户目录下
```
curl -LsSf http://github.com/mxcl/homebrew/tarball/master | tar xvz -C~/opt/brew --strip 1
```
注意：~/opt/brew 是用户目录下的文件夹，大家安装的时候可以自己根据实际情况进行修改。

### 2. 更新 brew
```
brew update
brew update
```

更新需要更新两次，所以更新命令需要执行两次。

### 3. 环境变量配置
经过上述两个步骤，brew 就已经安装到了系统中了，我们就可以通过下面的安装命令进行安装了：

```
brew install xxx
```
</br>
由于我们将 brew 安装到了用户目录下，所以在使用 brew 安装的工具前，我们需要把 brew 的 bin 目录添加到环境变量(~/.bashrc)中：

```
export PATH=${HOME}/opt/brew/bin:$PATH

```
</br>
需要注意的是，在执行上述命令时，一定要把 brew 的路径放在前面。因为 shell 在寻找工具时，是根据 PATH 中的路径寻找的，如果放在了后面，那么系统中如果有相同的工具，那么就会优先调用系统原有工具。所以我们将 brew 路径放在前面，以确保优先调用我们安装的工具。
