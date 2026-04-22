FROM golang:1.21-alpine AS builder

WORKDIR /app

# 复制 go.mod 和 go.sum 文件
COPY go.mod go.sum ./

# 下载依赖
RUN go mod download

# 复制源代码
COPY . .

# 编译
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o mail-api .

# 运行阶段
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /app/mail-api .

EXPOSE 5010

CMD ["./mail-api"]