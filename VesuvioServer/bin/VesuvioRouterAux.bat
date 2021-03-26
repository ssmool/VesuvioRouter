@echo off
SET "aux=null"
SET /a clients = 0
goto :whileClients
:whileClients
cls
SET /a reg = 0
SET /a stack = 0
SET log = r
set "addr1=192.168.0."
set /a index = 0
set aux = 0
echo %DATE% %TIME%
netsh wlan show hostednetwork | findstr -i status
echo SSID Name
netsh wlan show hostednetwork | findstr -i " ssid "
echo Connected clients
arp -a | findstr -i 192.168.0 | findstr /V 255 | findstr /V 192.168.0.1