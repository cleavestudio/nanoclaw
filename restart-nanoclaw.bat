@echo off
setlocal
cd /d "%~dp0"
call stop-nanoclaw.bat
timeout /t 2 /nobreak >nul
call start-nanoclaw.bat
