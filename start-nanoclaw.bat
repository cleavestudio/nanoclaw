@echo off
setlocal
cd /d "%~dp0"

:: Kill existing NanoClaw if running
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3001" ^| findstr "LISTENING"') do (
    echo Stopping existing NanoClaw (PID %%a)...
    taskkill /PID %%a /F >nul 2>&1
)
timeout /t 2 /nobreak >nul

:: Build TypeScript
echo Building...
call npm run build >nul 2>&1
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

:: Start in background, log to file
echo Starting NanoClaw...
start /B "" node dist/index.js > logs\nanoclaw.log 2>&1

:: Wait and verify
timeout /t 5 /nobreak >nul
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3001" ^| findstr "LISTENING"') do (
    echo NanoClaw running (PID %%a)
    echo Logs: logs\nanoclaw.log
    exit /b 0
)
echo Failed to start! Check logs\nanoclaw.log
exit /b 1
