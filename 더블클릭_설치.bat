@echo off
chcp 65001 > nul
title [easy-deploy-kit] 필수 도구 자동 설치
echo ========================================================
echo  🚀 Windows 10/11 필수 CLI 도구 자동 설치를 시작합니다.
echo ========================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
echo.
pause
