# Ngx_lua

@date: 2019-3-25 23:00:15

---

## 简介

ngx_lua 指的是 [`lua-nginx-module`](https://github.com/openresty/lua-nginx-module)模块：通过将 `LuaJIT` 的虚拟机嵌入到 Nginx 的 worker 中，这样既保持高性能，又能不失去lua开发的简单特性。  

`OpenResty` 就是一个基于 Nginx 与 Lua 的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。OpenResty 基于`Nginx`开发，可以简单认为是 `Nginx` + `lua-nginx-module`的组合版。

官网：https://openresty.org/cn/  
官方文档：https://github.com/openresty/lua-nginx-module  

## Hello World 

### OpenResty 安装

以 CentOS 为例：
``` bash
mkdir /opt && cd /opt

# download openresty
wget https://openresty.org/download/openresty-1.13.6.2.tar.gz

tar zxvf openresty-1.13.6.2.tar.gz
cd openresty-1.13.6.2

# configure
./configure --prefix=/usr/local/openresty -j4

make -j4 && make install
```
其中 源码包可以到 https://openresty.org/cn/download.html 该页面获取。
`-j4`表示使用4核。`configure`那一步还可以指定各种参数：
``` bash
./configure --prefix=/usr/local/openresty \
            --with-luajit \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-http_postgres_module
```
使用 `./configure --help` 查看更多的选项。

其它系统环境上安装可以参考 https://openresty.org/cn/installation.html 。

其实安装 OpenResty 和安装 Nginx 是类似的，因为 OpenResty 是基于 Nginx 开发的。

如果已经安装了 Nginx，又想使用 OpenResty 的功能，可以参考  《Nginx编译安装Lua》：https://www.cnblogs.com/52fhy/p/10164553.html 一文安装`lua-nginx-module`模块即可。

### 第一个程序

修改 `/usr/local/openresty/nginx/conf/nginx.conf`:
``` conf
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    server {
        listen 8080;
        location /hello {
            default_type text/html;
            content_by_lua '
                ngx.say("<p>hello, world</p>")
            ';
        }
    }
}
```
把默认的`80`端口改为`8080`，新增`/hello`部分。

其中`content_by_lua`便是 OpenResty 提供的指令，在官方文档可以搜索到：

![](http://img2018.cnblogs.com/blog/663847/201903/663847-20190324174956312-276962073.png)


现在我们启动OpenResty：
``` bash
/usr/local/openresty/nginx/sbin/nginx
```
启动成功后，查看效果：
``` bash
curl http://127.0.0.1:8080/hello
<p>hello, world</p>
```
说明成功运行了。

## 参考
1、OpenResty® - 中文官方站  
https://openresty.org/cn/  
2、openresty/lua-nginx-module: Embed the Power of Lua into NGINX HTTP servers  
https://github.com/openresty/lua-nginx-module#version  
3、环境搭建 · OpenResty最佳实践  
https://moonbingbing.gitbooks.io/openresty-best-practices/content/openresty/install.html  


