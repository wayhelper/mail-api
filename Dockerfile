FROM golang:1.21-alpine

WORKDIR /app

COPY main.go .

RUN go build -o mail-api main.go

EXPOSE 5010

CMD ["./mail-api"]