@echo off
:INITPROGRAM
SET LISTNUMBER = 0
SET /P keypass=<..\config\ssidpasscontent.txt
SET /P nick="Enter nick for connection/choose LIST: "
IF "%nick%" == "LIST" (
	goto :LISTCOMMAND		
) ELSE (
	goto :DEFAULTPROGRAM
)
:DEFAULTPROGRAM
echo "Your new connection is registered on log..."

echo "log: %nick%; %DATE%;%TIME%" > ..\config\serverlog.txt
echo %nick% > ..\config\vesuviossid.txt
timeout 10
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=allow ssid="%nick%" key="%keypass%"
netsh wlan start hostednetwork
netsh wlan show hostednetwork
..\bin\vesuviostat.bat
goto :ENDPROGRAM
:LISTCOMMAND

set "cmd=findstr /R /N "^^" ..\config\vesuviolist.txt"
for /f %%a in ('%cmd%') do set number=%%a
:SETNICKFROMLIST
SET /a min=1
SET /a max=%number
SET /a rnd=%random% * (%max% - %min% + 1) / 32768 + %min%
for /F "skip=%rnd% delims=" %%i in (..\config\vesuviolist.txt) do set "nick=%%i"&goto :nextline
:nextline
goto :DEFAULTPROGRAM
:ENDPROGRAM