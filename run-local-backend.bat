@echo off
title Neon Ninja - Local Backend Server
color 0B

echo ===================================================
echo               NEON NINJA BACKEND
echo        Local WebSocket / Socket.IO Server
echo ===================================================
echo.

:: Check if running from root and backend folder exists
if not exist "backend" (
    echo [ERROR] Could not find "backend" directory. 
    echo Please make sure this file is in the project root directory.
    pause
    exit /b
)

cd backend

:: Check if node_modules exists, if not install dependencies
if not exist "node_modules" (
    echo [INFO] node_modules not found. Installing dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo [ERROR] npm install failed. Please install Node.js and try again.
        pause
        exit /b
    )
)

echo.
echo [SUCCESS] Dependencies verified. Starting server...
echo.
node server.js

pause
