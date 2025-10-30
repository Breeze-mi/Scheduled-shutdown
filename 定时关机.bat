@echo off
:: 强制使用UTF-8编码处理中文字符
chcp 65001 >nul
title 定时关机工具

:: 美化界面
echo ================================
echo     计算机定时关机工具
echo ================================
echo.

:: 检查并取消现有定时任务
echo [状态] 正在检查现有定时任务...
shutdown -a >nul 2>&1
if %errorlevel% == 0 (
    echo [成功] 已取消现有定时任务
) else (
    echo [信息] 当前没有活动的定时任务
)
echo.

:: 输入循环
:input
set /p "minutes=请输入关机延迟时间(分钟): "

:: 输入验证
if "%minutes%"=="" (
    echo [错误] 输入不能为空
    goto input
)

echo %minutes%|findstr /r "^[0-9]*$" >nul
if errorlevel 1 (
    echo [错误] 请输入有效数字
    goto input
)

if %minutes% leq 0 (
    echo [错误] 时间必须大于0
    goto input
)

:: 设置关机
set /a seconds=minutes*60
shutdown -s -t %seconds%

:: 结果展示
echo.
echo ================================
echo [成功] 已设定电脑将在 %minutes% 分钟后关机
echo ================================
echo.
echo 如需取消请运行 [取消定时关机.bat]
echo 或使用命令: shutdown -a
pause
