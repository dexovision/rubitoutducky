@echo off
setlocal enabledelayedexpansion

:: Edge executable path
set "EDGE_PATH=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"

:LOOP
set "PROCESS1=chrome.exe"
set "PROCESS2=MinecraftLauncher.exe"
set "RUN_EDGE="

:: Check if Chrome is running
tasklist /FI "IMAGENAME eq %PROCESS1%" 2>NUL | find /I "%PROCESS1%" >nul
if not errorlevel 1 (
    echo Chrome is running. Closing Chrome...
    taskkill /IM "%PROCESS1%" /F
    set "RUN_EDGE=1"
)

:: Check if Minecraft is running
tasklist /FI "IMAGENAME eq %PROCESS2%" 2>NUL | find /I "%PROCESS2%" >nul
if not errorlevel 1 (
    echo Minecraft is running. Closing Minecraft...
    taskkill /IM "%PROCESS2%" /F
    set "RUN_EDGE=1"
)

:: Launch Edge if needed
if "!RUN_EDGE!"=="1" (
    echo Launching Microsoft Edge...
    start "" "%EDGE_PATH%"
    timeout /t 3 /nobreak >nul
    powershell -command ^
    "Get-Process msedge | Where-Object { $_.MainWindowHandle -ne 0 } | ForEach-Object { $sig=@'[DllImport(\"user32.dll\")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'@; $type=Add-Type -MemberDefinition $sig -Name 'Win32ShowWindowAsync' -Namespace Win32Functions -PassThru; [Win32Functions.Win32ShowWindowAsync]::ShowWindowAsync($_.MainWindowHandle, 3) }"
)

timeout /t 2 /nobreak >nul
goto LOOP
rem yo
