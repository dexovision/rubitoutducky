@echo off
:: -----------------------------
:: Batch launcher for persistent PowerShell auto-move
:: -----------------------------
powershell -NoExit -Command ^
"$wshell = New-Object -ComObject WScript.Shell; ^
Add-Type -AssemblyName System.Windows.Forms; ^
while ($true) { ^
    $scr = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; ^
    $x = Get-Random -Minimum 0 -Maximum $scr.Width; ^
    $y = Get-Random -Minimum 0 -Maximum $scr.Height; ^
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x,$y); ^
    $rKey = Get-Random -Minimum 0 -Maximum 5; ^
    switch ($rKey) { ^
        0 { $wshell.SendKeys('w') } ^
        1 { $wshell.SendKeys('a') } ^
        2 { $wshell.SendKeys('s') } ^
        3 { $wshell.SendKeys('d') } ^
        4 { $wshell.SendKeys('{F11}') } ^
        5 { (New-Object -ComObject Shell.Application).MinimizeAll() } ^
    }; ^
    $rEnter = Get-Random -Minimum 0 -Maximum 3; ^
    if ($rEnter -eq 0) { $wshell.SendKeys('~') }; ^
    Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 120); ^
}"
