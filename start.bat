@echo off
title Neon Ninja Game Launcher
color 0b
echo ======================================================
echo             NEON NINJA - GAME LAUNCHER                
echo ======================================================
echo.
echo Checking Node.js installation...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    color 0c
    echo [ERROR] Node.js is not installed on this machine!
    echo Please install Node.js from https://nodejs.org/ first.
    echo.
    pause
    exit /b
)

echo [OK] Node.js is ready.
echo.
echo Launching server...
echo ------------------------------------------------------
node server.js
if %errorlevel% neq 0 (
    color 0c
    echo.
    echo [ERROR] Server crashed or closed unexpectedly.
    echo.
)
pause
