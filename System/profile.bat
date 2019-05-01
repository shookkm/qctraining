set _SERVICEMGR=%1
set _DATABASE=%2

if "%_SERVICEMGR%"=="qcslab1512" (
  set _SERVICEMGR=dev2
) else (
  set _SERVICEMGR=%1
)
if "%_DATABASE%"=="argus" (
  set _DATABASE=enterprise
) else (
  set _DATABASE=%2
)

call projectProfile -p Keurig-Spartanburg -m %_SERVICEMGR% -d %_DATABASE% -P 38800 -s System -n keurigSpartanburg -r 13.2.1
set DATABASE_PORT=54000
