---
layout: post
category: "Default"
description: "9.2.1 4s 越狱降级教程，成功恢复到 6.1.3 系统"
title:  "9.2.1 4s 越狱降级到 6.1.3 系统"
date: 2017-01-26 10:26:00+00:00
tags: [4s, downgrade]
---

## 简介
最近 iPhone 4s 9.x 系列的越狱工具 Trident 出来了，对于非 9.3.5 的 4s 用户来说又迎来了降级 6.1.3 的机会。

在威锋上看到已经有人做出了新的降级教程，心痒难耐，果断把自己的 4s 掏出来，试着开始降级。

中间的尝试过程略去不表，只说最终我使用了的方法。

原本的 4s 越狱过程是需要登录到 4s 上，启动一个 kloader。然而这一次的 Trident 越狱并没有安装 cydia，所以在网上有人做了 Trident + kloader 的软件版本，在越狱完成后，直接运行了 kloader 加载的相应的文件。

我们需要的工具有：

```
1. Trident-kloader.ipa
2. idevicediagnostics for windows
3. fistmedaddy.ipsw
```

## 具体步骤
我们需要进行的操作步骤是：

1. 安装 Trident-kloader 程序，点击一次 start 按钮进行运行，之后等待手机苹果花屏一下。start 按钮点且只点一次，请谨记。点击完成，屏幕花屏一下之后，屏幕上应该会显示 w00t root，此时手机处于了已越狱 + kloader 加载完毕的状态。
2. 使用 idevicediagnostics 中的 idevicediagnostics 命令，执行    
```
idevicediagnostics.exe sleep
```  
3. 待到设备黑屏，按几下home键。如果设备屏幕没有亮，此时设备应当处于了 DFU 模式。如果屏幕亮了，请关机重启，返回步骤 1 进行执行。
4. 设备进入 DFU 模式后，使用 idevicediagnostics 工具中的 idevicerestore.exe 工具，执行  
```
idevicerestore.exe -e ..\fistmedaddy.ipsw
```  
然后可以看到以下 log 信息:

```
C:\odysseusOTA4WIN\未命名文件夹 3\idevicerestore for Windows>idevicerestore.exe
-e ..\fistmedaddy.ipsw
NOTE: using cached version data
Found device in DFU mode
Identified device as iPhone4,1
Extracting BuildManifest from IPSW
Product Version: 6.1.3
Product Build: 10B329 Major: 10
Device supports Image4: false
Variant: Customer Erase Install (IPSW)
This restore will erase your device data.
Found ECID 741328094092
Getting ApNonce in dfu mode... be 99 05 f9 82 f4 88 9f 76 df d6 69 00 f1 ed fb 29 7c 42 1e
Trying to fetch new SHSH blob
Getting SepNonce in dfu mode...
WARNING: Unable to find BbSkeyId node
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 1... response successfully received
Received SHSH blobs
Extracting filesystem from IPSW
Extracting iBSS.n94ap.RELEASE.dfu...
Personalizing IMG3 component iBSS...
reconstructed size: 76110
Sending iBSS (76110 bytes)...
Nonce: be 99 05 f9 82 f4 88 9f 76 df d6 69 00 f1 ed fb 29 7c 42 1e
Extracting iBEC.n94ap.RELEASE.dfu...
Not personalizing component iBEC...
Sending iBEC (279576 bytes)...
INFO: device serial number is DYKN444BFML6
Getting ApNonce in recovery mode... be 99 05 f9 82 f4 88 9f 76 df d6 69 00 f1 ed fb 29 7c 42 1e
Sending APTicket (2764 bytes)
Recovery Mode Environment:
iBoot build-version=iBoot-1537.9.55
iBoot build-style=RELEASE
Sending AppleLogo...
Extracting applelogo@2x.s5l8940x.img3...
Not personalizing component AppleLogo...
Sending AppleLogo (15204 bytes)...
Extracting 048-2516-005.dmg...
Personalizing IMG3 component RestoreRamDisk...
reconstructed size: 9955562
Sending RestoreRamDisk (9955562 bytes)...
Extracting DeviceTree.n94ap.img3...
Not personalizing component RestoreDeviceTree...
Sending RestoreDeviceTree (80872 bytes)...
Extracting kernelcache.release.n94...
Personalizing IMG3 component RestoreKernelCache...
reconstructed size: 7753898
Sending RestoreKernelCache (7753898 bytes)...
About to restore device...
Waiting for device...
Device is now connected in restore mode...
Connecting now...
Connected to com.apple.mobile.restored, version 12
Device has successfully entered restore mode
Hardware Information:
BoardID: 8
ChipID: 35136
UniqueChipID: 741328094093
ProductionMode: true
Partition NAND device (28)
Waiting for storage device (11)
Creating partition map (12)
Creating partition map (12)
Verifying restore (15)
Checking filesystems (16)
Verifying restore (15)
Checking filesystems (16)
Waiting for NAND (29)
Waiting for NAND (29)
About to send RootTicket...
Sending RootTicket now...
Done sending RootTicket
About to send filesystem...
Connected to ASR
Validating the filesystem
Filesystem validated
Sending filesystem now...
Done sending filesystem
Restoring image (14)
Verifying restore (15)
Checking filesystems (16)
Verifying restore (15)
Checking filesystems (16)
About to send KernelCache...
Extracting kernelcache.release.n94...
Personalizing IMG3 component KernelCache...
reconstructed size: 7754074
Sending KernelCache now...
Done sending KernelCache
Loading kernelcache (27)
Mounting filesystems (17)
Unknown operation (25)
About to send NORData...
Found firmware path Firmware/all_flash/all_flash.n94ap.production
Getting firmware manifest Firmware/all_flash/all_flash.n94ap.production/manifes

Extracting LLB.n94ap.RELEASE.img3...
Personalizing IMG3 component LLB...
reconstructed size: 150042
Extracting iBoot.n94ap.RELEASE.img3...
Not personalizing component iBoot...
Extracting DeviceTree.n94ap.img3...
Not personalizing component DeviceTree...
Extracting applelogo@2x.s5l8940x.img3...
Not personalizing component AppleLogo...
Extracting batterylow0@2x.s5l8940x.img3...
Not personalizing component BatteryLow0...
Extracting batterylow1@2x.s5l8940x.img3...
Not personalizing component BatteryLow1...
Extracting glyphcharging@2x.s5l8940x.img3...
Not personalizing component BatteryCharging...
Extracting batterycharging0@2x.s5l8940x.img3...
Not personalizing component BatteryCharging0...
Extracting batterycharging1@2x.s5l8940x.img3...
Not personalizing component BatteryCharging1...
Extracting glyphplugin@2x.s5l8940x.img3...
Not personalizing component BatteryPlugin...
Extracting batteryfull@2x.s5l8940x.img3...
Not personalizing component BatteryFull...
Extracting recoverymode@2x~iphone.s5l8940x.img3...
Not personalizing component RecoveryMode...
Sending NORData now...
Done sending NORData
Unknown operation (18)
Unknown operation (46)
Unknown operation (46)
Flashing NOR (19)
About to send BasebandData...
WARNING: Unable to find BbSkeyId node
Sending Baseband TSS request...
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 1... response successfully received
Received Baseband SHSH blobs
Sending BasebandData now...
Done sending BasebandData
Flashing NOR (19)
Flashing NOR (19)
Flashing NOR (19)
Flashing NOR (19)
Updating Baseband in progress...
About to send BasebandData...
WARNING: Unable to find BbSkeyId node
Sending Baseband TSS request...
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 1... response successfully received
Received Baseband SHSH blobs
Sending BasebandData now...
Done sending BasebandData
Updating Baseband in progress...
About to send BasebandData...
Sending BasebandData now...
Done sending BasebandData
Flashing NOR (19)
Flashing NOR (19)
Updating Baseband in progress...
About to send BasebandData...
Sending BasebandData now...
Done sending BasebandData
Updating Baseband completed.
Unknown operation (49)
Unknown operation (51)
Waiting for NAND (29)
Waiting for NAND (29)
Got status message
Status: Restore Finished
Cleaning up...
DONE
```

最终出现 DONE 后，手机会进入恢复模式，可以看到界面变成了 6.1.3 的样子。等待恢复完成，成功的回到了 6.1.3 系统。

## 注意事项：

1. Trident-kloader 我是从源码编译的，最初几次点完了现象不正常，可能是因为我安装了多个 Trident。最后只剩下一个 Trident-kloader 的时候，关机-开机-运行 Trident-kloader 执行后，成功了。成功的效果就是屏幕右侧花了一下，其它并没有任何异常。
2. 在执行 restore  的时候，最开始一直会报错，错误信息如下：

```
C:\odysseusOTA4WIN\未命名文件夹 3\idevicerestore for Windows>idevicerestore.exe
-e ..\fistmedaddy.ipsw
NOTE: Updated version data.
Found device in DFU mode
Identified device as iPhone4,1
Extracting BuildManifest from IPSW
Product Version: 6.1.3
Product Build: 10B329 Major: 10
Device supports Image4: false
Variant: Customer Erase Install (IPSW)
This restore will erase your device data.
Found ECID 741328094093
Getting ApNonce in dfu mode... be 99 05 f9 82 f4 88 9f 76 df d6 69 00 f1 ed fb 29 7c 42 1e
Trying to fetch new SHSH blob
Getting SepNonce in dfu mode...
WARNING: Unable to find BbSkeyId node
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 1... Failed to connect to gs.apple.com port 443: Co
nection refused
Request URL set to https://17.171.36.30/TSS/controller?action=2
Sending TSS request attempt 2... Failed to connect to 17.171.36.30 port 443: Ti
ed out
Request URL set to https://17.151.36.30/TSS/controller?action=2
Sending TSS request attempt 3... Failed to connect to 17.151.36.30 port 443: Ti
ed out
Request URL set to http://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 4... Failed to connect to gs.apple.com port 80: Con
ection refused
Request URL set to http://17.171.36.30/TSS/controller?action=2
Sending TSS request attempt 5... Failed to connect to 17.171.36.30 port 80: Tim
d out
Request URL set to http://17.151.36.30/TSS/controller?action=2
Sending TSS request attempt 6... Failed to connect to 17.151.36.30 port 80: Tim
d out
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 7... Failed to connect to gs.apple.com port 443: Co
nection refused
Request URL set to https://17.171.36.30/TSS/controller?action=2
Sending TSS request attempt 8... Failed to connect to 17.171.36.30 port 443: Ti
ed out
Request URL set to https://17.151.36.30/TSS/controller?action=2
Sending TSS request attempt 9... Failed to connect to 17.151.36.30 port 443: Ti
ed out
Request URL set to http://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 10... Failed to connect to gs.apple.com port 80: Co
nection refused
Request URL set to http://17.171.36.30/TSS/controller?action=2
Sending TSS request attempt 11... Failed to connect to 17.171.36.30 port 80: Ti
ed out
Request URL set to http://17.151.36.30/TSS/controller?action=2
Sending TSS request attempt 12... Failed to connect to 17.151.36.30 port 80: Ti
ed out
Request URL set to https://gs.apple.com/TSS/controller?action=2
Sending TSS request attempt 13... Failed to connect to gs.apple.com port 443: C
nnection refused
Request URL set to https://17.171.36.30/TSS/controller?action=2
Sending TSS request attempt 14... Failed to connect to 17.171.36.30 port 443: T
med out
Request URL set to https://17.151.36.30/TSS/controller?action=2
Sending TSS request attempt 15... Failed to connect to 17.151.36.30 port 443: T
med out
ERROR: TSS request failed: Failed to connect to 17.151.36.30 port 443: Timed ou
 (status=-1)
ERROR: Unable to send TSS request
ERROR: Unable to get SHSH blobs for this device
```

导致这个错误的原因是在 hosts 文件中，gs.apple.com 被重定向了。解决的方法是，打开 hosts 文件，删掉 gs.apple.com 的信息。
hosts 文件位置：
```
C:\Windows\System32\Drivers\etc\hosts
```

## 参考信息及致谢：

感谢 Trident 越狱工具制作者：[工具地址](https://github.com/benjamin-42/Trident)

感谢 Trident + kloader 工具制作者：[工具地址](https://github.com/ganoninc/trident-kloader-updated)

感谢 <b>极端阴险</b> 在威锋上提供的越狱降级教程：[原创开发-v1.0.2.5更新 English version [For iPad2]-(Mac/Win)iPhone4s/iPad2 iOS9](https://bbs.feng.com/forum.php?mod=viewthread&tid=10998777&extra=page%3D1)

感谢 <b>hogan_wang</b> 在威锋上提供的 restore 错误信息解决方法：[解决降级ERROR：Unable to send TSS、ERROR unable to get SHSH blobs for ...](http://bbs.feng.com/read-htm-tid-9678225.html)


 
