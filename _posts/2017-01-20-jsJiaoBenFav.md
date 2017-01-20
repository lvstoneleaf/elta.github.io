---
layout: post
category: "Default"
description: "利用js脚本创建收藏夹快捷方式，完成批量操作"
title:  "利用js脚本实现页面操作"
date: 2017-01-20 13:54:58+00:00
tags: [Default]
---

通常来讲，想要用 js ( Javascript ) 脚本实现页面操作，可以通过建立浏览器插件，进行 js 脚本的调用，完成对页面的本地操作。

由于公司内网用的是 IE 浏览器，所以在这个方面是，我还是选择了使用收藏夹调用快捷方式的方式，进行 js 脚本的调用。

## 浏览器调用 js

在使用浏览器时，由于 js 脚本是由本地浏览器解释执行的，所以用户也可以自己编写 js 脚本实现一些功能。

第一个示例，让浏览器弹出 “Hello world!”:

    javascript: alert("Hello world!");
    
将上述代码复制，粘贴到地址栏，然后点击回车按钮，浏览器会显示一个弹窗，内容为 “Hello worl!d”

## 获取页面元素

获取页面元素的方法，可以通过 id 来获取页面中的标签。调用方法如下

    var ele = document.getElementById("eleID"); // 获取对象
    var eleV = document.getElementById("eleID").value; // 获取对象的值

通过上述两种方法，我们可以得到一个元素，和一个元素的值。

</br>
如果当页面中具有 Frame，我们可以选择使用下面的这种方法进行调用：

    var win = document.getElementById("frameID").contentWindow
    win.getElementById("frameEleID")

通过上面这个方法，我们就得到了子页面的窗口，以及页面子窗口中的元素。

## 更多脚本的写法

当脚本数据不止一行时，可以先进行换行编写，然后粘贴到浏览器中进行调用

    javascript:
    var msg = "Hello world"
    alert(msg);

将上面代码框中的全部信息一起复制下来，粘贴到浏览器地址栏，也可以实现信息打印。

## 将脚本放到收藏夹中

进入浏览器收藏夹目录，创建一个快捷方式，目标地址选择为上述脚本的全部信息。

创建完成后，打开浏览器，在浏览器中点击该快捷方式，调用效果和在地址栏中粘贴一致。

## 总结

js 脚本的写法还有很多种，上面提到的方法并不是全面的方法。更多关于 js 脚本的使用方法还请看相应的学习资料。