@echo off

rem 獲取管理員權限
:: BatchGotAdmin  
:-------------------------------------  
rem  --> Check for permissions  
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
rem --> If error flag set, we do not have admin.  
if '%errorlevel%' NEQ '0' (  
    echo 獲取管理員權限中,如果UAC彈窗,請選擇允許...
    goto UACPrompt  
) else ( goto gotAdmin )   
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"   
    "%temp%\getadmin.vbs"
    exit /B  
:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )  
    pushd "%CD%"  
CD /D "%~dp0"



echo 本程式將執行Windows 10 Pro Education版本的啟動認證的設定

echo 請確認您執行本程式時是否已經選擇以*系統管理者身分執行*

echo 設定Windows 10 Pro 序號

cscript "%SystemRoot%\system32\slmgr.vbs" /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y

echo 設定 KMS 金鑰管理伺服器

cscript "%SystemRoot%\system32\slmgr.vbs" /skms 192.168.0.1:1688

echo 啟動Windows 10 Pro Education

cscript "%SystemRoot%\system32\slmgr.vbs" /ato

echo 顯示Microsoft Windows 授權資訊

cscript "%SystemRoot%\system32\slmgr.vbs" /dlv

echo 完成大量啟用程序

pause