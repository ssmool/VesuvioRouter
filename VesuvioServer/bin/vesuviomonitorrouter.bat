@echo off
start cmd /k %VesuvioServer%\bin\vesuvioroutermonitorreg.bat
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
arp -a | findstr -i 192.168.0 | findstr /V 255 | findstr /V 192.168.0.1 > %VesuvioServer%\log\vesuviolog.txt
:ClientsLog
IF "%aux%" == "null" (
	SET /P aux=<%VesuvioServer%\log\vesuviolog.txt
) ELSE (
	SET /P aux=<%VesuvioServer%\log\vesuviolog.txt
	IF NOT "%aux%" == "%log%" (
		SET line = ""
		set number = 0
		set "cmd=findstr /R /N "^^" %VesuvioServer%\log\vesuviolog.txt"
		for /f %%a in ('%cmd%') do set number=%%a
		SET /a stack=%number
	)
	IF NOT [%stack%] == 0 (
		IF [%clients%] LSS [%stack%] (
			cscript %VesuvioServer%\bin\MessageBox.vbs "Client Connected!"
			@echo arp -a | findstr -i 192.168.0 | findstr /V 255 | findstr /V 192.168.0.1 > %VesuvioServer%\log\log.txt
		)
		IF [%clients%] GTR [%stack%] (
			cscript %VesuvioServer%\bin\MessageBox.vbs "Client Disconnected!"
			@echo arp -a | findstr -i 192.168.0 | findstr /V 255 | findstr /V 192.168.0.1 > %VesuvioServer%\log\log.txt
		)
	)
	SET "%log%" = "%r%"
	SET "%clients%" = "%stack%"
)
timeout 10
goto :whileClients