# 阶段 1：构建阶段
FROM golang:1.25.5-alpine AS builder

# 设置工作目录
WORKDIR /app

# 安装编译依赖（这一步只在构建阶段需要）
RUN apk add --no-cache git build-base

# 设置 Go 环境变量
ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    GOTOOLCHAIN=auto

# 复制依赖文件并下载（利用 Docker 缓存）
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码并编译
# -ldflags="-s -w" 用于移除调试信息，减小二进制体积 [citation:2][citation:10]
COPY . .
RUN go build -ldflags="-s -w" -o mail-api .

# 阶段 2：运行阶段（最终镜像）
# 使用最精简的 alpine 镜像，约 5MB
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 安装运行时需要的 CA 证书（如果程序需要访问外部 HTTPS 服务）
# 如果不需要，可以省略这行
RUN apk --no-cache add ca-certificates

# 从构建阶段复制编译好的二进制文件
COPY --from=builder /app/mail-api .

# 暴露端口
EXPOSE 5010

# 运行
CMD ["./mail-api"]