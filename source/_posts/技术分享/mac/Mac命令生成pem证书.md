---
title: Mac使用openssl生成pem证书
abbrlink: 250724269
categories: 
	- 技术实践
tags:
	- RAS
	- Mac
date: 2018-12-07
cover: /images/category/macos.png
top_img: /images/post/default_top_img.jpg
---

#### 安装

openssl，若已安装则跳过

```
brew install openssl
```

#### 生成RSA私钥

使用openssl来生成RSA私钥文件，输入如下命令(该命令会生成2048位的私钥)

```
openssl genrsa -out rsa_private_key.pem 2048
```

显示如下结果则生成私钥成功

```
MacBook-Pro-6:pem tanxinzheng$ openssl genrsa -out rsa_private_key.pem 2048
Generating RSA private key, 2048 bit long modulus
....................+++
.+++
e is 65537 (0x10001)
MacBook-Pro-6:pem tanxinzheng$ ll
total 8
-rw-r--r--  1 tanxinzheng  staff  1675 Dec 17 18:45 rsa_private_key.pem
```

查看私钥文件内容，RSA私钥格式如下：

> 注：因太长.....省略部分内容

```
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAzVHzaYFDgEDhIllCBZppYKsaLdYaC9D7IdkBMqroteeHRCaW
rUgGa0urV8tLygJ5B+l1YBg9EGXouilMEkuX/JsuYCUnqi3M0iqAFYWIyX7sXoKG
p3OkXlj9lMYS9mwAm4MqS6n5AmWK9JqlfPdYhImkxzt/njmQRJCLjNl7fHh6sc1R
G7YzjiZQxDH6xQDQAjXM77OXbTLxNqWWsi0Gn8dObD0G/kuQEWFJpmIBbzT9zizv
........
2xYP/ZoYb6wAe4PzYlJTi/rD8vBdLuBqBKInBfHDe4WvUgOv4Xiu1vxs7lDPyPw5
2RnLAoGBANpHS9MdFlO6CtOVC1HYMifGY4LcxN7mnJJld2LP7v08pRzhwokMaIBu
cBH/R0utDLsU9nivvdKjeacQ70pLPpAqDLsQWQxLvOXLLCooLC3RJqpsQp1l4g/I
sqBVHkCKFTWAw7K28sZdchBHtM/ELH5Tbac2uPEEWtDpzBJ8n4on
-----END RSA PRIVATE KEY-----
```

#### 生成RSA公钥

使用如下命令生成公钥：

```
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
```

显示如下结果则生成公钥成功

```
MacBook-Pro-6:pem tanxinzheng$ openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
writing RSA key
MacBook-Pro-6:pem tanxinzheng$ ll
total 16
-rw-r--r--  1 tanxinzheng  staff  1675 Dec 17 18:45 rsa_private_key.pem
-rw-r--r--  1 tanxinzheng  staff   451 Dec 17 18:47 rsa_public_key.pem
```

查看公钥文件内容，RSA公钥格式如下：

```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzVHzaYFDgEDhIllCBZpp
YKsaLdYaC9D7IdkBMqroteeHRCaWrUgGa0urV8tLygJ5B+l1YBg9EGXouilMEkuX
/JsuYCUnqi3M0iqAFYWIyX7sXoKGp3OkXlj9lMYS9mwAm4MqS6n5AmWK9JqlfPdY
hImkxzt/njmQRJCLjNl7fHh6sc1RG7YzjiZQxDH6xQDQAjXM77OXbTLxNqWWsi0G
n8dObD0G/kuQEWFJpmIBbzT9zizvWsI5gc3jl1Ifp3urk+cexWmZpqavCRK08aee
5+yqXOk3xk8dqjX4zk6J66bDbiEYQXZcZTaCnTDDiZ4/UiqTue9lKZeUoveuwIfX
WwIDAQAB
-----END PUBLIC KEY-----
```



