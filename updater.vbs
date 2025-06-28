Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c python updater.py", 0
Set WshShell = Nothing