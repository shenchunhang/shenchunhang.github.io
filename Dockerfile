# 使用node最新镜像
FROM node:latest as build-env
# 设置工作目录
WORKDIR /usr/blog
# 把所有文件都copy进去
COPY . .
# 安装hexo-cli
RUN npm --registry=https://registry.npmmirror.com install hexo-cli -g && npm install
# 生成静态文件
RUN hexo clean && hexo g

# 配置nginx
FROM nginx:latest
# 设置容器时区为上海，不然发布文章的时间是国际时间，也就是比我们晚8个小时
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /usr/share/nginx/html

# 把上一部生成的HTML文件复制到Nginx中
COPY --from=build-env /usr/blog/public /usr/share/nginx/html
EXPOSE 80