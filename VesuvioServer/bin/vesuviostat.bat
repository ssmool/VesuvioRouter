@echo off
:whileClients
cls
SET /P ssidname=<..\config\vesuviossid.txt
netsh wlan SET hostednetwork ssid=%ssidname%
netsh wlan start hostednetwork
echo %DATE% %TIME%
netsh wlan show hostednetwork | findstr -i status
echo SSID Name : %ssidname%
netsh wlan show hostednetwork | findstr -i " ssid "
echo Connected clients
arp -a | findstr -i 192.168.173 | findstr /V 255 | findstr /V 192.168.173.1
:MENU
SET /P r="(q)Quit/ (r)Refresh: "
IF "%r%" == "q" (
	netsh wlan stop hostednetwork
	goto :ENDPROGRAM
)
IF "%r%" == "r" (
	start cmd /k ..\bin\vesuviomonitor.bat
	goto :whileClients
) ELSE (
	goto :MENU
)
:ENDPROGRAM