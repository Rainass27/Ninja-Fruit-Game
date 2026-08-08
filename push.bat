@echo off
title Push to GitHub
color 0b
echo ======================================================
echo             NEON NINJA - PUSH TO GITHUB               
echo ======================================================
echo.

:: Check if Git is initialized
if not exist ".git" (
    echo [INFO] Git not found. Initializing Git repository...
    git init
    echo.
    echo [INFO] Linking to GitHub repository...
    git remote add origin https://github.com/Rainass27/Ninja-Fruit-Game.git
    git branch -M main
    echo.
)

echo 1. Staging updated files (git add)...
git add .
echo.

echo 2. Committing changes (git commit)...
git commit -m "Fix production Vercel socket connections and update lobby mockup cover"
echo.

echo 3. Pushing changes to GitHub (git push)...
git push -u origin main --force
echo.

if %errorlevel% equ 0 (
    color 0a
    echo ======================================================
    echo [SUCCESS] Code uploaded successfully to GitHub!
    echo Vercel and Railway are now rebuilding in the background.
    echo Wait about 30-40 seconds, then refresh your browser and play!
    echo ======================================================
) else (
    color 0c
    echo ======================================================
    echo [ERROR] Git push failed.
    echo Please make sure you are connected to the internet and logged in.
    echo ======================================================
)
echo.
pause
