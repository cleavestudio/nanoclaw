@echo off
echo Refreshing ClickUp OAuth token...
echo This will open a browser for authentication.
echo.
npx -y mcp-remote https://mcp.clickup.com/mcp
echo.
echo Token refreshed! Restart NanoClaw to apply.
pause
