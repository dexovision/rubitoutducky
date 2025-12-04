@echo off
:loop

:: Random action 0-5 for keys/minimize
set /a r=%random% %% 6

:: Much faster delay: 100–200 ms
set /a delay=(%random% %% 101) + 100

:: Move mouse randomly
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $scr=[System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $x=Get-Random -Minimum 0 -Maximum $scr.Width; $y=Get-Random -Minimum 0 -Maximum $scr.Height; [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x,$y)"

:: Simulate click via Enter key (fast)
powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('~')"

:: Random key press or minimize
if %r%==0 powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('w')"
if %r%==1 powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('a')"
if %r%==2 powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('s')"
if %r%==3 powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('d')"
if %r%==4 powershell -Command "$wshell=New-Object -ComObject WScript.Shell; $wshell.SendKeys('{F11}')"
if %r%==5 powershell -Command "(New-Object -ComObject Shell.Application).MinimizeAll()"

:: Very short wait (fast speed)
powershell -Command "Start-Sleep -Milliseconds %delay%"

goto loop
