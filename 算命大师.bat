@echo off
setlocal enabledelayedexpansion


title ������ʦ


:main
cls
echo =====================================
echo              ������ʦ
echo  �����ʽ(YYYY-MM-DD)������exit���˳� 
echo =====================================
set /p birthDate=������������

if /i "!birthDate!"=="exit" (
    echo ʩ������Ե�ٻ�
    pause
    exit /b
)

REM ��֤�����ʽ����Ч��
for /f "tokens=1-3 delims=-" %%a in ("%birthDate%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)


REM �����ݡ��·ݺ����ڵ���Ч��
if "!year!"=="" goto error
if "!month!"=="" goto error
if "!day!"=="" goto error


REM ��֤��ݷ�Χ
if !year! lss 1900 goto error
if !year! gtr 2100 goto error


REM ��֤�·�
if !month! lss 1 goto error
if !month! gtr 12 goto error

REM ���ÿ������
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

REM ����2��29��
REM �ж�����
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

REM ��֤����
if !day! lss 1 goto error
if !day! gtr !monthDays[%month%]! goto error


REM ��������
set /a zodiacIndex=(!year! - 4) %% 12
set "zodiac[0]=��" 
set "zodiac[1]=ţ"
set "zodiac[2]=��"
set "zodiac[3]=��"
set "zodiac[4]=��"
set "zodiac[5]=��"
set "zodiac[6]=��"
set "zodiac[7]=��"
set "zodiac[8]=��"
set "zodiac[9]=��"
set "zodiac[10]=��"
set "zodiac[11]=��"


set "zodiacSign=!zodiac[%zodiacIndex%]!"


REM ��������
set "constellation="
if "!month!"=="01" (
    if "!day!" leq "19" set "constellation=Ħ����" & goto output
    if "!day!" geq "20" set "constellation=ˮƿ��" & goto output
)
if "!month!"=="02" (
    if "!day!" leq "18" set "constellation=ˮƿ��" & goto output
    if "!day!" geq "19" set "constellation=˫����" & goto output
)
if "!month!"=="03" (
    if "!day!" leq "20" set "constellation=˫����" & goto output
    if "!day!" geq "21" set "constellation=������" & goto output
)
if "!month!"=="04" (
    if "!day!" leq "19" set "constellation=������" & goto output
    if "!day!" geq "20" set "constellation=��ţ��" & goto output
)
if "!month!"=="05" (
    if "!day!" leq "20" set "constellation=��ţ��" & goto output
    if "!day!" geq "21" set "constellation=˫����" & goto output
)
if "!month!"=="06" (
    if "!day!" leq "21" set "constellation=˫����" & goto output
    if "!day!" geq "22" set "constellation=��з��" & goto output
)
if "!month!"=="07" (
    if "!day!" leq "22" set "constellation=��з��" & goto output
    if "!day!" geq "23" set "constellation=ʨ����" & goto output
)
if "!month!"=="08" (
    if "!day!" leq "22" set "constellation=ʨ����" & goto output
    if "!day!" geq "23" set "constellation=��Ů��" & goto output
)
if "!month!"=="09" (
    if "!day!" leq "22" set "constellation=��Ů��" & goto output
    if "!day!" geq "23" set "constellation=�����" & goto output
)
if "!month!"=="10" (
    if "!day!" leq "23" set "constellation=�����" & goto output
    if "!day!" geq "24" set "constellation=��Ы��" & goto output
)
if "!month!"=="11" (
    if "!day!" leq "22" set "constellation=��Ы��" & goto output
    if "!day!" geq "23" set "constellation=������" & goto output
)
if "!month!"=="12" (
    if "!day!" leq "21" set "constellation=������" & goto output
    if "!day!" geq "22" set "constellation=Ħ����" & goto output
)


:output
echo ==============================
echo ���������ǣ�!zodiacSign!
echo ���������ǣ�!constellation!
echo ==============================
echo �����������...
pause > nul
goto main


:error
echo �����ʽ�������������롣
pause > nul
goto main