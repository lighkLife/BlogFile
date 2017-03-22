---
title: 记hexo写作图片与多机器协作问题解决
date: 2017-0３-22 22:42:03
categories: 工具
tags: 工具
---

{% cq %}
1. 使用hexo进行写作，一直困扰于图片问题，不想用图床，今天尝试图片前缀使用http://username.github.io解决了使用本地图片的问题。
2. 写作的过程难免需要多台机器同时期写作，于是在github新建了一个项目专门用来存管hexo写作的工作空间，解决来多机器写作问题。
{% endcq %}

<!--more-->

## 1. Hexo 写作图片问题解决
打开配置文件　`_config.yml` 的资源文件夹属性：
```
post_asset_folder: true
```
这样在source文件夹下新建目录可以当做资源文件夹，里面的文件会被发布在可供外部访问的博客系统中，于是我们在source下新建文件夹如下：
![hexo文件夹目录](http://lighklife.github.io/img/2017/hexo_dir.png)
我在souce下新建了　img/2016 文件夹，然后在里面存放了一下饿图片，比如Throwable.png，这样在我的文章里面引用这张图片:
```
## 3.异常有哪些种类？ ##

![Java异常层次结构](http://lighklife.github.io/img/2016/Throwable.png)
```
这样就可以展示在我的博客中:
![hexo中使用本地图片效果](http://lighklife.github.io/img/2017/hexo_use_image_example.png)

## 2.多台机器写作
1. 在github新建项目blog，然后clone到本地.
2. 在blog文件夹下新建文件夹lighklife作为hexo　写作的工作空间.
3. cd到工作空间lighklife下, 使用`hexo init`初始化工作空间。
4. 回到blog文件夹下，`git add -f --all`,　让提交推送到github,这样就完成了第一次初始化。
5. 注意使用`git status`查看是否把所有的文件已经add，若没有，请单独强制add.
如此每次写作完毕只需要在blog目录下使用git 提交推送到远程，然后在另一台机器继续写作前使用git来拉取最新文件，就可以继续写作。
