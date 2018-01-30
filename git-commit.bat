	@if not "%ECHO%"=="on" echo off
	title %0
	set LOG=%TEMP%\%~n0.log
	set A=%1
	echo A %A%
	cd /d %~dp0

	echo %DATE% %TIME%
	echo %DATE% %TIME% > %LOG%

    call delete-html.bat

	which git
	echo "diff wc -l"
	git diff | wc -l

	echo git add .
	git add .
    echo EL %ERRORLEVEL%
	if errorlevel 1 goto error

	echo git commit
	git commit -m "commit-daily %USERDOMAIN%" .
	rem if errorlevel 1 goto error

	echo git log
	git log | head >> %LOG%
    echo EL %ERRORLEVEL%

    echo git pull
    git pull
    echo EL %ERRORLEVEL%
	if errorlevel 1 goto error

	echo git push
	git push >> %LOG%
    echo EL %ERRORLEVEL%

	rem start %LOG%
	echo TODO growl

	goto finally

:error
	echo error
	goto finally

:finally
	rem タスクマネージャから実行する場合、 exit する。
	if "%A%"=="1" exit
