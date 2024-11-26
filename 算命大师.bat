@echo off
setlocal enabledelayedexpansion


title 算命大师


:main
cls
echo =====================================
echo              算命大师
echo  输入格式(YYYY-MM-DD)，输入exit则退出 
echo =====================================
set /p birthDate=请输入生辰：

if /i "!birthDate!"=="exit" (
    echo 施主，有缘再会
    pause
    exit /b
)

REM 验证输入格式和有效性
for /f "tokens=1-3 delims=-" %%a in ("%birthDate%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)


REM 检查年份、月份和日期的有效性
if "!year!"=="" goto error
if "!month!"=="" goto error
if "!day!"=="" goto error


REM 验证年份范围
if !year! lss 1900 goto error
if !year! gtr 2100 goto error


REM 验证月份
if !month! lss 1 goto error
if !month! gtr 12 goto error

REM 检查每月天数
set "monthDays[01]=31"
set "monthDays[02]=28"
set "monthDays[03]=31"
set "monthDays[04]=30"
set "monthDays[05]=31"
set "monthDays[06]=30"
set "monthDays[07]=31"
set "monthDays[08]=31"
set "monthDays[09]=30"
set "monthDays[10]=31"
set "monthDays[11]=30"
set "monthDays[12]=31"

REM 闰年2月29天
REM 判断闰年
if %month%==02 (
    set /a leap=0
    set /a mod4=%year% %% 4
    set /a mod100=%year% %% 100
    set /a mod400=%year% %% 400
    
    if !mod4!==0 if !mod100!==0 if !mod400!==0 set leap=1
    if !mod4!==0 if !mod100!==0 if !mod400! NEQ 0 set leap=0
    if !mod4!==0 if !mod100! NEQ 0 set leap=1
    
if !leap! equ 1 set "monthDays[02]=29"
)

REM 验证日期
if !day! lss 1 goto error
if !day! gtr !monthDays[%month%]! goto error


REM 计算属相
set /a zodiacIndex=(!year! - 4) %% 12
set "zodiac[0]=鼠" 
set "zodiac[1]=牛"
set "zodiac[2]=虎"
set "zodiac[3]=兔"
set "zodiac[4]=龙"
set "zodiac[5]=蛇"
set "zodiac[6]=马"
set "zodiac[7]=羊"
set "zodiac[8]=猴"
set "zodiac[9]=鸡"
set "zodiac[10]=狗"
set "zodiac[11]=猪"


set "zodiacSign=!zodiac[%zodiacIndex%]!"


REM 计算星座
set "constellation="
if "!month!"=="01" (
    if "!day!" leq "19" set "constellation=摩羯座" & goto output
    if "!day!" geq "20" set "constellation=水瓶座" & goto output
)
if "!month!"=="02" (
    if "!day!" leq "18" set "constellation=水瓶座" & goto output
    if "!day!" geq "19" set "constellation=双鱼座" & goto output
)
if "!month!"=="03" (
    if "!day!" leq "20" set "constellation=双鱼座" & goto output
    if "!day!" geq "21" set "constellation=白羊座" & goto output
)
if "!month!"=="04" (
    if "!day!" leq "19" set "constellation=白羊座" & goto output
    if "!day!" geq "20" set "constellation=金牛座" & goto output
)
if "!month!"=="05" (
    if "!day!" leq "20" set "constellation=金牛座" & goto output
    if "!day!" geq "21" set "constellation=双子座" & goto output
)
if "!month!"=="06" (
    if "!day!" leq "21" set "constellation=双子座" & goto output
    if "!day!" geq "22" set "constellation=巨蟹座" & goto output
)
if "!month!"=="07" (
    if "!day!" leq "22" set "constellation=巨蟹座" & goto output
    if "!day!" geq "23" set "constellation=狮子座" & goto output
)
if "!month!"=="08" (
    if "!day!" leq "22" set "constellation=狮子座" & goto output
    if "!day!" geq "23" set "constellation=处女座" & goto output
)
if "!month!"=="09" (
    if "!day!" leq "22" set "constellation=处女座" & goto output
    if "!day!" geq "23" set "constellation=天秤座" & goto output
)
if "!month!"=="10" (
    if "!day!" leq "23" set "constellation=天秤座" & goto output
    if "!day!" geq "24" set "constellation=天蝎座" & goto output
)
if "!month!"=="11" (
    if "!day!" leq "22" set "constellation=天蝎座" & goto output
    if "!day!" geq "23" set "constellation=射手座" & goto output
)
if "!month!"=="12" (
    if "!day!" leq "21" set "constellation=射手座" & goto output
    if "!day!" geq "22" set "constellation=摩羯座" & goto output
)


:output
echo ==============================
echo 您的属相是：!zodiacSign!
echo 您的星座是：!constellation!
echo ==============================
echo 按任意键继续...
pause > nul
goto main


:error
echo 输入格式错误，请重新输入。
pause > nul
goto main