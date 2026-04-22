# 多阶段构建 - 第一阶段：编译
FROM golang:1.21-alpine AS builder

# 安装必要的工具
RUN apk add --no-cache git ca-certificates

WORKDIR /app

# 复制 go.mod 和 go.sum 先，利用 Docker 缓存
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码
COPY . .

# 编译 Go 应用
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags="-w -s" \
    -o /app/mail-api .

# 第二阶段：运行
FROM alpine:latest

# 安装 ca-certificates 和时区数据
RUN apk --no-cache add ca-certificates tzdata

WORKDIR /app

# 从 builder 阶段复制编译好的二进制文件
COPY --from=builder /app/mail-api .

# 如果需要配置文件，取消下面的注释
# COPY --from=builder /app/config ./config

# 暴露端口（根据你的 mail-api 服务修改，例如 8080）
EXPOSE 5010

# 运行
CMD ["./mail-api"]