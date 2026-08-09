@echo off
title Deploy Production - Neon Ninja
color 0b
echo ======================================================
echo             NEON NINJA - DUAL DEPLOYMENT              
echo ======================================================
echo.

echo 1. DEPLOYING FRONTEND (Ninja-Fruit-Game)...
echo ------------------------------------------------------
git add .
git commit -m "Production update: Desktop application frontend"
git push -u origin master --force
git push -u origin master:main --force
echo.

echo 2. DEPLOYING BACKEND (Fruit-Ninja-backend)...
echo ------------------------------------------------------
cd backend
git add .
git commit -m "Fix backend port binding and main.js redirect on Render"
git push -u origin master --force
git push -u origin master:main --force
cd ..
echo.

if %errorlevel% equ 0 (
    color 0a
    echo ======================================================
    echo [SUCCESS] Frontend & Backend pushed successfully!
    echo Vercel and Render/Railway are rebuilding in the background.
    echo Please wait 1-2 minutes, then refresh Vercel and play!
    echo ======================================================
) else (
    color 0c
    echo ======================================================
    echo [ERROR] Deployment failed. Check your connection/credentials.
    echo ======================================================
)
echo.
pause
