FROM golang:1.21-alpine

# 设置 Go 代理（解决网络问题）
ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct

WORKDIR /app

# 复制所有文件
COPY . .

# 下载依赖并编译
RUN go mod download && \
    go build -ldflags="-w -s" -o mail-api .

EXPOSE 5010

CMD ["./mail-api"]