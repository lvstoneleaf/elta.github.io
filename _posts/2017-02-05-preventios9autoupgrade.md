---
layout: post
category: "ios"
description: "阻止 iOS9 系统自动更新到 iOS 10"
title:  "阻止 iOS9 系统自动升级到 iOS 10"
date: 2017-02-05 11:14:01+00:00
tags: [ios, upgrade, prevent]
---

> <b>用于阻止自动更新的描述文件在文章最后，不想看分析的朋友可以直接拖到页面最下方点击安装。</b>

今天从网上看到了一篇教程，用来阻止 iOS 9 系统自动更新到 iOS 10。看完之后查找了一下相关信息，在这里把我整理的信息贴出来。

## 方法原理

安装描述文件 “tvOS Beta Apple Developer V1” 来屏蔽 iOS 9 系统的自动更新。

看文件名，这个描述文件应该是用于 tvOS 开发者使用的，但是有网友发现这个描述文件可以安装到 iPhone 上，而且可以实现阻止 iPhone （iOS 9）自动更新的功能。

所以，根据网上提供的方法，在手机上直接安装 “tvOS Beta Apple Developer V1” 描述文件，就可以完成对 iOS 9 系统自动更新的屏蔽。

## 分析

既然知道了安装上述描述文件，那么为什么这个描述文件能够阻止 iOS 9 的自动更新呢？

我在网上找到了这个描述文件，打开文件后，发现下述信息：


核心信息：

```
	<key>PayloadContent</key>
				<array>
					<dict>
						<key>DefaultsDomainName</key>
						<string>.GlobalPreferences</string>
						<key>DefaultsData</key>
						<dict>
							<key>SeedGroup</key>
							<string>PublicBeta</string>
						</dict>
					</dict>
					<dict>
						<key>DefaultsDomainName</key>
						<string>com.apple.seeding</string>
						<key>DefaultsData</key>
						<dict>
							<key>SeedProgram</key>
							<string>DeveloperSeed</string>
						</dict>
					</dict>
					<dict>
						<key>DefaultsDomainName</key>
						<string>com.apple.appleseed.FeedbackAssistant</string>
						<key>DefaultsData</key>
						<dict>
							<key>SBIconVisibility</key>
							<true/>
						</dict>
					</dict>
					<dict>
						<key>DefaultsDomainName</key>
						<string>com.apple.MobileAsset</string>
						<key>DefaultsData</key>
						<dict>
							<key>MobileAssetSUAllowOSVersionChange</key>
							<false/>
							<key>MobileAssetSUAllowSameVersionFullReplacement</key>
							<false/>
							<key>MobileAssetServerURL-com.apple.MobileAsset.SoftwareUpdate</key>
							<string>http://mesu.apple.com/assets/tvOSDeveloperSeed</string>
							<key>MobileAssetServerURL-com.apple.MobileAsset.MobileSoftwareUpdate.UpdateBrain</key>
							<string>http://mesu.apple.com/assets/tvOSDeveloperSeed</string>
						</dict>
					</dict>
				</array>
```

其中让我关注的几行信息是：

```
    <key>MobileAssetSUAllowOSVersionChange</key>
    <false/>
    <key>MobileAssetSUAllowSameVersionFullReplacement</key>
    <false/>
```

上述两行信息描述了阻止系统版本改变，以及不允许系统变更。所以有理由怀疑是上述两行描述文件阻止了系统的更新。

## 制作描述文件

既然有了猜测，那么我们可以开始自己制作描述文件实验一下了。

制作 iOS 描述文件，需要使用 MacOS 和 Apple Configurator 2 管理工具。

在 Apple Configurator 2 工具中，通过点击菜单栏 File - New Profile，新建一个描述文件。从左侧栏就可以看到，有许多可配置的选项。因为一个空白的描述文件无法进行安装，所以我们先对通用中的文本信息进行配置，然后点击访问限制，进行配置。

在访问限制中，我们虽然点击了配置，但是不要更改权限。默认情况下，权限都是正常的。点击配置后，我们直接进行保存，就得到了一个配置文件。

在得到配置文件后，我们需要将我们分析得到的信息添加到配置文件中去。即打开配置文件，在 PayloadContent 的 dict 中增加上文中的核心信息，然后对描述文件进行保存。保存后的描述文件就具有了阻止系统更新的功能。

## 安装描述文件

安装描述文件的方法很简单，在 iOS 系统中，通过浏览器访问描述文件，然后在确认安装就可以了。

在使用描述文件前，需要确认系统中没有已经下载好的 iOS 系统更新。如果系统更新已经下载好了需要删除。删除的方法是：进入 “设置 - 通用 - 存储空间与 iCloud 用量 - 管理存储空间”，在管理存储空间中找到系统更新安装包，点击安装包进入安装包信息界面后，点击删除按钮进行删除。

可以用来安装的描述文件链接如下：

1. [网上提供的 “tvOS Beta Apple Developer V1”](http://elta.github.io/imgs/2017-02-05_NOOTA9.mobileconfig)


2. [我自制的 "preventIOS9UpgradeIOS10"](http://elta.github.io/imgs/2017-02-05_preventios9byelta.mobileconfig)

## 参考文献

1. [达人每日教程：不越狱照样屏蔽系统OTA更新的方法](http://bbs.feng.com/forum.php?mod=viewthread&tid=10342211&page=)
2. [如何创建 iOS 的描述文件](https://paicha.me/2016/01/09/how-to-create-ios-profiles/?utm_source=tuicool&utm_medium=referral)
