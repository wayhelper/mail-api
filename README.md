## 介 绍
这是一个基于go的SMTP邮件发送服务，支持多账户配置和安全认证。通过环境变量配置账户信息和SMTP服务器参数，确保邮件发送的安全性和灵活性。
>设置你的环境变量：
> 
```
export SMTP_ACCOUNTS="sender1@qq.com:pass123,sender2@163.com:pass456" 
export SMTP_HOST="smtp.qq.com" 
export SMTP_PORT="465" 
export APP_KEY="your-secret-key"
```

