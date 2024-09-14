# 拉取镜像
FROM node:20-alpine AS build-stage
# 配置维护者的名字
LABEL maintainer='llcmite@qq.com'
# 创建工作目录
WORKDIR /app

# 复制所有文件到当前目录下
COPY . .
RUN npm install cnpm -g --no-progress --registry=https://registry.npm.taobao.org
RUN cnpm install
RUN npm run build

# 拉取nginx镜像
FROM nginx:stable-alpine AS production-stage

# 将打包的文件复制到ngnix目录下
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 使用命令将nginx启动起来
CMD ["nginx","-g","daemon off;"]

