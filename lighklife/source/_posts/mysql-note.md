---
title: 神经网络
date: 2017-08-01T12:26:57.000Z
tags:
  - mysql
categories:
  - 运维
---

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [允许远程访问](#允许远程访问)
- [支持表情](#支持表情)

<!-- /TOC -->

<!-- more -->

# 允许远程访问

1. 被访问绑定地址的的修改 修改 my.cnf 文件

  ```
  [mysqld]
  bind-address    = 0.0.0.0
  ```

2. 保存并重启mysql服务

  ```sh
  $ sudo /etc/init.d/mysql restart
  ```

3. 授权用户远程链接

  ```sh
  mysql> grant all privileges on *.* to root@"%" identified by "password" with grant
  option;
  mysql> flush privileges;
  ```
# 支持表情
1. my.cnf 添加以下内容
```
[mysqld]
character-set-server = utf8mb4
collation-server = utf8mb4_general_ci
init_connect='SET NAMES utf8mb4'
skip-character-set-client-handshake = true

[client]
default-character-set=utf8mb4

[mysql]
default-character-set=utf8mb4
```
2. 重启服务
```sh
$ sudo /etc/init.d/mysql restart
```
3. 修改对应的数据库，表，字段
