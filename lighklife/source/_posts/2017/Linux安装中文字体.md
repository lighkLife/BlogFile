---
title: Linux 安装中文字体
date: 2017-01-03 22:26:03
categories: OS
tags: [OS, Linux]
---



两中方式可供选择
### 1.将新字体安装在JDK中
```shell
cd $JAVA_HOME/jre/lib/fonts
mkdir fallback
cp xxx.ttf fallback #xxx.ttf代表你想要的中文字体文件
cd fallback
mkfontscale
mkfontdir
```
*有的机器需要安装mkfontscale*

>重启项目，项目即可使用新加的中文字体


### 2.也可以选择在操作系统中安装新字体
```shell
# centos先安装fontconfig来安装字体库
yum -y install fontconfig

cd /usr/shared/fonts
mkdir chinese
cp xxx.ttf /usr/shared/fonts/chinese #xxx.ttf代表你想要的中文字体文件
chmod -R 755 /usr/share/fonts/chinese
# ttmkfdir来搜索目录中所有的字体信息，并汇总生成fonts.scale文件
yum -y install ttmkfdir
```
```
# 修改系统字体配制文件，添加新建的字体文件夹
vim /etc/fonts/fonts.conf
```
![修改系统字体配制文件.PNG](http://lighklife.github.io/img/2016/修改系统配置文件.png)

```
fc-cache
fc-list
```

![添加字体成功.PNG](http://lighklife.github.io/img/2016/添加字体成功.png)
>重启项目，项目即可使用新加的中文字体
