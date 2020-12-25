---
title: Java【基础篇之HashMap及hashcode】
tags:
  - Java
abbrlink: 2936205123
date: 2019-10-10 10:12:00
cover: https://cdn.tanxz.com/images/category/java.jpeg
top_img: https://cdn.tanxz.com/images/post/default_top_img.jpg
---
## 一、hashcode是什么
要理解hashcode首先要理解hash表这个概念

1. 哈希表
hash表也称散列表（Hash table），是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表。
给定表M，存在函数f(key)，对任意给定的关键字值key，代入函数后若能得到包含该关键字的hashcode是什么记录在表中的地址，则称表M为哈希(Hash）表，函数f(key)为哈希(Hash) 函数。
简单理解就是：在记录的存储位置和它的关键字之间建立一个确定的对应关系f，使每个关键字和结构中一个唯一的存储位置相对应。
具有快速查找和插入操作的优点
2. hashcode
hashcode 通过hash函数计算得到，hashcode就是在hash表中有对应的位置
每个对象都有hashcode，通过将对象的物理地址转换为一个整数，将整数通过hash计算就可以得到hashcode
## 二、hashcode的作用
    HashCode的存在主要是为了查找的快捷性，HashCode是用来在散列存储结构中确定对象的存储地址的

    对于容器类设计 基本上都会涉及到hashCode。在Java中也一样，hashCode方法的主要作用是为了配合基于散列的集合一起正常运行，这样的散列集合包括HashSet、HashMap以及HashTable。

   在对集合进行插入操作时，集合内时是不允许存在重复元素的，这样就引发了一个问题

   如何判别在集合中是否已经存在该对象了？

   首先想到的方法就是调用equals()方法，这个方法确实可行。但是如果集合中已经存在大量的数据或者更多的数据，如果采用equals方法去逐一比较，效率必然是一个问题。    此时hashCode方法的作用就体现出来了，当集合要添加新的对象时，先调用这个对象的hashCode方法，得到对应的hashcode值，实际上在HashMap的具体实现中会一个表保存已经存进去的对象的hashcode值，如果table中没有该hashcode值，它就可以直接存进去，不用再进行任何比较了；如果存在该hashcode值， 就调用它的equals方法与新元素进行比较，相同的话就不存了，不相同就散列其它的地址，所以这里存在一个冲突解决的问题，这样一来实际调用equals方法的次数就大大降低了。

    这也就解释了为什么equals()相等，则hashCode()必须相等。如果两个对象equals()相等，则它们在哈希表(如HashSet、HashMap等)中只应该出现一次；如果hashCode()不相等，那么它们会被散列到哈希表的不同位置，哈希表中出现了不止一次。

            所以说hashCode方法的存在是为了减少equals方法的调用次数，从而提高程序效率。

## 三、 hashCode()和equals()
Java的基类Object中的 equals()方法用于判断两个对象是否相等，hashCode()方法用于计算对象的哈希码。equals()和hashCode()都不是final方法，都可以被重写(overwrite)

1. equals方法
Object类中equals()方法实现如下

```java
public boolean equals(Object obj) {
    return (this == obj);
}
```
通过该实现可以看出，Object类的实现采用了区分度最高的算法，即只要两个对象不是同一个对象，那么equals()一定返回false。

虽然可以重写equals()方法，但是有一些注意事项；JDK中说明了实现equals()方法应该遵守的约定

自反性：x.equals(x)必须返回true。
对称性：x.equals(y)与y.equals(x)的返回值必须相等。
传递性：x.equals(y)为true，y.equals(z)也为true，那么x.equals(z)必须为true。
一致性：如果对象x和y在equals()中使用的信息都没有改变，那么x.equals(y)值始终不变。
非null：x不是null，y为null，则x.equals(y)必须为false。
2. hashCode 方法
Object类中hashCode()方法的声明如下：

public native int hashCode();
可以看出，hashCode()是一个native方法，而且返回值类型是整形；实际上，该native方法将对象在内存中的地址作为哈希码返回，可以保证不同对象的返回值不同。

与equals()方法类似，hashCode()方法可以被重写。JDK中对hashCode()方法的作用，以及实现时的注意事项做了说明：

（1）hashCode()在哈希表中起作用，如java.util.HashMap。
（2）如果对象在equals()中使用的信息都没有改变，那么hashCode()值始终不变。
（3）如果两个对象使用equals()方法判断为相等，则hashCode()方法也应该相等。
（4）如果两个对象使用equals()方法判断为不相等，则不要求hashCode()也必须不相等；但是开发人员应该认识到，不相等的对象产生不相同的hashCode可以提高哈希表的性能。
重写hashcode()的原则

（1）如果重写了equals()方法，检查条件“两个对象使用equals()方法判断为相等，则hashCode()方法也应该相等”是否成立，如果不成立，则重写hashCode ()方法。
（2）hashCode()方法不能太过简单，否则哈希冲突过多。
（3）hashCode()方法不能太过复杂，否则计算复杂度过高，影响性能
hashCode()重写方法

《Effective Java》中提出了一种简单通用的hashCode算法：

初始化一个整形变量，为此变量赋予一个非零的常数值，比如int result = 17;

选取equals方法中用于比较的所有域（之所以只选择equals()中使用的域，是为了保证上述原则的第1条），然后针对每个域的属性进行计算：

复制代码
(1) 如果是boolean值，则计算f ? 1:0
(2) 如果是bytecharshortint,则计算(int)f
(3) 如果是long值，则计算(int)(f ^ (f >>> 32))
(4) 如果是float值，则计算Float.floatToIntBits(f)
(5) 如果是double值，则计算Double.doubleToLongBits(f)，然后返回的结果是long,再用规则(3)去处理long,得到int
(6) 如果是对象应用，如果equals方法中采取递归调用的比较方式，那么hashCode中同样采取递归调用hashCode的方式。否则需要为这个域计算一个范式，比如当这个域的值为null的时候，那么hashCode 值为0
(7) 如果是数组，那么需要为每个元素当做单独的域来处理。java.util.Arrays.hashCode方法包含了8种基本类型数组和引用数组的hashCode计算，算法同上。 
复制代码
最后，把每个域的散列码合并到对象的哈希码中。

## 四、HashMap中的hash()函数
HashMap中并没有直接使用KV中K原有的hash值; 在HashMap的put、get操作时也未直接使用K中原有的hash值，而使用了一个hash()方法。让我们一起看一下这个方法
```
static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```
这段代码类似作用是为了增加hashcode的随机性

key.hashCode()的作用是返回键值key所属类型自带的hashcode，返回的类型是int，如果直接拿散列值作为下标访问HashMap的主数组的话，考虑到int类型值的范围[-2^31 , 2^31 -1]，虽然只要hash表映射比较松散的话，碰撞几率很小，但是映射空间太大，内存放不下，所以先做对数组的长度取模运算，得到的余数才能用来访问数组下标。

hashMap源码中模运算是在这个indexFor( )函数里完成的把散列值和数组长度-1做一个"与"操作

static int indexFor(int h, int length) { return h & (length-1);}
这也正好解释了为什么HashMap的数组长度要取2的整数幂。因为数组长度-1相当于一个“低位掩码”。“与”操作的结果就是散列值的高位全部归零，只保留低位值.以初始长度16为例，16-1=15。2进制表示是00000000 00000000 00001111。和某散列值做“与”操作如下，结果就是截取了最低的四位值。h & (length - 1) 和 h % length，它俩是等价不等效的，明显位运算效率非常高。
  01111010 00111100 00100101
& 00000000 00000000 00001111
----------------------------------
  00000000 00000000 00000101
  //高位全部归零，只保留末四位 
but 只取后四位，即使散列值分布再松散，碰撞几率还是很大。更糟糕的是如果散列函数做的比较差吧，分布上成个等差数列啥的，恰好使最后几个低位呈现规律性重复，就比较蛋疼。

这时候 “hash”函数作用就出来了

右位移16位，正好是32bit的一半，高半区和低半区做异或，就是为了混合原始哈希码的高位和低位，以此来加大低位的随机性。而且混合后的低位掺杂了高位的部分特征，这样高位的信息也被变相保留下来。
设计者考虑到现在的hashCode分布的已经很不错了，而且当发生较大碰撞时也用树形存储降低了冲突。仅仅异或一下，少了系统的开销，也不会造成因为高位没有参与下标的计算(table长度比较小时)，从而引起的碰撞。
根据研究结果显示，当HashMap数组长度为512的时候，也就是用掩码取低9位的时候，在没有使用hash()的情况下，发生了103次碰撞，接近30%。而在使用了hash()之后只有92次碰撞。碰撞减少了将近10%。看来扰hash()函数在将降低碰撞上还是有功效的。
hashMap中 MAXIMUM_CAPACITY = 1 << 30;最大为2的30次方（超过这个值就将threshold修改为Integer.MAX_VALUE（此时表的大小已经是2的31次方了），表明不进行扩容了）