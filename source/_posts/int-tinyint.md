---
title: mysql 无符号数值类型与JAVA数值类型映射问题
date: 2023-01-26 22:33:42
categories: 关于开发的琐事
tags: 
- mysql
- java
description: 有些问题, 遇到了才算问题, mysql unsigned之前都从来没设置过, 也咩有leader专门指出来, 看来不用unsigned, 还是有两分道理
---
mysql 无符号数值类型与JAVA数值类型映射问题

### 起因
之前忙着弄的项目1.0, 准备迁移到2.0了, 需要专门做数据迁移,正好活也分了一部分过来, 遇到问题, 一个预期返回值类型为 Integer的值, 实际返回了Long类型回来, 导致结果映射错误, 一开始感觉没有道理呀, 开发环境没有遇上呀, 为啥测试环境能出这个问题, 登上测试环境, 一看数据库 这个字段 类型 是 int unsigned, 开发环境这个字段是tinyint unsigned

### 定位
开发环境和测试环境, 数据表字段类型不一致, 估摸就是升级脚本有问题, 我们开发环境一般都是直接新装, 测试环境都一直升级, 查了一下升级脚本, 果然是升级脚本的问题
建表语句给定的类型是
 tinyint unsigned
而升级脚本里面给定的类型是
 int unsigned
在Java中, 无符号数值并没有直接的原生类型支持. Java的整数类型（byte, short, int, long）都是有符号的, int unsigned 最大值已经超过Integer最大值了, 只能用Long接收

### 感想
真的少用unsigned, 和JAVA不太搭, 容易给别人埋坑