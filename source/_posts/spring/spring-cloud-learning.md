---
title: Spring Cloud 微服务架构全链路实践
categories: 
  - Java
  - Spring Cloud
tags:
  - Spring
  - Spring Cloud
  - Java
index_img: /img/spring-cloud.jpeg
abbrlink: 1879991184
date: 2016-08-16 00:04:12
---

Java 微服务框架选型（Dubbo 和 Spring Cloud）

{% asset_img 1.png %}

目前公司使用的 Spring Cloud 整个技术组件，基本包含了上面图中所包含的，不得不说，Spring Cloud 整个生态真的很强大，使用起来也很方便有效。

后面有时间再针对每个组件进行使用解读，这篇文章主要说下 Spring Cloud 架构的链路图，顺便把自己的思路整理下来，以备查阅。

{% asset_img 2.png %}

# 网关请求流程

在 Spring Cloud 整个组件库中，Spring Cloud Zuul 是最容易被忽视，但也是最重要的，Spring Cloud Zuul 可以和 Eureka 注册中心集成，我们目前使用 Spring Cloud Zuul 的功能如下：
- Filter 过滤器
- Router 路由
- Ribbon 负载均衡
- Hystrix 熔断
- Retry 重试
有些功能是 Spring Cloud Zuul 自带的，比如 Filter 和 Router，有些是结合 Spring Cloud 其他组件，比如 Ribbon 和 Hystrix。

这里重点介绍下 Filter 过滤器，分为四个过滤类型：
- pre：Zuul 转发请求之前执行，我们目前的实现是AccessTokenFilter，用于 oAuth2.0 JWT 的授权验证。
- route：Zuul 路由时执行，目前项目没用到。
- post：Zuul 路由转发后执行，也就是已经请求成功了后端服务，我们目前的实现是CustomResponseFilter，用于统一请求格式的封装，比如 code/msg/data 等。
- error：以上过滤器发生错误时执行，我们目前的实现是CustomErrorFilter，用于拦截过滤器执行的出现的错误，然后统一格式封装返回，另外，error 过滤器好像并不能捕获后端服务执行出现的错误。

另外，关于 oAuth2.0 JWT 的授权验证，实现的方式有两种：
- 授权的配置在后端服务中（每个服务都需要当作 Resource Server 进行配置，需要配置公钥，接口的授权具体配置在注解中），Zuul 只做转发，并不进行授权的验证。
- 授权的配置在 Zuul 中，也就是把 Zuul 当作 Resource Server，后端服务不需要进行任何处理，Zuul 中具体的实现就是AccessTokenFilter，里面的逻辑是手动解析 JWT，然后判断是否正确，以及解析出用户信息/Scope/Role，然后根据当前的请求 API，对授权 Map 中的配置进行匹配，如果匹配错误，直接抛出 401 授权错误。
我们目前采用的是第二种方式，这两种方式都有利有弊，关键在于自己的取舍，为什么采用第二种方式？目的就是发挥 Zuul 的作用，对外网关进行统一授权验证。

关于授权 Map，里面存储了所有服务接口的配置，示例配置：
```
private static final Map ROUTE_MAPS;
static {
    ROUTE_MAPS = new HashMap();
    ROUTE_MAPS.put("eureka-client/home", "read:ROLE_ADMIN");
    ROUTE_MAPS.put("eureka-client/user", "read:ROLE_ADMIN");
    ROUTE_MAPS.put("eureka-client/error", "read:ROLE_ADMIN");
}
```


这是我们目前的配置，是一个静态的 Map，后面会存储在 Spring Cloud Config 配置中心，Zuul 启动时进行加载，利用 Spring Cloud Bus 动态刷新。

关于 Zuul 网关，其实还有很多需要说的，后面有机会再进行针对说明。

# Eureka 服务治理

{% asset_img 3.png %}

Eureka 遵循的是 AP 原则（服务可用性和分区容错性），是服务治理最理想的遵循 CAP 分布式原则。

Eureka 集群中的节点是彼此平级，不像 Consul 有 master/worker 之分，集群中的 Eureka 节点彼此两两注册，所以，Eureka 集群最好部署三个节点，这也是我们目前的部署方式。

另外，Eureka 的自我保护机制，可以参考这篇文章。

服务之间的相互调用，负载有两种使用方式：
- Feign：基于声明式，顾名思义，就是需要定义接口，就像我们平常使用对象调用一样。
- Ribbon：软负载，通过往 RestTemplate 中注入负载 Handler，然后通过负载算法选取调用（通过 Eureka 获取服务注册信息）。
我们目前打算使用 Ribbon 负载方式，为什么？看下面代码就知道了：

```
restTemplate.getForObject("http://eureka-client/hello", String.class);
```

# Config 配置中心

{% asset_img 4.png %}

我们目前配置中心使用的是 Spring Cloud Config，当然你也可以使用功能更强大的 Polly（携程开源），但 Config 目前也能满足我们的需求，存储仓库我们现在使用的是 Git。

Config 配置中心提供了数据加密功能，你可以使用 RSA 的加密方式，这样存储在 Git 中的配置都是密文形式，Config Client 获取加密配置的时候，Config Server 会自动进行解密返回。

配置中心的使用场景，我们目前主要是两个地方：

- 项目启动的配置信息，比如数据库的连接字符串等。
- 业务服务的配置信息，也就是业务相关的配置。

另外，需要说明的是，默认情况下，如果 Git 中的配置更新了，Config Client 不会进行更新配置，我们目前的解决方式是，使用 Spring Cloud Bus 进行动态刷新配置（Config Server 中配置），具体的流程：
1. Git 中添加 WebHooks 脚本，比如curl -X POST http://manager1:8180/bus/refresh，当 Git 仓库中的配置更新后，自动执行。
2. Config Server 中配置 Spring Cloud Bus，接受 Git 的配置刷新请求，然后利用 RabbitMQ 广播通知所有的 Config Client 订阅方，刷新配置信息。

# Hystrix 监控

{% asset_img 5.png %}

Hystrix 主要是用于服务熔断/降级/隔离处理，Hystrix 配置在调用方，当被调用方服务不可用时，触发 Hystrix 熔断，会执行指定的 Fallback 方法，进行特殊处理。

我之前以为，Hystrix 熔断的触发条件是服务不可用，也就是服务请求超时（比如服务挂掉了），但我自己测试了下，服务出现 500 错误，也会触发 Hystrix 熔断，而且会自动忽略 Hystrix 的超时时间设置。

我们目前使用 Hystrix，主要有两个地方：
- 内部服务调用：可以对某个 API 接口进行熔断处理。
- Zuul 网关使用：就是当 Zuul 路由转发调用时，但有个局限性，就是只能对服务进行熔断，并不能针对某个 API 接口熔断。

上面图中，主要画的是 Hystrix 的监控流程，我们目前主要使用 RabbitMQ 进行采集传输，turbine-server 进行数据流的聚合，hystrix-dashboard 进行图形化的展示。

# 服务调用链路

{% asset_img 6.png %}

服务调用链路的概念，就是当服务请求发起时，记录整个请求链路的数据，以备查询。

目前市面上，几乎所有服务调用链路的实现，理论基础都是基于 Google Dapper 的那篇论文，其中最重要的概念就是 traceId 和 spanId。
traceId 记录整个服务链路的 ID，由首次请求方创建，服务链路中唯一。
spanId 记录当前服务块的 ID，由当前服务方创建。
parentId 记录上一个请求服务的 spanId。
下面我描述下，我们目前的服务调用链路过程：
H5 发起请求，到 Zuul 网关，Zuul 创建全局的 traceId 和自己的 spanId，然后携带这些数据到业务服务 A，并利用 Spring Cloud Sluth 传输到 RabbitMQ。
业务服务 A，接收到 Zuul 传输的 traceId 和 spanId，然后把 Zuul 的 spanId 设置成 parentId，并生成自己的 spanId，然后携带这些数据到业务服务 B，并利用 Spring Cloud Sluth 传输到 RabbitMQ。
....
上面图中，详细说明了整个服务调用链路的过程，这边再说下使用的技术栈：
Spring Cloud Sluth：和 SkyWalking 的探针概念比较类似，每个服务都进行配置，收集当然服务的请求数据（traceId 和 spanId），然后利用stream-sluth和binder-rabbit组件，将请求数据传输到 RabbitMQ。
Spring Cloud Zipkin：主要用于请求链路的 UI 展示，Zipkin 会从 RabbitMQ 读取请求数据，然后存储到 ElasticSearch 中，然后下次显示直接从 ElasticSearch 中读取。
Kibana：Kibana 也可以显示 ElasticSearch 中的请求数据，只不过不是图形化的，需要索引配置创建。

# ELK 日志链路

{% asset_img 7.png  %}

ELK 可以参考下之前的几篇文章：
ELK 架构之 Elasticsearch 和 Kibana 安装配置
ELK 架构之 Logstash 和 Filebeat 安装配置
ELK 架构之 Logstash 和 Filebeat 配置使用（采集过滤）
ELK 架构之 Elasticsearch、Kibana、Logstash 和 Filebeat 安装配置汇总（6.2.4 版本）
上面图中已经很详细介绍了下 ELK 的流程，ELK 默认技术栈里是没有 Filebeat 的，Logstash 用作日志收集的时候，CPU 和内存会占用资源比较大，所以我们使用轻量化的 Filebeat 进行日志的收集，Filebeat 部署在每个业务服务所在的服务器，然后将收集到的日志数据传输到 Logstash，Logstash 可以部署两到三台服务器上，用作日志的过滤和分析工作，然后再将处理后的日志数据，传输到 ElasticSearch 存储。

# 统一格式返回

{% asset_img 8.png %}

