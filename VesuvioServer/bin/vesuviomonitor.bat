@echo off
:whileClients
cls
echo %DATE% %TIME%
netsh wlan show hostednetwork | findstr -i status
echo SSID Name
netsh wlan show hostednetwork | findstr -i " ssid "
echo Connected clients
arp -a | findstr -i 192.168.173 | findstr /V 255 | findstr /V 192.168.173.1
set q = "continue"
timeout 5 > NULL
goto :whileClients