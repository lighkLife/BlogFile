---
title: git 常用操作
date: 2017-07-07T12:26:57.000Z
tags: git
categories:
  - git
---

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [覆盖更新](#覆盖更新)
- [舍弃追踪某个文件](#舍弃追踪某个文件)
- [记住用户名和密码](#记住用户名和密码)
- [设置显示提交记录树图别名](#设置显示提交记录树图别名)

<!-- /TOC -->
<!-- more -->

# 覆盖更新

```bash
git fetch --all
git reset --hard origin/master
```

# 舍弃追踪某个文件
舍弃追踪 CarDataSpider/utils/DB.py
```sh
git update-index --assume-unchanged CarDataSpider/utils/DB.py
```
继续追踪
```sh
git update-index --no-assume-unchanged CarDataSpider/utils/DB.py
```

# 记住用户名和密码
```sh
git config --global credential.helper store
```

# 设置显示提交记录树图别名
```sh
git config --global alias.lg "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
```
