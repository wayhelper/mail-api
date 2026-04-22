FROM golang:1.25.5-alpine

WORKDIR /app

# 安装编译依赖（关键）
RUN apk add --no-cache git build-base

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct \
    GOTOOLCHAIN=auto

# 先复制依赖文件（缓存优化 + 防炸）
COPY go.mod go.sum ./
RUN go mod download

# 再复制源码
COPY . .

# 编译
RUN go build -v -ldflags="-w -s" -o mail-api .

EXPOSE 5010

CMD ["./mail-api"]