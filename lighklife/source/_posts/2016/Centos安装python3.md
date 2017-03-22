---
title: Centos安装python3
date: 2016-12-17 18:26:03
categories: Python
tags: [Python, Programming Language]
---

#### 1. 首先安装一些python需要的库

```shell
yum groupinstall 'Development Tools'
yum install zlib-devel bzip2-devel  openssl-devel ncurses-devel sqlite-devel
```

<!--more-->

#### 2. 下载python 源码编译安装

```bash
$ wget  https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tar.xz
tar Jxvf  Python-3.5.0.tar.xz
$ cd Python-3.5.0
./configure --prefix=/usr/local/python3
make && make install
```

#### 3. python3.5 源码安装时会自动安装pip
如果没有pip，可以手动下载get-pip.py安装pip。

```sh
$ wget https://bootstrap.pypa.io/get-pip.py
$ python get-pip.py
```

#### 4. 最后创建软链接
```sh
$ ln -sv  /usr/local/python3/bin/python3 /usr/bin/python3
$ ln -sv  /usr/local/python3/bin/pip3 /usr/bin/pip3
```
