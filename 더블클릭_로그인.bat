@echo off
chcp 65001 > nul
title [easy-deploy-kit] 3대 플랫폼 브라우저 원클릭 로그인
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0login.ps1"
