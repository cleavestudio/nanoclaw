@echo off
setlocal
echo Stopping NanoClaw...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3001" ^| findstr "LISTENING"') do (
    taskkill /PID %%a /F >nul 2>&1
    echo Stopped (PID %%a)
    exit /b 0
)
echo NanoClaw is not running.
