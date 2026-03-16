#!/bin/bash
cd "$(dirname "$0")"

# Kill existing NanoClaw if running
PID=$(powershell -Command "(Get-NetTCPConnection -LocalPort 3001 -ErrorAction SilentlyContinue).OwningProcess" 2>/dev/null | head -1)
if [ -n "$PID" ] && [ "$PID" != "" ]; then
    echo "Stopping existing NanoClaw (PID $PID)..."
    kill "$PID" 2>/dev/null || taskkill //PID "$PID" //F 2>/dev/null
    sleep 2
fi

# Build
echo "Building..."
npm run build > /dev/null 2>&1 || { echo "Build failed!"; exit 1; }

# Start in background
echo "Starting NanoClaw..."
node dist/index.js > logs/nanoclaw.log 2>&1 &
NCPID=$!
sleep 5

if kill -0 "$NCPID" 2>/dev/null; then
    echo "NanoClaw running (PID $NCPID)"
    echo "Logs: logs/nanoclaw.log"
else
    echo "Failed to start! Check logs/nanoclaw.log"
    exit 1
fi
