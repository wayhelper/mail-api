@echo off
chcp 65001 > nul
:: 1. 设置目标操作系统为 Linux
set GOOS=linux
:: 2. 设置目标架构为 64 位 AMD 架构
set GOARCH=amd64
:: 3. 禁用 CGO (确保生成的二进制文件不依赖服务器的 C 库)
set CGO_ENABLED=0

echo 正在开始编译 Linux (AMD64) 版本...

:: 4. 执行编译指令，输出文件名为gmail 
go build -ldflags="-s -w" -o mail-api-linux-amd64 main.go

if %errorlevel% equ 0 (
    echo [成功] 编译完成！生成文件: gmail 
) else (
    echo [失败] 编译过程中出现错误。
)

pause