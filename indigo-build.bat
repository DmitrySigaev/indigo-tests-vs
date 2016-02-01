@ECHO ON
@SET me=%~n0
@REM create a log file named [script].YYYYMMDDHHMMSS.txt
::@SET log=%cd%\%me%.%DATE:~10,4%_%DATE:~4,2%_%DATE:~7,2%%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%.txt
@SET log=%cd%\%me%.log
:: The "main" logic of the script
@IF EXIST "%log%" DELETE /Q %log% >NUL


@echo python --version  >>%log% 2>&1
python --version >>%log% 2>&1 || ECHO failed with return code %ERRORLEVEL%

@echo cmake --version  >>%log% 2>&1
cmake --version >>%log% 2>&1 || ECHO failed with return code %ERRORLEVEL%

cd Indigo
python ./build_scripts/indigo-release-libs.py --preset=win64-2013  >>%log% 2>&1 || ECHO failed with return code %ERRORLEVEL%


@echo Check Build dll >>%log% 2>&1

"%VS140COMNTOOLS%"..\..\VC\bin\dumpbin.exe .\indigo-node\shared\win32\x64\indigo.dll >>%log% 2>&1

@type %log% 2>&1


call :echos %node --version%


:: function
:echos
echo %*
EXIT /B 0
