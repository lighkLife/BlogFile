---
title: ubuntu 休眠后无法链接wifi
date: 2017-03-07 00:33:03
categories: OS
tags: [OS, Linux]
description: ubuntu 16.04 update 后发现只有一休眠，唤醒后就无法链接自动链接到网络，在官放论坛找到解决方式。
---
### 1. 临时解决方式 ###
如果不嫌麻烦可以在在不能连接网络的时候重启网络服务
```sh
sudo service network-manager restart
```
或者在右上角去掉　`Enable Wi-Fi` , 然后又再次勾选上，wifi 即可用。

### 2. 彻底解决 ###
在ubuntu的论坛找到[解决方案](http://askubuntu.com/questions/762198/16-04-lts-wifi-connection-issues),这是一个 network-manager 的 bug.

>Finally I was able to fix the issues after trying out numbers of different methods.
>1. Get details of your PCI wireless card by running <br>
```sh
sudo lshw -class network
```
>2. Get your card model info according to the product line. For instance, as you can see in the question >description it says product: `RTL8723BE PCIe Wireless Network Adapter` so the model of my card is RTL8723BE
>3. Open or create `/etc/pm/config.d/config` and add SUSPEND_MODULES="rtl8723be"(replace rtl8723be with your >own model number) Then run
```sh
echo "options rtl8723be fwlps=N" | sudo tee /etc/modprobe.d/rtl8723be.conf
```
>and reboot.


>Now your system should be able to reconnect automatically after sleep, and wifi connection never got lost once for me after doing this.<br>
"The up/down arrows is likely a network manager bug that results in network manager thinking the wifi device is actually ethernet.", according to Jeremy31.see bug info here You should be able to fix it by installing NetworkManager-1.2.0.
