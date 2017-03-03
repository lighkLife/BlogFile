## JAVA 泛型程序设计

### 一.为什么泛型？

使用泛型机制编写的代码要比那些杂乱的使用Object变量，然后再进行强制类型转换的代码具有更好的安全性和可读性。

```java
/* more readable */
ArrayList<String> files = new ArrayList<String>();

/* more safe */
//can only add string objects to an ArrayList<String>
files.add(new File("..."));
```
### 二. 泛型概述 ###

#### (1). Generic Class. ####
That means a class has one or more generic variables.
```Java
public class Pair<T>{

    private T first;
    private T second;

    public Pair(){
        first = null;
        second = null;
    }

    public Pair(T first, T second){
        this.first = first;
        this.second = second;
    }

    public T getFirst(){
        return first;
    }

    public T getSecond(){
        return second;
    }

    public void setFirst(T newValue){
        first = newValue;
    }

    public void setSecond(T newValue){
        second = newValue;
    }
}
```
> A generic class can be considered a factory of normal class .

#### (2). Generic Method ####
```java
class ArrayAlg{

    public static <T> T getMiddle(T ... a){
        return a[a.length / 2];
    }

    public static <T> T min(T[] a){
        if (a == null || a.length == 0){
            return null;
        }

        T smallest == a[0];
        for(int i = 1; i < a.length; i++){
            if(smallest.compareTo(a[i]) > 0){
                smallest = a[i];
            }
        }
        return smallest;
    }
}
​````
上面的`min`方法存在一个问题，若传入的类型没有`compareTo`，就会产生一个编译错误。解决这个问题，就需要进行类型变量的限定。
​```java
<K, V extends Comparable>
<T extends Comparable & Serializable>
```
`<T extends Serializable & Comparable>` 这样做原始类型为Serializable，编译器要在必要的时候要向 Comparable 插入强制类型转换，降低效率，
所以建议将标签（tagging）接口（即没有方法的接口）放在边界表的末尾。

### 三. 泛型代码与虚拟机 ###
1. 虚拟机没有泛型类型对象————所有对象都属于普通类。
2. 无论何时定义一个泛型类型，都自动提供了一个相应的 **原始类型(raw type)**。 原始类型的名字就是删去类型参数后的泛型类型名。
   **擦除(erased)** 类型变量，并替换为限定类型（无限定的变量用Object）。
3. 原始类型用第一个限定的类型变量来替换。
4. 桥方法被合成来保持多态。
### 四.约束与限定性 ###
大多数限制是由类型擦除引起的。
1. 不能用基本类型实例化类型参数。
2. 运行时类型检查只是使用于原始类型。
   虚拟机中的对象总有一个非特定的非泛型类型。因此所有的类型查询只产生原始类型。
```java
if(a instanceof Pair<String>) //error
if(a instanceof Pair<T>) //error

Pair<String> stringPair = ...;
Pair<Employee> employeePair = ...;
if(stringPair.gerClass() == employeePair.getClass()) // they are equal
```
3. 不能创建参数化的类型的数组
   `Pair<String>[] table = new Pair<String>[10]; //error `|
