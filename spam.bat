@echo off
title Minecraft High-Speed Spammer
set /p msg="Enter your message: "
echo Set WshShell = WScript.CreateObject("WScript.Shell") > spam.vbs
echo WScript.Sleep 5000 >> spam.vbs
echo Do >> spam.vbs
echo WshShell.SendKeys "t" >> spam.vbs
echo WScript.Sleep 50 >> spam.vbs
echo WshShell.SendKeys "%msg%" >> spam.vbs
echo WshShell.SendKeys "{ENTER}" >> spam.vbs
echo WScript.Sleep 100 >> spam.vbs
echo Loop >> spam.vbs
start cscript //nologo spam.vbs
echo Spammer STARTED. Click into Minecraft Chat NOW!
echo.
echo TO STOP: Press CTRL+C in THIS window, then press Y and Enter.
pause
taskkill /f /im wscript.exe >nul 2>&1
taskkill /f /im cscript.exe >nul 2>&1
del spam.vbs
exit
