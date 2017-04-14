#基于哪个镜像
FROM centos

#zpcheng make it
MAINTAINER Captain Zhang <zhangpch666@163.com>

#首先更新php rpm 源
RUN yum update && yum -y install epel-release && \
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

#用RUN命令调用yum包管理器安装PHP环境所依赖的程序包
RUN yum -y install \
	curl \
	nginx \
	php70w-mysql \
	php70w-gd \
	php70w-pear \
	php70w-opcache 

#使用完包管理器后清理以下减少镜像大小

#用RUN命令调用mkdir来准备一个干净的放置代码的目录
RUN mkdir -p /app && rm -rf /var/www/html && ln -s /app /var/www/html

#将本地代码添加到目录，并指定其为当前的工作目录
COPY ./app
WORKDIR /app

#设定脚本的权限，指定暴露的容器内端口地址
EXPOSE 80
COPY startup.sh /root/startup.sh
RUN chmod a+x /root/startup.sh
ENTRYPOINT /root/startup.sh
