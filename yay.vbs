Set WshShell = CreateObject("WScript.Shell")
imgPath = WshShell.ExpandEnvironmentStrings("%AppData%\crineson.png")

Do
    If CreateObject("Scripting.FileSystemObject").FileExists(imgPath) Then
        ' Open the image
        WshShell.Run "explorer """ & imgPath & """", 1, False
        WScript.Sleep 1000

        ' Send F11 to Photos to attempt fullscreen
        WshShell.SendKeys "{F11}"

        ' Wait 2 seconds
        WScript.Sleep 2000

        ' Close the Photos app
        WshShell.Run "taskkill /IM ApplicationFrameHost.exe /F", 0, True
    End If

    WScript.Sleep 5000
Loop
