@echo off
set /a counter = 0
set /a countreg = 0
set "addr1=192.168.0."
set /a index = 0
set aux = 0
goto :ClientsMonitorReg
:whileClients
cls
set "addr1=192.168.0."
set /a index = 0
set aux = 0
echo %DATE% %TIME%
if %counter% == 30 (
	set /a counter = 0
	set /a ntemp = 0
	goto :ClientsMonitorReg
) else (
	set /a ntemp = %counter% + 1
	set /a counter = %ntemp%
	timeout 5 > NULL
	goto :WhileClients
)
:ClientsMonitorReg
set /a countreg = %countreg% + 1
echo "Registering log of ping and tracert"
goto :ClientsMonitor
:ClientsMonitor
set /a aux = %index%
set /a index = %aux% + 1
set indexstr = %index
set "addr1=192.168.0.%index%"
ping %addr1% -n 1 -a > c:\netstat\regtemp-%countreg%-%addr1%.txt
if %index% == 255 (
	set /a index = 1
	timeout 5 > NULL
	goto :whileClients
) else (
	goto:ClientsMonitor
)
goto :whileClients