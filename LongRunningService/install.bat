@echo off
SET SvcName="LongRunningService"
SET SvcDisplayName="Long Running Service"
SET SvcDescription="Long Running Service"
SC QUERY %SvcName% > NUL
IF ERRORLEVEL 1060 GOTO MISSING
ECHO EXISTS
SC QUERYEX %SvcName% | FIND "STATE" | FIND /v "RUNNING" > NUL && (
    ECHO %SvcName% is not running
) || (
    ECHO %SvcName% is running
	sc stop %SvcName%
	ECHO %SvcName% is stopped
)
sc delete %SvcName%
ECHO %SvcName% is deleted
GOTO CREATENEW
GOTO END

:MISSING
ECHO SERVICE MISSING
GOTO CREATENEW
GOTO END

:CREATENEW
set currpath=%~dp0
sc create %SvcName% DisplayName=%SvcDisplayName% start= auto binPath= "%currpath%LongRunningService.exe"
sc description %SvcName% %SvcDescription%
sc start %SvcName%

:END
