---
layout: post
category: "Default"
description: "如何使用 dot 工具进行流程图绘制"
title:  "绘图工具 dot 的使用"
date: 2017-01-21 16:14:59+00:00
tags: [dot, graphviz]
---

最近使用了一下 dot 工具进行绘图，记录一下一些感受。

## 简介

简介摘自百度百科：

>Graphviz 的是 AT&T Labs Research 开发的图形绘制工具,他可以很方便的用来绘制结构化的图形网络,支持多种格式输出,生成图片的质量和速度都不错。Graphviz 本身是开源的产品,并且在 windows、Linux 和 MacOS 上都可以顺利运行.

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

![test.svg](http://www.eltaera.com//imgs/2017-01-21-test.svg)

## 层级

再看一段代码，作为 Redmine 工作状态轮转图来看:

    digraph workflow {
    	graph [charset="utf-8"];
    	node [fontsize=10, shape=box];
    
    	label = "软件被指派方工作流程";
    
    	// Software user flow
    	subgraph softwareUserFlow {
    		{
    			node [fontsize=10, shape=plaintext];
    			edge [style=invis];
    			layer0[label="第一层"]; // [style=invis];
    			layer1[label="第二层"]; // [style=invis];
    			layer2[label="第三层"]; // [style=invis];
    			layer3[label="第四层"]; // [style=invis];
    
    			layer0->layer1->layer2->layer3;
    		}
    
    		swuf_new                [label = "新建"];
    		swuf_doing              [label = "进行中"];
    		swuf_delay              [label = "延期"];     // 进行态?
    		swuf_delayCauseByOther  [label = "外因延期"]; // 进行态?
    		swuf_pause              [label = "暂停"];
    		swuf_cancle             [label = "取消"];
    		swuf_finish             [label = "完成"];
    		swuf_closed             [label = "关闭"];
    
    
    
    		{rank = same; layer0; swuf_new}
    		{rank = same; layer1; swuf_doing ; swuf_delay ; swuf_delayCauseByOther}
    		{rank = same; layer2; swuf_pause}
    		{rank = same; layer3; swuf_cancle ; swuf_cancle ; swuf_finish ; swuf_closed}
    
    		//	node [fontsize=10, shape=box];
    		//	edge [style=filled];
    
    		edge [color = green];
    		swuf_new -> swuf_doing;
    		swuf_new -> swuf_delay;
    		swuf_new -> swuf_delayCauseByOther;
    		swuf_new -> swuf_pause;
    		swuf_new -> swuf_cancle;
    
    		edge [color = blue1];
    		swuf_doing -> swuf_delay;
    		swuf_doing -> swuf_delayCauseByOther;
    		swuf_doing -> swuf_pause;
    		swuf_doing -> swuf_cancle;
    		swuf_doing -> swuf_finish;
    
    		edge [color = orange1];
    		swuf_delay -> swuf_delayCauseByOther;
    		swuf_delay -> swuf_pause;
    		swuf_delay -> swuf_cancle;
    		swuf_delay -> swuf_finish;
    
    		edge [color = pink];
    		swuf_delayCauseByOther -> swuf_pause;
    		swuf_delayCauseByOther -> swuf_cancle;
    		swuf_delayCauseByOther -> swuf_finish;
    
    		edge [color = lightgray];
    		swuf_pause -> swuf_doing;
    		swuf_pause -> swuf_delay;
    		swuf_pause -> swuf_delayCauseByOther;
    		swuf_pause -> swuf_cancle;
    	}
    }

图片如下：

![redmine工作状态轮转图](http://www.eltaera.com//imgs/2017-01-21-projm.svg)

上述图中，我们使用了多组子图。子图的简单调用方法是：

    {rank = same; layer0; swuf_new}

其中，rank=same 的含义是：子图中所有元素处于同一位置，后面的 layer0 和 swuf_new 是子图中的两个节点。

我们建立了多个 layer，通过让他们之间的连线 edge 的属性设置为 invis，来实现图形的控制，让图形变得更好看一些。

需要注意的是，<b>节点的声明顺序决定了节点在图中出现的顺序。声明越早的节点，出现在图的层次结构上的位置越靠前</b>，即上下排布时靠上，左右排布时靠左。

## 总结

使用 dot 进行绘图的方式还是很方便的。通过定义节点和节点间的链接关系，可以轻松的生成一副图标。在写图标注释时，我们也可以直接参照节点间的链接关系进行编写，减少了重复思考的时间，保证的工作的连续性。
