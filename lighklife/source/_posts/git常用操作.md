---
title: git 常用操作
date: 2017-07-07T12:26:57.000Z
tags: git
categories:
  - git
---

### 覆盖更新 ###
```shell
git fetch --all
git reset --hard origin/master
```

### 舍弃追踪某个文件 ###
```
# 舍弃追踪 CarDataSpider/utils/DB.py
git update-index --assume-unchanged CarDataSpider/utils/DB.py
# 继续追踪
git update-index --no-assume-unchanged CarDataSpider/utils/DB.py
```
