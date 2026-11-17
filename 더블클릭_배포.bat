@echo off
chcp 65001 > nul
title [easy-deploy-kit] 원클릭 배포 (GitHub + Vercel + Cloudflare)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1"
echo.
pause
