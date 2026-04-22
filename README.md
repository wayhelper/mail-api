## 介 绍
这是一个基于go的SMTP邮件发送服务，支持多账户配置和安全认证。通过环境变量配置账户信息和SMTP服务器参数，确保邮件发送的安全性和灵活性。
>本地运行 设置你的环境变量：
> 
```
export SMTP_ACCOUNTS="sender1@qq.com:pass123,sender2@163.com:pass456" 
export SMTP_HOST="smtp.qq.com" 
export SMTP_PORT="465" 
export APP_KEY="your-secret-key"
```
>使用docker运行(docker-compose.yml)：
```
version: "3.9"

services:
  mail:
    image: gzsoft/mail-api:latest
    container_name: mail
    ports:
      - "5010:5010"
    environment:
      - TZ=Asia/Shanghai
      - SMTP_ACCOUNTS=你的QQ@qq.com:QQ邮箱授权码
      - SMTP_HOST=smtp.qq.com
      - SMTP_PORT=465
      - APP_KEY=your-secret-key （后面请求api要用）
    restart: unless-stopped

```

## 功 能
- 支持多个SMTP账户配置，方便管理不同的邮件发送需求。
- 通过环境变量配置SMTP服务器地址、端口和账户信息，简化部署流程。
- 使用安全认证机制，确保邮件发送的安全性。
- 提供API接口，方便集成到其他应用中进行邮件发送。
## 使 用
Post请求示例：
```
POST /api/send
Content-Type: application/json
headers:
  appKey: your-secret-key
request body:
{
    "to":"要发送的邮箱@gmail.com",
    "subject":"要发送的消息标题",
    "body":"要发送的消息内容"
}
```