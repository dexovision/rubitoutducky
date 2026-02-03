@echo off
title Minecraft Turbo Spammer
set /p msg="Enter message: "
set /p count="How many times? "

echo Set wshShell = wscript.CreateObject("WScript.Shell") > spam.vbs
echo wscript.sleep 3000 >> spam.vbs
echo For i = 1 to %count% >> spam.vbs
:: Open chat and wait just long enough (reduced from 300 to 100)
echo wshShell.SendKeys "t" >> spam.vbs
echo wscript.sleep 100 >> spam.vbs

:: Backspace once just in case 't' got stuck
echo wshShell.SendKeys "{BACKSPACE}" >> spam.vbs

:: Send the whole message at once (much faster than letter-by-letter)
echo wshShell.SendKeys "%msg%" >> spam.vbs

:: Instant Enter and minimal cooldown for the next loop
echo wshShell.SendKeys "{ENTER}" >> spam.vbs
echo wscript.sleep 50 >> spam.vbs
echo Next >> spam.vbs

start spam.vbs
echo TURBO MODE READY. You have 3 seconds to click into Minecraft!
pause
