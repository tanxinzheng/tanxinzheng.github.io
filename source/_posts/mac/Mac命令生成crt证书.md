---
abbrlink: 250724270
---

# 参考资料

> [openssl命令详解](https://www.jianshu.com/p/e311a6537467)

------

# 常规方式

- 生成私钥(key文件)
  `openssl genrsa -out client.key 4096`
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200804191059375.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxODc0OTMw,size_16,color_FFFFFF,t_70)
  ![[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-gikNX2aZ-1596539441689)(evernotecid://90B54479-F8FA-4F06-9F90-73E6593C6866/appyinxiangcom/27458002/ENResource/p74)]](https://img-blog.csdnimg.cn/20200804191113618.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxODc0OTMw,size_16,color_FFFFFF,t_70)
- 生成签名请求(csr文件)
  `openssl req -new -key client.key -out client.csr`
  ![[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-lPkpDIT9-1596539441690)(evernotecid://90B54479-F8FA-4F06-9F90-73E6593C6866/appyinxiangcom/27458002/ENResource/p75)]](https://img-blog.csdnimg.cn/20200804191128743.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxODc0OTMw,size_16,color_FFFFFF,t_70)
- 签发证书
  `openssl x509 -req -days 365 -in client.csr -signkey client.key -out client.crt`
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200804191353313.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxODc0OTMw,size_16,color_FFFFFF,t_70)

------

# 一键生成自签名证书

`openssl req -new -x509 -newkey rsa:4096 -keyout test.key -out test.crt`
![[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-jt7UJ692-1596539441692)(evernotecid://90B54479-F8FA-4F06-9F90-73E6593C6866/appyinxiangcom/27458002/ENResource/p76)]](https://img-blog.csdnimg.cn/20200804191401941.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxODc0OTMw,size_16,color_FFFFFF,t_70)

> tips
> 输入的密码必须大于等于4位。
> Common Name可以输入：*.yourdomain.com，这种方式生成通配符域名证书。
> 证书文件crt中存储的是证书信息与公钥信息，key文件存储的是私钥信息，csr是申请证书所需要的中间文件。