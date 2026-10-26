@echo off
setlocal

rem Creates the aurelia_fc_v2 database and loads the seed data.
rem Usage:  setup.cmd [path-to-mysql.exe]
rem Password: set MYSQL_PWD in the environment, or create a ~/.my.cnf.

set "MYSQL=%~1"
if "%MYSQL%"=="" if defined MYSQL_EXE set "MYSQL=%MYSQL_EXE%"
if "%MYSQL%"=="" set "MYSQL=mysql"

echo Creating aurelia_fc_v2 from schema.sql ...
"%MYSQL%" -u root -h 127.0.0.1 --default-character-set=utf8mb4 < "%~dp0schema.sql"
if errorlevel 1 goto :fail

echo Loading seed data from data.sql ...
"%MYSQL%" -u root -h 127.0.0.1 --default-character-set=utf8mb4 < "%~dp0data.sql"
if errorlevel 1 goto :fail

echo.
echo Done. Database aurelia_fc_v2 is ready.
exit /b 0

:fail
echo.
echo Setup failed. Check that MySQL is running and root can connect.
exit /b 1
