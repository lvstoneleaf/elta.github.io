---
layout: post
category: "Linux"
description: ""
title:  "Crontab could not create directory .ssh"
date: 2017-01-18 20:45:44+00:00
tags: [Linux, crontab, ssh， 运维]
---

最近在利用 crontab 构建自动备份时，遇到了一个问题。我的脚本中包含了用于服务器用户切换使用的 ssh 命令。当我登录到服务器上时，脚本执行正常；当我没有登录到服务器上时，脚本执行失败，错误提示是：

```
Could not create directory '/home/server/.ssh'
```

在登录到服务器上后，可以看到 “/home/server/.ssh” 路径是存在的，也是正常的。

各个用户间的 ssh key 也已经生成好了，在登录到服务器上后，手动调用主脚本，可以正常的完成脚本的执行流程，但是由 crontab 自动调用时，仍然无法正常工作。

在网上查找相关信息的时候，在 stackoverflow 上有人问类似的问题，但是并没有人给出了可行的解答。 <b>rsync code will run, but not in cron.</b> [原文链接](http://stackoverflow.com/questions/14073389/rsync-code-will-run-but-not-in-cron)

资料查找没有找到可行的结果，只能自己想办法了。因为登录和不登录结果不一样，首先怀疑是不是登录导致环境变量有所改变。为了确认这一点，我在主脚本中加入了 echo 命令，来打印 SSH 使用到的环境变量。具体的环境变量包含以下内容：

```
     DISPLAY               The DISPLAY variable indicates the location of the X11 server.  It is automatically set by ssh to point to a value of the form
                           ``hostname:n'', where ``hostname'' indicates the host where the shell runs, and `n' is an integer >= 1.  ssh uses this special value to
                           forward X11 connections over the secure channel.  The user should normally not set DISPLAY explicitly, as that will render the X11 con-
                           nection insecure (and will require the user to manually copy any required authorization cookies).

     HOME                  Set to the path of the user's home directory.

     LOGNAME               Synonym for USER; set for compatibility with systems that use this variable.

     MAIL                  Set to the path of the user's mailbox.

     PATH                  Set to the default PATH, as specified when compiling ssh.

     SSH_ASKPASS           If ssh needs a passphrase, it will read the passphrase from the current terminal if it was run from a terminal.  If ssh does not have a
                           terminal associated with it but DISPLAY and SSH_ASKPASS are set, it will execute the program specified by SSH_ASKPASS and open an X11
                           window to read the passphrase.  This is particularly useful when calling ssh from a .xsession or related script.  (Note that on some
                           machines it may be necessary to redirect the input from /dev/null to make this work.)

     SSH_AUTH_SOCK         Identifies the path of a UNIX-domain socket used to communicate with the agent.

     SSH_CONNECTION        Identifies the client and server ends of the connection.  The variable contains four space-separated values: client IP address, client
                           port number, server IP address, and server port number.

     SSH_ORIGINAL_COMMAND  This variable contains the original command line if a forced command is executed.  It can be used to extract the original arguments.

     SSH_TTY               This is set to the name of the tty (path to the device) associated with the current shell or command.  If the current session has no
                           tty, this variable is not set.

     TZ                    This variable is set to indicate the present time zone if it was set when the daemon was started (i.e. the daemon passes the value on
                           to new connections).

     USER                  Set to the name of the user logging in.

```


通过打印上述环境变量，发现登录前和登录后打印出的结果完全一致，但是没有登录的话，自动执行脚本就会提示“Could not create directory '/home/server/.ssh'”

这个问题还是很奇怪，不知道为什么会这样。为了去解决这个问题，我尝试在本地部署一个自动执行脚本，用于自动登录到服务器上调用服务器自动备份脚本，来实现自动备份。当自动登录部署完成后，发现了一个新的问题：当我登录在服务器上时，自动登录可以执行成功；当我没有登录到服务器上时，自动登录无法执行成功。<b>在没有登录上服务器时，用户目录和登录上之后不一样？？</b>

为了验证这个想法，执行一下 mount 命令，结果如下：

```
/dev/sda1 on / type ext4 (rw,errors=remount-ro)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
none on /sys/fs/cgroup type tmpfs (rw)
none on /sys/fs/fuse/connections type fusectl (rw)
none on /sys/kernel/debug type debugfs (rw)
none on /sys/kernel/security type securityfs (rw)
udev on /dev type devtmpfs (rw,mode=0755)
devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
none on /run/shm type tmpfs (rw,nosuid,nodev)
none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
none on /sys/fs/pstore type pstore (rw)
systemd on /sys/fs/cgroup/systemd type cgroup (rw,noexec,nosuid,nodev,none,name=systemd)
/home/server/.Private on /home/server type ecryptfs (ecryptfs_check_dev_ruid,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs,ecryptfs_sig=a1f33ec3321f0ef9,ecryptfs_fnek_sig=705c22000a171cfe)
```

从 mount 的结果上看，用户目录是被 mount 上的。再次进行测试，在 crontab 里通过自动脚本执行 mount 命令。对比发现，在自动执行时，用户目录是没有被挂载的。那么，这就是问题原因了：

> <b>在没有登录到服务器上时，用户目录没有被挂载。因为没有被挂载，所以用户目录的权限不对！！</b>

为了验证这个想法，再次登录到服务器上，手动将用户目录进行卸载

```
sudo umount /home/server
```

卸载掉用户目录后，再次进入目录中进行查看

```
server@gitlabserver:~$ ls -a
.  ..  Access-Your-Private-Data.desktop  
.bash_history  .ecryptfs  .kde
.Private  README.txt  .viminfo
```

我们发现，用户目录到内容变了。

因为服务器用户目录是经过了 “ecryptfs” 加密，所以在没有登录和登录后不一样。知道了这一点，解决自动登录到方法也就变得简单了：<b>将用户目录中的 .ssh 目录拷贝到卸载后的用户目录中。</b>

经过上述的拷贝，自动执行的脚本终于可以顺利执行了，问题圆满解决。