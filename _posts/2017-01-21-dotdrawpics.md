---
layout: post
category: "Default"
description: "如何使用 dot 工具进行流程图绘制"
title:  "绘图工具 dot 的使用"
date: 2017-01-21 16:14:59+00:00
tags: [dot, graphviz]
---

最近使用了一下 dot 工具进行绘图，记录一下一些感受。

## 安装 DOT
在 Ubuntu 上可以通过 apt-get 来安装 dot工具，命令如下：
    
    sudo apt-get install graphviz

在 MacOS 上安装 DOT，可以使用 brew 直接进行安装。安装的命令是：

    brew install graphviz

如果系统中存在其它名称为 dot 的工具，可以通过修改 bashrc 来使工具生效。方法是在 bashrc 中增加 alias：

    alias dot=${HOME}/opt/brew/bin/dot

## 使用

在使用 dot 工具前，需要先创建一个 dot 文件，例如 test.dot：

    digraph G {
    	subgraph {
    		main -> parse -> execute;
    		main -> init;
    		main -> cleanup;
    		execute -> make_string;
    		execute -> printf;
    		init -> make_string;
    		main -> printf;
    		execute -> compare;
    	}
    }

然后我们创建一个 Makefile 用来进行编译，Makefile 内容如下：

    # Makefile for generate graphic
    #

    DOT=dot

    FILES=$(basename $(shell ls *.dot))
    PDFS=$(FILES:%=%.pdf)

    all: ${PDFS}

    %.png: %.dot
    	${DOT} -Tpng $< -o $@

    %.pdf: %.dot
    	${DOT} -Tpdf $< -o $@

    clean:
    	rm -rf *.pdf
    	rm -rf *.png

我们通过运行 make，完成编译，产生的图像如下：
