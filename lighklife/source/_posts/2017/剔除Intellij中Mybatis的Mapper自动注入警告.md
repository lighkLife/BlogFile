
---
title: 剔除Intellij中Mybatis的Mapper自动注入警告
date: 2017-07-30 16:58:03
categories:
  - Spring
tags:
	- Spring
	- IDEA
---

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [起源](#起源)
- [区别`@Controller`,`@Service`,`@Repository`,`@Component`](#区别controllerservicerepositorycomponent)
- [为什么建议构造器注入](#为什么建议构造器注入)
	- [Field injection:](#field-injection)
	- [Constructor injection:](#constructor-injection)

<!-- /TOC -->

<!-- more -->

# 起源
idea 自动注入Mapper有警告，而且又红色错误提醒（编译可以通过）
![idea 自动注入Mapper报红色警告](http://oqbaa7a72.bkt.clouddn.com/2017/mapper%E6%8A%A5%E9%94%99.png)
这很烦，不是吗？ 我受够了，得想点办法。

idea会提示
>Spring team recommends: "Always use constructor based dependency injection in your beans. Always use assertions for mandatory dependencies."

为毛Spring这样推荐哇？(⊙o⊙)嗯，按照提示先修改为：
```java
private final UserMapper userMapper;

@Autowired
public UserServiceImpl(UserMapper userMapper) {
    this.userMapper = userMapper;
}
```
此时仍然存在一个问题是idea提示
> Could not autowire.

自动注入 bean， spring帮助我们完成了，但是同时Spring提供了一些注解来显式的注明bean之间的引用关系，其中最为熟知的自然是`@Controller`,`@Service`,`@Repository`,`@Component`等。
这里其实给`UserMapper`接口加上`@Repository`,`@Component`就可以解决，那么他们之间有什么区别？

# 区别`@Controller`,`@Service`,`@Repository`,`@Component`

在[Stackoverfolw](https://stackoverflow.com/questions/6827752/whats-the-difference-between-component-repository-service-annotations-in)找到了同样的问题,得票最高的给出了一个表

| Annotation | Meaning                                             |
|   --       |  ---                                                |
| @Component  | generic stereotype for any Spring-managed component|
| @Repository| stereotype for persistence layer                    |
| @Service   | stereotype for service layer                        |
| @Controller| stereotype for presentation layer (spring-mvc)      |

也提出，使用@Service, @Controller, @Repository更好做切面，也有人给出总结：
> @Service, @Controller, @Repository = {@Component + some more special functionality}

# 为什么建议构造器注入

构造器注入与域注入
热门文章 [Why field injection is evil](http://olivergierke.de/2013/11/why-field-injection-is-evil/) 给出总结：
### Field injection:
* less code to write
* unsafe code
*  more complicated to test

### Constructor injection:
 * safe code
 * more code to write (see the hint to Lombok)
 * easy to test

Spring 的博客上指出 [Setter injection versus constructor injection and the use of @Required](https://spring.io/blog/2007/07/11/setter-injection-versus-constructor-injection-and-the-use-of-required/)
