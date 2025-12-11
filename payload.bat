@echo off
setlocal

:: Edge executable path
set "EDGE_PATH=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"

:LOOP
:: Processes to check
set "PROCESS1=chrome.exe"
set "PROCESS2=MinecraftLauncher.exe"

:: Reset flag
set RUN_EDGE=

:: Check if Chrome is running
tasklist /FI "IMAGENAME eq %PROCESS1%" 2>NUL | find /I "%PROCESS1%" >NUL
set CHROME_RUNNING=%ERRORLEVEL%

:: Check if Minecraft is running
tasklist /FI "IMAGENAME eq %PROCESS2%" 2>NUL | find /I "%PROCESS2%" >NUL
set MINECRAFT_RUNNING=%ERRORLEVEL%

:: If either is running, close them and launch Edge
if %CHROME_RUNNING%==0 (
    echo Chrome is running. Closing Chrome...
    taskkill /IM "%PROCESS1%" /F
    set RUN_EDGE=1
)

if %MINECRAFT_RUNNING%==0 (
    echo Minecraft is running. Closing Minecraft...
    taskkill /IM "%PROCESS2%" /F
    set RUN_EDGE=1
)

if defined RUN_EDGE (
    echo Launching Microsoft Edge...
    start "" "%EDGE_PATH%"

    :: Wait a few seconds to allow Edge to open
    timeout /t 3 /nobreak >nul

    :: Maximize Edge window using PowerShell
    powershell -command ^
    "$p = Get-Process | Where-Object { $_.ProcessName -eq 'msedge' }; ^
    if ($p) { ^
        $sig=@'[DllImport(\"user32.dll\")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'@; ^
        $type=Add-Type -MemberDefinition $sig -Name 'Win32ShowWindowAsync' -Namespace Win32Functions -PassThru; ^
        [Win32Functions.Win32ShowWindowAsync]::ShowWindowAsync($p.MainWindowHandle, 3) ^
    }"
)

:: Wait a short time before checking again
timeout /t 2 /nobreak >nul

:: Loop back
goto LOOP
rem yo
