---
title: Python带参数的装时器
date: 2017-01-16 00:26:03
categories: Python
tags: [Python, Programming Language]
---

> 摘录整理于[imooc]( http://www.imooc.com/code/6066)

### 1. 一个带参数的`decorator`例子
例子是根据 `@performance（'time_type'）`携带的时间类型来输出所装饰的函数`factorial`的执行时间。
```python   
import time
import functools
from past.builtins.noniterators import reduce

def performance(unit):
    def perf_decorator(f):
        # @functools.wraps应该作用在返回的新函数上。
        @functools.wraps(f)
        def wrapper(*args, **kw):
            t1 = time.time()
            r = f(*args, **kw)
            t2 = time.time()
            t = (t2 - t1) * 1000 if unit == 'ms' else (t2 - t1)
            print('call %s() in %f %s' % (f.__name__, t, unit))
            return r
        return wrapper
    return perf_decorator


@performance('ms')
def factorial(n):
    return reduce(lambda x, y: x * y, range(1, n + 1))

factorial(10000)
print(factorial.__name__)
```

### 2.代参数的`decorator`为什么要包三层（三阶）？
```python  
# 为什么包三层（三阶）
@log('DEBUG')
def my_func():
    pass
# 把上面的定义翻译成高阶函数的调用，就是：

my_func = log('DEBUG')(my_func)
# 上面的语句看上去还是比较绕，再展开一下：

log_decorator = log('DEBUG')
my_func = log_decorator(my_func)
# 上面的语句又相当于：

log_decorator = log('DEBUG')
@log_decorator
def my_func():
    pass
# 所以，带参数的log函数首先返回一个decorator函数，再让这个decorator函数接收my_func并返回新函数：

def log(prefix):
    def log_decorator(f):
        def wrapper(*args, **kw):
            print('[%s] %s()...' % (prefix, f.__name__))
            return f(*args, **kw)
        return wrapper
    return log_decorator

@log('DEBUG')
def test():
    pass
print(test())
```
简而言之，最外层负责把`decorator`的参数`DEBUG`传进来，既然`decorator`携带的参数已经传进来，那么剩下的中间层和里层就是一个不带参的`decorator`的语法糖。反之而推，要多携带参数，肯定是需要多加一阶。
